; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt -attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=3 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_NPM,NOT_CGSCC_OPM,NOT_TUNIT_NPM,IS__TUNIT____,IS________OPM,IS__TUNIT_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=3 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_OPM,NOT_CGSCC_NPM,NOT_TUNIT_OPM,IS__TUNIT____,IS________NPM,IS__TUNIT_NPM
; RUN: opt -attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_NPM,IS__CGSCC____,IS________OPM,IS__CGSCC_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_OPM,IS__CGSCC____,IS________NPM,IS__CGSCC_NPM

; IS__TUNIT____: Function Attrs: nofree nosync nounwind readnone willreturn
; IS__CGSSA____: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
define i32 @leaf() {
; CHECK-LABEL: define {{[^@]+}}@leaf()
; CHECK-NEXT:    ret i32 1
;
  ret i32 1
}

; CHECK: Function Attrs
; CHECK-SAME: readnone
; CHECK-NOT: norecurse
define i32 @self_rec() {
; CHECK-LABEL: define {{[^@]+}}@self_rec()
; CHECK-NEXT:    unreachable
;
  %a = call i32 @self_rec()
  ret i32 4
}

; CHECK: Function Attrs
; CHECK-SAME: readnone
; CHECK-NOT: norecurse
define i32 @indirect_rec() {
; CHECK-LABEL: define {{[^@]+}}@indirect_rec()
; CHECK-NEXT:    unreachable
;
  %a = call i32 @indirect_rec2()
  ret i32 %a
}
; CHECK: Function Attrs
; CHECK-SAME: readnone
; CHECK-NOT: norecurse
define i32 @indirect_rec2() {
; CHECK-LABEL: define {{[^@]+}}@indirect_rec2()
; CHECK-NEXT:    unreachable
;
  %a = call i32 @indirect_rec()
  ret i32 %a
}

; CHECK: Function Attrs
; CHECK-SAME: readnone
; CHECK-NOT: norecurse
define i32 @extern() {
; CHECK-LABEL: define {{[^@]+}}@extern()
; CHECK-NEXT:    [[A:%.*]] = call i32 @k()
; CHECK-NEXT:    ret i32 [[A]]
;
  %a = call i32 @k()
  ret i32 %a
}

; CHECK: Function Attrs
; CHECK-NEXT: declare i32 @k()
declare i32 @k() readnone

; CHECK: Function Attrs
; CHECK-NOT: norecurse
define void @intrinsic(i8* %dest, i8* %src, i32 %len) {
; CHECK-LABEL: define {{[^@]+}}@intrinsic
; CHECK-SAME: (i8* nocapture writeonly [[DEST:%.*]], i8* nocapture readonly [[SRC:%.*]], i32 [[LEN:%.*]])
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i32(i8* noalias nocapture writeonly [[DEST]], i8* noalias nocapture readonly [[SRC]], i32 [[LEN]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %dest, i8* %src, i32 %len, i1 false)
  ret void
}

; CHECK: Function Attrs
; CHECK-NEXT: declare void @llvm.memcpy.p0i8.p0i8.i32
declare void @llvm.memcpy.p0i8.p0i8.i32(i8*, i8*, i32, i1)

; IS__TUNIT____: Function Attrs
; IS__TUNIT____-SAME: nosync readnone
; IS__CGSSA____: Function Attrs
; IS__CGSSA____-SAME: norecurse nosync readnone
define internal i32 @called_by_norecurse() {
; CHECK-LABEL: define {{[^@]+}}@called_by_norecurse()
; CHECK-NEXT:    [[A:%.*]] = call i32 @k()
; CHECK-NEXT:    ret i32 undef
;
  %a = call i32 @k()
  ret i32 %a
}
; CHECK: Function Attrs
define void @m() norecurse {
; CHECK-LABEL: define {{[^@]+}}@m()
; CHECK-NEXT:    [[A:%.*]] = call i32 @called_by_norecurse()
; CHECK-NEXT:    ret void
;
  %a = call i32 @called_by_norecurse()
  ret void
}

; CHECK: Function Attrs
; FIXME: norecurse missing
; CHECK-SAME: nosync readnone
define internal i32 @called_by_norecurse_indirectly() {
; CHECK-LABEL: define {{[^@]+}}@called_by_norecurse_indirectly()
; CHECK-NEXT:    [[A:%.*]] = call i32 @k()
; CHECK-NEXT:    ret i32 [[A]]
;
  %a = call i32 @k()
  ret i32 %a
}
; IS__TUNIT____: Function Attrs
; IS__TUNIT____-SAME: nosync readnone
; IS__CGSSA____: Function Attrs
; IS__CGSSA____-SAME: norecurse nosync readnone
define internal i32 @o() {
; CHECK-LABEL: define {{[^@]+}}@o()
; CHECK-NEXT:    [[A:%.*]] = call i32 @called_by_norecurse_indirectly()
; CHECK-NEXT:    ret i32 [[A]]
;
  %a = call i32 @called_by_norecurse_indirectly()
  ret i32 %a
}
define i32 @p() norecurse {
; CHECK-LABEL: define {{[^@]+}}@p()
; CHECK-NEXT:    [[A:%.*]] = call i32 @o()
; CHECK-NEXT:    ret i32 [[A]]
;
  %a = call i32 @o()
  ret i32 %a
}

; CHECK: Function Attrs: nofree nosync nounwind
define void @f(i32 %x)  {
; CHECK-LABEL: define {{[^@]+}}@f
; CHECK-SAME: (i32 [[X:%.*]])
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[X_ADDR:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 [[X]], i32* [[X_ADDR]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[X_ADDR]], align 4
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp ne i32 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    call void @g()
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %x.addr = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  %0 = load i32, i32* %x.addr, align 4
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:
  call void @g() norecurse
  br label %if.end

if.end:
  ret void
}

define void @g() norecurse {
; CHECK-LABEL: define {{[^@]+}}@g()
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @f(i32 0)
; CHECK-NEXT:    ret void
;
entry:
  call void @f(i32 0)
  ret void
}

; CHECK-NOT: Function Attrs
define linkonce_odr i32 @leaf_redefinable() {
; CHECK-LABEL: define {{[^@]+}}@leaf_redefinable()
; CHECK-NEXT:    ret i32 1
;
  ret i32 1
}

; Call through a function pointer
; CHECK-NOT: Function Attrs
define i32 @eval_func1(i32 (i32)* , i32) local_unnamed_addr {
; CHECK-LABEL: define {{[^@]+}}@eval_func1
; CHECK-SAME: (i32 (i32)* nocapture nofree nonnull [[TMP0:%.*]], i32 [[TMP1:%.*]]) local_unnamed_addr
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i32 [[TMP0]](i32 [[TMP1]])
; CHECK-NEXT:    ret i32 [[TMP3]]
;
  %3 = tail call i32 %0(i32 %1) #2
  ret i32 %3
}

; CHECK-NOT: Function Attrs
define i32 @eval_func2(i32 (i32)* , i32) local_unnamed_addr "null-pointer-is-valid"="true"{
; CHECK-LABEL: define {{[^@]+}}@eval_func2
; CHECK-SAME: (i32 (i32)* nocapture nofree [[TMP0:%.*]], i32 [[TMP1:%.*]]) local_unnamed_addr
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i32 [[TMP0]](i32 [[TMP1]])
; CHECK-NEXT:    ret i32 [[TMP3]]
;
  %3 = tail call i32 %0(i32 %1) #2
  ret i32 %3
}

; Call an unknown function in a dead block.
; CHECK_NPM: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
declare void @unknown()
define i32 @call_unknown_in_dead_block() local_unnamed_addr {
; CHECK-LABEL: define {{[^@]+}}@call_unknown_in_dead_block() local_unnamed_addr
; CHECK-NEXT:    ret i32 0
; CHECK:       Dead:
; CHECK-NEXT:    unreachable
;
  ret i32 0
Dead:
  tail call void @unknown()
  ret i32 1
}

