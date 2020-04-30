include(AddLLVM)
include(LLVMExternalProjectUtils)


function(llvm_create_cross_target project_name target_name toolchain buildtype)

  if(NOT DEFINED ${project_name}_${target_name}_BUILD)
    set(${project_name}_${target_name}_BUILD
      "${CMAKE_CURRENT_BINARY_DIR}/${target_name}")
    set(${project_name}_${target_name}_BUILD
      ${${project_name}_${target_name}_BUILD} PARENT_SCOPE)
    message(STATUS "Setting native build dir to " ${${project_name}_${target_name}_BUILD})
  endif(NOT DEFINED ${project_name}_${target_name}_BUILD)

  if (EXISTS ${LLVM_MAIN_SRC_DIR}/cmake/platforms/${toolchain}.cmake)
    set(CROSS_TOOLCHAIN_FLAGS_INIT
      -DCMAKE_TOOLCHAIN_FILE=\"${LLVM_MAIN_SRC_DIR}/cmake/platforms/${toolchain}.cmake\")
  else()
    set(CROSS_TOOLCHAIN_FLAGS_INIT
      -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
      -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
      )
  endif()
  set(CROSS_TOOLCHAIN_FLAGS_${target_name} ${CROSS_TOOLCHAIN_FLAGS_INIT}
    CACHE STRING "Toolchain configuration for ${target_name}")

  # project specific version of the flags up above
  set(CROSS_TOOLCHAIN_FLAGS_${project_name}_${target_name} ""
    CACHE STRING "Toolchain configuration for ${Pproject_name}_${target_name}")

  if (buildtype)
    set(build_type_flags "-DCMAKE_BUILD_TYPE=${buildtype}")
  endif()
  if (LLVM_USE_LINKER AND NOT CMAKE_CROSSCOMPILING)
    set(linker_flag "-DLLVM_USE_LINKER=${LLVM_USE_LINKER}")
  endif()
  if (LLVM_EXTERNAL_CLANG_SOURCE_DIR)
    # Propagate LLVM_EXTERNAL_CLANG_SOURCE_DIR so that clang-tblgen can be built
    set(external_clang_dir "-DLLVM_EXTERNAL_CLANG_SOURCE_DIR=${LLVM_EXTERNAL_CLANG_SOURCE_DIR}")
  endif()

  add_custom_command(OUTPUT ${${project_name}_${target_name}_BUILD}
    COMMAND ${CMAKE_COMMAND} -E make_directory ${${project_name}_${target_name}_BUILD}
    COMMENT "Creating ${${project_name}_${target_name}_BUILD}...")

  add_custom_target(CREATE_${project_name}_${target_name}
    DEPENDS ${${project_name}_${target_name}_BUILD})

  # Escape semicolons in the targets list so that cmake doesn't expand
  # them to spaces.
  string(REPLACE ";" "$<SEMICOLON>" targets_to_build_arg
         "${LLVM_TARGETS_TO_BUILD}")
  string(REPLACE ";" "$<SEMICOLON>" experimental_targets_to_build_arg
         "${LLVM_EXPERIMENTAL_TARGETS_TO_BUILD}")

  string(REPLACE ";" "$<SEMICOLON>" llvm_enable_projects_arg
         "${LLVM_ENABLE_PROJECTS}")
  string(REPLACE ";" "$<SEMICOLON>" llvm_external_projects_arg
         "${LLVM_EXTERNAL_PROJECTS}")

  set(external_project_source_dirs)
  foreach(project ${LLVM_EXTERNAL_PROJECTS})
    canonicalize_tool_name(${project} name)
    list(APPEND external_project_source_dirs
         "-DLLVM_EXTERNAL_${name}_SOURCE_DIR=${LLVM_EXTERNAL_${name}_SOURCE_DIR}")
  endforeach()

  add_custom_command(OUTPUT ${${project_name}_${target_name}_BUILD}/CMakeCache.txt
    COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}"
        -DCMAKE_MAKE_PROGRAM="${CMAKE_MAKE_PROGRAM}"
        ${CROSS_TOOLCHAIN_FLAGS_${target_name}} ${CMAKE_CURRENT_SOURCE_DIR}
        ${CROSS_TOOLCHAIN_FLAGS_${project_name}_${target_name}}
        -DLLVM_TARGET_IS_CROSSCOMPILE_HOST=TRUE
        -DLLVM_TARGETS_TO_BUILD="${targets_to_build_arg}"
        -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="${experimental_targets_to_build_arg}"
        -DLLVM_DEFAULT_TARGET_TRIPLE="${TARGET_TRIPLE}"
        -DLLVM_TARGET_ARCH="${LLVM_TARGET_ARCH}"
        -DLLVM_ENABLE_PROJECTS="${llvm_enable_projects_arg}"
        -DLLVM_EXTERNAL_PROJECTS="${llvm_external_projects_arg}"
        ${external_project_source_dirs}
        -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN="${LLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN}"
        ${build_type_flags} ${linker_flag} ${external_clang_dir}
        ${ARGN}
    WORKING_DIRECTORY ${${project_name}_${target_name}_BUILD}
    DEPENDS CREATE_${project_name}_${target_name}
    COMMENT "Configuring ${target_name} ${project_name}...")

  add_custom_target(CONFIGURE_${project_name}_${target_name}
    DEPENDS ${${project_name}_${target_name}_BUILD}/CMakeCache.txt)

endfunction()

# Sets up a native build for a tool, used e.g. for cross-compilation and
# LLVM_OPTIMIZED_TABLEGEN. Always builds in Release.
# - target: The target to build natively
# - output_path_var: A variable name which receives the path to the built target
# - DEPENDS: Any additional dependencies for the target
function(build_native_tool target output_path_var)
  cmake_parse_arguments(ARG "" "" "DEPENDS" ${ARGN})

  if(CMAKE_CONFIGURATION_TYPES)
    set(output_path "${${PROJECT_NAME}_NATIVE_BUILD}/Release/bin/${target}")
  else()
    set(output_path "${${PROJECT_NAME}_NATIVE_BUILD}/bin/${target}")
  endif()

  llvm_ExternalProject_BuildCmd(build_cmd ${target} ${${PROJECT_NAME}_NATIVE_BUILD}
                                CONFIGURATION Release)
  add_custom_command(OUTPUT "${output_path}"
                     COMMAND ${build_cmd}
                     DEPENDS CONFIGURE_${PROJECT_NAME}_NATIVE ${ARG_DEPENDS}
                     WORKING_DIRECTORY "${${PROJECT_NAME}_NATIVE_BUILD}"
                     COMMENT "Building native ${target}..."
                     USES_TERMINAL)
  set(${output_path_var} "${output_path}" PARENT_SCOPE)
endfunction()
