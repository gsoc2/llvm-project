function(add_lldb_library name)
  # only supported parameters to this macro are the optional
  # MODULE;SHARED;STATIC library type and source files
  cmake_parse_arguments(PARAM
    "MODULE;SHARED;STATIC;OBJECT;PLUGIN"
    "ENTITLEMENTS"
    "EXTRA_CXXFLAGS;DEPENDS;LINK_LIBS;LINK_COMPONENTS"
    ${ARGN})
  llvm_process_sources(srcs ${PARAM_UNPARSED_ARGUMENTS})
  list(APPEND LLVM_LINK_COMPONENTS ${PARAM_LINK_COMPONENTS})

  if(PARAM_PLUGIN)
    set_property(GLOBAL APPEND PROPERTY LLDB_PLUGINS ${name})
  endif()

  if (MSVC_IDE OR XCODE)
    string(REGEX MATCHALL "/[^/]+" split_path ${CMAKE_CURRENT_SOURCE_DIR})
    list(GET split_path -1 dir)
    file(GLOB_RECURSE headers
      ../../include/lldb${dir}/*.h)
    set(srcs ${srcs} ${headers})
  endif()
  if (PARAM_MODULE)
    set(libkind MODULE)
  elseif (PARAM_SHARED)
    set(libkind SHARED)
  elseif (PARAM_OBJECT)
    set(libkind OBJECT)
  else ()
    # PARAM_STATIC or library type unspecified. BUILD_SHARED_LIBS
    # does not control the kind of libraries created for LLDB,
    # only whether or not they link to shared/static LLVM/Clang
    # libraries.
    set(libkind STATIC)
  endif()

  #PIC not needed on Win
  # FIXME: Setting CMAKE_CXX_FLAGS here is a no-op, use target_compile_options
  # or omit this logic instead.
  if (NOT WIN32)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
  endif()

  if (PARAM_OBJECT)
    add_library(${name} ${libkind} ${srcs})
  else()
    if(PARAM_ENTITLEMENTS)
      set(pass_ENTITLEMENTS ENTITLEMENTS ${PARAM_ENTITLEMENTS})
    endif()

    if(LLDB_NO_INSTALL_DEFAULT_RPATH)
      set(pass_NO_INSTALL_RPATH NO_INSTALL_RPATH)
    endif()

    llvm_add_library(${name} ${libkind} ${srcs}
      LINK_LIBS ${PARAM_LINK_LIBS}
      DEPENDS ${PARAM_DEPENDS}
      ${pass_ENTITLEMENTS}
      ${pass_NO_INSTALL_RPATH}
    )

    if (${name} STREQUAL "liblldb")
      if (PARAM_SHARED)
        if(${name} STREQUAL "liblldb" AND LLDB_BUILD_FRAMEWORK)
          if(LLDB_FRAMEWORK_INSTALL_DIR)
            set(install_dir ${LLDB_FRAMEWORK_INSTALL_DIR})
          else()
            set(install_dir ".")
          endif()
        else()
          set(install_dir lib${LLVM_LIBDIR_SUFFIX})
        endif()
        install(TARGETS ${name}
          COMPONENT ${name}
          RUNTIME DESTINATION bin
          LIBRARY DESTINATION ${install_dir}
          ARCHIVE DESTINATION ${install_dir})
      else()
        install(TARGETS ${name}
          COMPONENT ${name}
          LIBRARY DESTINATION lib${LLVM_LIBDIR_SUFFIX}
          ARCHIVE DESTINATION lib${LLVM_LIBDIR_SUFFIX})
      endif()
      if (NOT CMAKE_CONFIGURATION_TYPES)
        add_llvm_install_targets(install-${name}
                                 DEPENDS ${name}
                                 COMPONENT ${name})
      endif()
    endif()
  endif()


  # Hack: only some LLDB libraries depend on the clang autogenerated headers,
  # but it is simple enough to make all of LLDB depend on some of those
  # headers without negatively impacting much of anything.
  if(NOT LLDB_BUILT_STANDALONE)
    add_dependencies(${name} clang-tablegen-targets)
  endif()

  # Add in any extra C++ compilation flags for this library.
  target_compile_options(${name} PRIVATE ${PARAM_EXTRA_CXXFLAGS})

  set_target_properties(${name} PROPERTIES FOLDER "lldb libraries")
endfunction(add_lldb_library)

function(add_lldb_executable name)
  cmake_parse_arguments(ARG
    "GENERATE_INSTALL"
    "ENTITLEMENTS"
    "LINK_LIBS;LINK_COMPONENTS"
    ${ARGN}
    )

  if(ARG_ENTITLEMENTS)
    set(pass_ENTITLEMENTS ENTITLEMENTS ${ARG_ENTITLEMENTS})
  endif()

  if(LLDB_NO_INSTALL_DEFAULT_RPATH)
    set(pass_NO_INSTALL_RPATH NO_INSTALL_RPATH)
  endif()

  list(APPEND LLVM_LINK_COMPONENTS ${ARG_LINK_COMPONENTS})
  add_llvm_executable(${name}
    ${pass_ENTITLEMENTS}
    ${pass_NO_INSTALL_RPATH}
    ${ARG_UNPARSED_ARGUMENTS}
  )

  target_link_libraries(${name} PRIVATE ${ARG_LINK_LIBS})
  set_target_properties(${name} PROPERTIES FOLDER "lldb executables")

  if(ARG_GENERATE_INSTALL)
    install(TARGETS ${name}
            COMPONENT ${name}
            RUNTIME DESTINATION bin)
    if (NOT CMAKE_CONFIGURATION_TYPES)
      add_llvm_install_targets(install-${name}
                               DEPENDS ${name}
                               COMPONENT ${name})
    endif()
  endif()
endfunction(add_lldb_executable)


macro(add_lldb_tool_subdirectory name)
  add_llvm_subdirectory(LLDB TOOL ${name})
endmacro()

function(add_lldb_tool name)
  add_lldb_executable(${name} GENERATE_INSTALL ${ARGN})
endfunction()

# Support appending linker flags to an existing target.
# This will preserve the existing linker flags on the
# target, if there are any.
function(lldb_append_link_flags target_name new_link_flags)
  # Retrieve existing linker flags.
  get_target_property(current_link_flags ${target_name} LINK_FLAGS)

  # If we had any linker flags, include them first in the new linker flags.
  if(current_link_flags)
    set(new_link_flags "${current_link_flags} ${new_link_flags}")
  endif()

  # Now set them onto the target.
  set_target_properties(${target_name} PROPERTIES LINK_FLAGS ${new_link_flags})
endfunction()

# For tools that depend on liblldb, account for varying directory structures in
# which LLDB.framework can be used and distributed: In the build-tree we find it
# by its absolute target path. This is only relevant for running the test suite.
# In the install step CMake will remove this entry and insert the final RPATHs.
# These are relative to the file path from where the tool will be loaded on the
# enduser system.
#
# Note that the LLVM install-tree doesn't match the enduser system structure
# for LLDB.framework, so by default dependent tools will not be functional in
# their install location. The LLDB_FRAMEWORK_INSTALL_DIR variable allows to fix
# this. If specified, it causes the install-tree location of the framework to be
# added as an extra RPATH below.
#
function(lldb_setup_framework_rpaths_in_tool name)
  # In the build-tree, we know the exact path to the binary in the framework.
  set(rpath_build_tree "$<TARGET_FILE:liblldb>")

  # The installed framework is relocatable and can be in different locations.
  set(rpaths_install_tree "@loader_path/../../../SharedFrameworks")
  list(APPEND rpaths_install_tree "@loader_path/../../System/Library/PrivateFrameworks")
  list(APPEND rpaths_install_tree "@loader_path/../../Library/PrivateFrameworks")

  if(LLDB_FRAMEWORK_INSTALL_DIR)
    set(rpaths_install_tree "@loader_path/../${LLDB_FRAMEWORK_INSTALL_DIR}")
  endif()

  # If LLDB_NO_INSTALL_DEFAULT_RPATH was NOT enabled (default), this overwrites
  # the default settings from llvm_setup_rpath().
  set_target_properties(${name} PROPERTIES
    BUILD_WITH_INSTALL_RPATH OFF
    BUILD_RPATH "${rpath_build_tree}"
    INSTALL_RPATH "${rpaths_install_tree}"
  )

  add_dependencies(${name} lldb-framework)
endfunction()
