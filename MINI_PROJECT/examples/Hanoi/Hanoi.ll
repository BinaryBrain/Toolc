; ModuleID = 'Hanoi.tool'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-macosx"

%struct.$IntArray = type <{ i32*, i32 }>
%struct._List = type <{ %struct._List*, i8* }>
@l = global %struct._List* null, align 8

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@.str2 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str3 = private unnamed_addr constant [5 x i8] c"true\00"
@.str4 = private unnamed_addr constant [6 x i8] c"false\00"
@.str5 = private unnamed_addr constant [10 x i8] c"Error !!!\00"
@.str6 = private unnamed_addr constant [10 x i8] c"Error !!!\00"
@.str7 = private unnamed_addr constant [9 x i8] c"Done in \00"
@.str8 = private unnamed_addr constant [8 x i8] c" steps.\00"
@.str9 = private unnamed_addr constant [10 x i8] c"Error !!!\00"
@.str10 = private unnamed_addr constant [5 x i8] c"A = \00"
@.str11 = private unnamed_addr constant [5 x i8] c"B = \00"
@.str12 = private unnamed_addr constant [5 x i8] c"C = \00"
@.str13 = private unnamed_addr constant [22 x i8] c"---------------------\00"
@.str14 = private unnamed_addr constant [1 x i8] c"\00"
@.str15 = private unnamed_addr constant [2 x i8] c" \00"
@.str16 = private unnamed_addr constant [1 x i8] c"\00"
@.str17 = private unnamed_addr constant [3 x i8] c"Ok\00"
@.str18 = private unnamed_addr constant [6 x i8] c"error\00"

%struct.HanoiPresenter = type <{ %struct.HanoiPresenter$vtable*, %struct.Tower*, %struct.Tower*, %struct.Tower*, i32 }>
%struct.HanoiPresenter$vtable = type { i1 (%struct.HanoiPresenter*)* , i1 (%struct.HanoiPresenter*, %struct.Tower*, %struct.Tower*)* , i1 (%struct.HanoiPresenter*, i32, %struct.Tower*, %struct.Tower*, %struct.Tower*)* , %struct.Ring* (%struct.HanoiPresenter*, i32)* , i1 (%struct.HanoiPresenter*)* }
@HanoiPresenter$vtable = global %struct.HanoiPresenter$vtable { i1 (%struct.HanoiPresenter*)* @HanoiPresenter$play , i1 (%struct.HanoiPresenter*, %struct.Tower*, %struct.Tower*)* @HanoiPresenter$mvRing2 , i1 (%struct.HanoiPresenter*, i32, %struct.Tower*, %struct.Tower*, %struct.Tower*)* @HanoiPresenter$mvRing , %struct.Ring* (%struct.HanoiPresenter*, i32)* @HanoiPresenter$generateRings , i1 (%struct.HanoiPresenter*)* @HanoiPresenter$printAll }, align 8


%struct.Ring = type <{ %struct.Ring$vtable*, i32, %struct.Ring* }>
%struct.Ring$vtable = type { i1 (%struct.Ring*)* , %struct.Ring* (%struct.Ring*, i32, %struct.Ring*)* , i8* (%struct.Ring*)* , %struct.Ring* (%struct.Ring*, %struct.Ring*)* , %struct.Ring* (%struct.Ring*)* }
@Ring$vtable = global %struct.Ring$vtable { i1 (%struct.Ring*)* @Ring$isLeaf , %struct.Ring* (%struct.Ring*, i32, %struct.Ring*)* @Ring$init , i8* (%struct.Ring*)* @Ring$print , %struct.Ring* (%struct.Ring*, %struct.Ring*)* @Ring$push , %struct.Ring* (%struct.Ring*)* @Ring$pop }, align 8


%struct.LeafRing = type <{ %struct.LeafRing$vtable*, i32, %struct.Ring* }>
%struct.LeafRing$vtable = type { i1 (%struct.LeafRing*)* , %struct.Ring* (%struct.LeafRing*, i32, %struct.Ring*)* , i8* (%struct.LeafRing*)* , %struct.Ring* (%struct.LeafRing*, %struct.Ring*)* , %struct.Ring* (%struct.LeafRing*)* }
@LeafRing$vtable = global %struct.LeafRing$vtable { i1 (%struct.LeafRing*)* @LeafRing$isLeaf , %struct.Ring* (%struct.LeafRing*, i32, %struct.Ring*)* bitcast (%struct.Ring* (%struct.Ring*, i32, %struct.Ring*)* @Ring$init to %struct.Ring* (%struct.LeafRing*, i32, %struct.Ring*)*), i8* (%struct.LeafRing*)* @LeafRing$print , %struct.Ring* (%struct.LeafRing*, %struct.Ring*)* bitcast (%struct.Ring* (%struct.Ring*, %struct.Ring*)* @Ring$push to %struct.Ring* (%struct.LeafRing*, %struct.Ring*)*), %struct.Ring* (%struct.LeafRing*)* bitcast (%struct.Ring* (%struct.Ring*)* @Ring$pop to %struct.Ring* (%struct.LeafRing*)*)}, align 8


%struct.Tower = type <{ %struct.Tower$vtable*, %struct.Ring* }>
%struct.Tower$vtable = type { %struct.Tower* (%struct.Tower*, %struct.Ring*)* , i1 (%struct.Tower*, %struct.Ring*)* , %struct.Ring* (%struct.Tower*)* , i8* (%struct.Tower*)* }
@Tower$vtable = global %struct.Tower$vtable { %struct.Tower* (%struct.Tower*, %struct.Ring*)* @Tower$init , i1 (%struct.Tower*, %struct.Ring*)* @Tower$push , %struct.Ring* (%struct.Tower*)* @Tower$pop , i8* (%struct.Tower*)* @Tower$print }, align 8

define %struct.HanoiPresenter* @new$HanoiPresenter() nounwind ssp {
    %obj = alloca %struct.HanoiPresenter*, align 8
    %1 = call i8* @_mymalloc(i64 36)
    %2 = bitcast i8* %1 to %struct.HanoiPresenter*
    store %struct.HanoiPresenter* %2, %struct.HanoiPresenter** %obj, align 8
    %3 = load %struct.HanoiPresenter** %obj, align 8
    %4 = getelementptr inbounds %struct.HanoiPresenter* %3, i32 0, i32 0
    store %struct.HanoiPresenter$vtable* @HanoiPresenter$vtable, %struct.HanoiPresenter$vtable** %4, align 8
    %5 = load %struct.HanoiPresenter** %obj, align 8
    ret %struct.HanoiPresenter* %5
}

define i1 @HanoiPresenter$play(%struct.HanoiPresenter* %this) nounwind ssp {
    %N = alloca i32, align 4
    %1 = alloca i32, align 4
    store i32 8, i32* %1, align 4
    %2 = load i32* %1, align 4
    store i32 %2, i32* %N, align 4
    %3 = alloca i32, align 4
    store i32 0, i32* %3, align 4
    %4 = load i32* %3, align 4
    %5 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 4
    store i32 %4, i32* %5, align 4
    %6 = call %struct.Tower* @new$Tower()
    %7 = alloca %struct.HanoiPresenter*, align 8
    store %struct.HanoiPresenter* %this, %struct.HanoiPresenter** %7, align 8
    %8 = load %struct.HanoiPresenter** %7, align 8
    %9 = load i32* %N, align 4
    %10 = getelementptr inbounds %struct.HanoiPresenter* %8, i32 0, i32 0
    %11 = load %struct.HanoiPresenter$vtable** %10, align 8
    %12 = getelementptr inbounds %struct.HanoiPresenter$vtable* %11, i32 0, i32 3
    %13 = load %struct.Ring* (%struct.HanoiPresenter*, i32)** %12, align 8
    %14 = call %struct.Ring* %13(%struct.HanoiPresenter* %8, i32 %9)
    %15 = getelementptr inbounds %struct.Tower* %6, i32 0, i32 0
    %16 = load %struct.Tower$vtable** %15, align 8
    %17 = getelementptr inbounds %struct.Tower$vtable* %16, i32 0, i32 0
    %18 = load %struct.Tower* (%struct.Tower*, %struct.Ring*)** %17, align 8
    %19 = call %struct.Tower* %18(%struct.Tower* %6, %struct.Ring* %14)
    %20 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 1
    store %struct.Tower* %19, %struct.Tower** %20, align 8
    %21 = call %struct.Tower* @new$Tower()
    %22 = call %struct.LeafRing* @new$LeafRing()
    %23 = bitcast %struct.LeafRing* %22 to %struct.Ring*
    %24 = getelementptr inbounds %struct.Tower* %21, i32 0, i32 0
    %25 = load %struct.Tower$vtable** %24, align 8
    %26 = getelementptr inbounds %struct.Tower$vtable* %25, i32 0, i32 0
    %27 = load %struct.Tower* (%struct.Tower*, %struct.Ring*)** %26, align 8
    %28 = call %struct.Tower* %27(%struct.Tower* %21, %struct.Ring* %23)
    %29 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 2
    store %struct.Tower* %28, %struct.Tower** %29, align 8
    %30 = call %struct.Tower* @new$Tower()
    %31 = call %struct.LeafRing* @new$LeafRing()
    %32 = bitcast %struct.LeafRing* %31 to %struct.Ring*
    %33 = getelementptr inbounds %struct.Tower* %30, i32 0, i32 0
    %34 = load %struct.Tower$vtable** %33, align 8
    %35 = getelementptr inbounds %struct.Tower$vtable* %34, i32 0, i32 0
    %36 = load %struct.Tower* (%struct.Tower*, %struct.Ring*)** %35, align 8
    %37 = call %struct.Tower* %36(%struct.Tower* %30, %struct.Ring* %32)
    %38 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 3
    store %struct.Tower* %37, %struct.Tower** %38, align 8
    %39 = alloca %struct.HanoiPresenter*, align 8
    store %struct.HanoiPresenter* %this, %struct.HanoiPresenter** %39, align 8
    %40 = load %struct.HanoiPresenter** %39, align 8
    %41 = getelementptr inbounds %struct.HanoiPresenter* %40, i32 0, i32 0
    %42 = load %struct.HanoiPresenter$vtable** %41, align 8
    %43 = getelementptr inbounds %struct.HanoiPresenter$vtable* %42, i32 0, i32 4
    %44 = load i1 (%struct.HanoiPresenter*)** %43, align 8
    %45 = call i1 %44(%struct.HanoiPresenter* %40)
    %46 = xor i1 %45, 1
    br i1 %46, label %47, label %51
    
; <label>: %47
    %48 = alloca i8*, align 8
    store i8* getelementptr inbounds ([10 x i8]* @.str5, i32 0, i32 0), i8** %48, align 8
    %49 = load i8** %48, align 8
    %50 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %49)
    br label %51
    
; <label>: %51
    %52 = alloca %struct.HanoiPresenter*, align 8
    store %struct.HanoiPresenter* %this, %struct.HanoiPresenter** %52, align 8
    %53 = load %struct.HanoiPresenter** %52, align 8
    %54 = load i32* %N, align 4
    %55 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 1
    %56 = load %struct.Tower** %55, align 8
    %57 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 3
    %58 = load %struct.Tower** %57, align 8
    %59 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 2
    %60 = load %struct.Tower** %59, align 8
    %61 = getelementptr inbounds %struct.HanoiPresenter* %53, i32 0, i32 0
    %62 = load %struct.HanoiPresenter$vtable** %61, align 8
    %63 = getelementptr inbounds %struct.HanoiPresenter$vtable* %62, i32 0, i32 2
    %64 = load i1 (%struct.HanoiPresenter*, i32, %struct.Tower*, %struct.Tower*, %struct.Tower*)** %63, align 8
    %65 = call i1 %64(%struct.HanoiPresenter* %53, i32 %54, %struct.Tower* %56, %struct.Tower* %58, %struct.Tower* %60)
    %66 = xor i1 %65, 1
    br i1 %66, label %67, label %71
    
; <label>: %67
    %68 = alloca i8*, align 8
    store i8* getelementptr inbounds ([10 x i8]* @.str6, i32 0, i32 0), i8** %68, align 8
    %69 = load i8** %68, align 8
    %70 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %69)
    br label %71
    
; <label>: %71
    %72 = alloca i8*, align 8
    store i8* getelementptr inbounds ([9 x i8]* @.str7, i32 0, i32 0), i8** %72, align 8
    %73 = load i8** %72, align 8
    %74 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 4
    %75 = load i32* %74, align 4
    %76 = call i8* @$concatStringInt(i8* %73, i32 %75)
    %77 = alloca i8*, align 8
    store i8* getelementptr inbounds ([8 x i8]* @.str8, i32 0, i32 0), i8** %77, align 8
    %78 = load i8** %77, align 8
    %79 = call i8* @$concat(i8* %76, i8* %78)
    %80 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %79)
    %81 = alloca i1, align 4
    store i1 true, i1* %81, align 4
    %82 = load i1* %81, align 4
    ret i1 %82
}

define i1 @HanoiPresenter$mvRing2(%struct.HanoiPresenter* %this, %struct.Tower* %_a, %struct.Tower* %_b) nounwind ssp {
    %a = alloca %struct.Tower*, align 8
    store %struct.Tower* %_a, %struct.Tower** %a, align 8
    %b = alloca %struct.Tower*, align 8
    store %struct.Tower* %_b, %struct.Tower** %b, align 8
    %v = alloca i1, align 4
    %1 = load %struct.Tower** %b, align 8
    %2 = load %struct.Tower** %a, align 8
    %3 = getelementptr inbounds %struct.Tower* %2, i32 0, i32 0
    %4 = load %struct.Tower$vtable** %3, align 8
    %5 = getelementptr inbounds %struct.Tower$vtable* %4, i32 0, i32 2
    %6 = load %struct.Ring* (%struct.Tower*)** %5, align 8
    %7 = call %struct.Ring* %6(%struct.Tower* %2)
    %8 = getelementptr inbounds %struct.Tower* %1, i32 0, i32 0
    %9 = load %struct.Tower$vtable** %8, align 8
    %10 = getelementptr inbounds %struct.Tower$vtable* %9, i32 0, i32 1
    %11 = load i1 (%struct.Tower*, %struct.Ring*)** %10, align 8
    %12 = call i1 %11(%struct.Tower* %1, %struct.Ring* %7)
    store i1 %12, i1* %v, align 4
    %13 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 4
    %14 = load i32* %13, align 4
    %15 = alloca i32, align 4
    store i32 1, i32* %15, align 4
    %16 = load i32* %15, align 4
    %17 = add nsw i32 %14, %16
    %18 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 4
    store i32 %17, i32* %18, align 4
    %19 = alloca %struct.HanoiPresenter*, align 8
    store %struct.HanoiPresenter* %this, %struct.HanoiPresenter** %19, align 8
    %20 = load %struct.HanoiPresenter** %19, align 8
    %21 = getelementptr inbounds %struct.HanoiPresenter* %20, i32 0, i32 0
    %22 = load %struct.HanoiPresenter$vtable** %21, align 8
    %23 = getelementptr inbounds %struct.HanoiPresenter$vtable* %22, i32 0, i32 4
    %24 = load i1 (%struct.HanoiPresenter*)** %23, align 8
    %25 = call i1 %24(%struct.HanoiPresenter* %20)
    %26 = xor i1 %25, 1
    br i1 %26, label %27, label %31
    
; <label>: %27
    %28 = alloca i8*, align 8
    store i8* getelementptr inbounds ([10 x i8]* @.str9, i32 0, i32 0), i8** %28, align 8
    %29 = load i8** %28, align 8
    %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %29)
    br label %31
    
; <label>: %31
    %32 = load i1* %v, align 4
    ret i1 %32
}

define i1 @HanoiPresenter$mvRing(%struct.HanoiPresenter* %this, i32 %_nb, %struct.Tower* %_a, %struct.Tower* %_b, %struct.Tower* %_t) nounwind ssp {
    %nb = alloca i32, align 4
    store i32 %_nb, i32* %nb, align 4
    %a = alloca %struct.Tower*, align 8
    store %struct.Tower* %_a, %struct.Tower** %a, align 8
    %b = alloca %struct.Tower*, align 8
    store %struct.Tower* %_b, %struct.Tower** %b, align 8
    %t = alloca %struct.Tower*, align 8
    store %struct.Tower* %_t, %struct.Tower** %t, align 8
    %e = alloca i1, align 4
    %1 = load i32* %nb, align 4
    %2 = alloca i32, align 4
    store i32 1, i32* %2, align 4
    %3 = load i32* %2, align 4
    %4 = icmp eq  i32 %1, %3
    br i1 %4, label %5, label %15
    
; <label>: %5
    %6 = alloca %struct.HanoiPresenter*, align 8
    store %struct.HanoiPresenter* %this, %struct.HanoiPresenter** %6, align 8
    %7 = load %struct.HanoiPresenter** %6, align 8
    %8 = load %struct.Tower** %a, align 8
    %9 = load %struct.Tower** %b, align 8
    %10 = getelementptr inbounds %struct.HanoiPresenter* %7, i32 0, i32 0
    %11 = load %struct.HanoiPresenter$vtable** %10, align 8
    %12 = getelementptr inbounds %struct.HanoiPresenter$vtable* %11, i32 0, i32 1
    %13 = load i1 (%struct.HanoiPresenter*, %struct.Tower*, %struct.Tower*)** %12, align 8
    %14 = call i1 %13(%struct.HanoiPresenter* %7, %struct.Tower* %8, %struct.Tower* %9)
    store i1 %14, i1* %e, align 4
    br label %53
    
; <label>: %15
    %16 = alloca %struct.HanoiPresenter*, align 8
    store %struct.HanoiPresenter* %this, %struct.HanoiPresenter** %16, align 8
    %17 = load %struct.HanoiPresenter** %16, align 8
    %18 = load i32* %nb, align 4
    %19 = alloca i32, align 4
    store i32 1, i32* %19, align 4
    %20 = load i32* %19, align 4
    %21 = sub nsw i32 %18, %20
    %22 = load %struct.Tower** %a, align 8
    %23 = load %struct.Tower** %t, align 8
    %24 = load %struct.Tower** %b, align 8
    %25 = getelementptr inbounds %struct.HanoiPresenter* %17, i32 0, i32 0
    %26 = load %struct.HanoiPresenter$vtable** %25, align 8
    %27 = getelementptr inbounds %struct.HanoiPresenter$vtable* %26, i32 0, i32 2
    %28 = load i1 (%struct.HanoiPresenter*, i32, %struct.Tower*, %struct.Tower*, %struct.Tower*)** %27, align 8
    %29 = call i1 %28(%struct.HanoiPresenter* %17, i32 %21, %struct.Tower* %22, %struct.Tower* %23, %struct.Tower* %24)
    store i1 %29, i1* %e, align 4
    %30 = alloca %struct.HanoiPresenter*, align 8
    store %struct.HanoiPresenter* %this, %struct.HanoiPresenter** %30, align 8
    %31 = load %struct.HanoiPresenter** %30, align 8
    %32 = load %struct.Tower** %a, align 8
    %33 = load %struct.Tower** %b, align 8
    %34 = getelementptr inbounds %struct.HanoiPresenter* %31, i32 0, i32 0
    %35 = load %struct.HanoiPresenter$vtable** %34, align 8
    %36 = getelementptr inbounds %struct.HanoiPresenter$vtable* %35, i32 0, i32 1
    %37 = load i1 (%struct.HanoiPresenter*, %struct.Tower*, %struct.Tower*)** %36, align 8
    %38 = call i1 %37(%struct.HanoiPresenter* %31, %struct.Tower* %32, %struct.Tower* %33)
    store i1 %38, i1* %e, align 4
    %39 = alloca %struct.HanoiPresenter*, align 8
    store %struct.HanoiPresenter* %this, %struct.HanoiPresenter** %39, align 8
    %40 = load %struct.HanoiPresenter** %39, align 8
    %41 = load i32* %nb, align 4
    %42 = alloca i32, align 4
    store i32 1, i32* %42, align 4
    %43 = load i32* %42, align 4
    %44 = sub nsw i32 %41, %43
    %45 = load %struct.Tower** %t, align 8
    %46 = load %struct.Tower** %b, align 8
    %47 = load %struct.Tower** %a, align 8
    %48 = getelementptr inbounds %struct.HanoiPresenter* %40, i32 0, i32 0
    %49 = load %struct.HanoiPresenter$vtable** %48, align 8
    %50 = getelementptr inbounds %struct.HanoiPresenter$vtable* %49, i32 0, i32 2
    %51 = load i1 (%struct.HanoiPresenter*, i32, %struct.Tower*, %struct.Tower*, %struct.Tower*)** %50, align 8
    %52 = call i1 %51(%struct.HanoiPresenter* %40, i32 %44, %struct.Tower* %45, %struct.Tower* %46, %struct.Tower* %47)
    store i1 %52, i1* %e, align 4
    br label %53
    
; <label>: %53
    %54 = load i1* %e, align 4
    ret i1 %54
}

define %struct.Ring* @HanoiPresenter$generateRings(%struct.HanoiPresenter* %this, i32 %_n) nounwind ssp {
    %n = alloca i32, align 4
    store i32 %_n, i32* %n, align 4
    %i = alloca i32, align 4
    %r = alloca %struct.Ring*, align 8
    %1 = call %struct.LeafRing* @new$LeafRing()
    %2 = bitcast %struct.LeafRing* %1 to %struct.Ring*
    store %struct.Ring* %2, %struct.Ring** %r, align 8
    %3 = alloca i32, align 4
    store i32 0, i32* %3, align 4
    %4 = load i32* %3, align 4
    store i32 %4, i32* %i, align 4
    br label %5
    
; <label>: %5
    %6 = load i32* %i, align 4
    %7 = load i32* %n, align 4
    %8 = icmp slt i32 %6, %7
    br i1 %8, label %9, label %22
    
; <label>: %9
    %10 = load i32* %i, align 4
    %11 = alloca i32, align 4
    store i32 1, i32* %11, align 4
    %12 = load i32* %11, align 4
    %13 = add nsw i32 %10, %12
    store i32 %13, i32* %i, align 4
    %14 = call %struct.Ring* @new$Ring()
    %15 = load i32* %i, align 4
    %16 = load %struct.Ring** %r, align 8
    %17 = getelementptr inbounds %struct.Ring* %14, i32 0, i32 0
    %18 = load %struct.Ring$vtable** %17, align 8
    %19 = getelementptr inbounds %struct.Ring$vtable* %18, i32 0, i32 1
    %20 = load %struct.Ring* (%struct.Ring*, i32, %struct.Ring*)** %19, align 8
    %21 = call %struct.Ring* %20(%struct.Ring* %14, i32 %15, %struct.Ring* %16)
    store %struct.Ring* %21, %struct.Ring** %r, align 8
    br label %5
    
; <label>: %22
    %23 = load %struct.Ring** %r, align 8
    ret %struct.Ring* %23
}

define i1 @HanoiPresenter$printAll(%struct.HanoiPresenter* %this) nounwind ssp {
    
    %1 = alloca i8*, align 8
    store i8* getelementptr inbounds ([5 x i8]* @.str10, i32 0, i32 0), i8** %1, align 8
    %2 = load i8** %1, align 8
    %3 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 1
    %4 = load %struct.Tower** %3, align 8
    %5 = getelementptr inbounds %struct.Tower* %4, i32 0, i32 0
    %6 = load %struct.Tower$vtable** %5, align 8
    %7 = getelementptr inbounds %struct.Tower$vtable* %6, i32 0, i32 3
    %8 = load i8* (%struct.Tower*)** %7, align 8
    %9 = call i8* %8(%struct.Tower* %4)
    %10 = call i8* @$concat(i8* %2, i8* %9)
    %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %10)
    %12 = alloca i8*, align 8
    store i8* getelementptr inbounds ([5 x i8]* @.str11, i32 0, i32 0), i8** %12, align 8
    %13 = load i8** %12, align 8
    %14 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 2
    %15 = load %struct.Tower** %14, align 8
    %16 = getelementptr inbounds %struct.Tower* %15, i32 0, i32 0
    %17 = load %struct.Tower$vtable** %16, align 8
    %18 = getelementptr inbounds %struct.Tower$vtable* %17, i32 0, i32 3
    %19 = load i8* (%struct.Tower*)** %18, align 8
    %20 = call i8* %19(%struct.Tower* %15)
    %21 = call i8* @$concat(i8* %13, i8* %20)
    %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %21)
    %23 = alloca i8*, align 8
    store i8* getelementptr inbounds ([5 x i8]* @.str12, i32 0, i32 0), i8** %23, align 8
    %24 = load i8** %23, align 8
    %25 = getelementptr inbounds %struct.HanoiPresenter* %this, i32 0, i32 3
    %26 = load %struct.Tower** %25, align 8
    %27 = getelementptr inbounds %struct.Tower* %26, i32 0, i32 0
    %28 = load %struct.Tower$vtable** %27, align 8
    %29 = getelementptr inbounds %struct.Tower$vtable* %28, i32 0, i32 3
    %30 = load i8* (%struct.Tower*)** %29, align 8
    %31 = call i8* %30(%struct.Tower* %26)
    %32 = call i8* @$concat(i8* %24, i8* %31)
    %33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %32)
    %34 = alloca i8*, align 8
    store i8* getelementptr inbounds ([22 x i8]* @.str13, i32 0, i32 0), i8** %34, align 8
    %35 = load i8** %34, align 8
    %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %35)
    %37 = alloca i1, align 4
    store i1 true, i1* %37, align 4
    %38 = load i1* %37, align 4
    ret i1 %38
}


define %struct.Ring* @new$Ring() nounwind ssp {
    %obj = alloca %struct.Ring*, align 8
    %1 = call i8* @_mymalloc(i64 20)
    %2 = bitcast i8* %1 to %struct.Ring*
    store %struct.Ring* %2, %struct.Ring** %obj, align 8
    %3 = load %struct.Ring** %obj, align 8
    %4 = getelementptr inbounds %struct.Ring* %3, i32 0, i32 0
    store %struct.Ring$vtable* @Ring$vtable, %struct.Ring$vtable** %4, align 8
    %5 = load %struct.Ring** %obj, align 8
    ret %struct.Ring* %5
}

define i1 @Ring$isLeaf(%struct.Ring* %this) nounwind ssp {
    
    
    %1 = alloca i1, align 4
    store i1 false, i1* %1, align 4
    %2 = load i1* %1, align 4
    ret i1 %2
}

define %struct.Ring* @Ring$init(%struct.Ring* %this, i32 %_i, %struct.Ring* %_n) nounwind ssp {
    %i = alloca i32, align 4
    store i32 %_i, i32* %i, align 4
    %n = alloca %struct.Ring*, align 8
    store %struct.Ring* %_n, %struct.Ring** %n, align 8
    
    %1 = load i32* %i, align 4
    %2 = getelementptr inbounds %struct.Ring* %this, i32 0, i32 1
    store i32 %1, i32* %2, align 4
    %3 = load %struct.Ring** %n, align 8
    %4 = getelementptr inbounds %struct.Ring* %this, i32 0, i32 2
    store %struct.Ring* %3, %struct.Ring** %4, align 8
    %5 = alloca %struct.Ring*, align 8
    store %struct.Ring* %this, %struct.Ring** %5, align 8
    %6 = load %struct.Ring** %5, align 8
    ret %struct.Ring* %6
}

define i8* @Ring$print(%struct.Ring* %this) nounwind ssp {
    %str = alloca i8*, align 8
    %1 = alloca %struct.Ring*, align 8
    store %struct.Ring* %this, %struct.Ring** %1, align 8
    %2 = load %struct.Ring** %1, align 8
    %3 = getelementptr inbounds %struct.Ring* %2, i32 0, i32 0
    %4 = load %struct.Ring$vtable** %3, align 8
    %5 = getelementptr inbounds %struct.Ring$vtable* %4, i32 0, i32 0
    %6 = load i1 (%struct.Ring*)** %5, align 8
    %7 = call i1 %6(%struct.Ring* %2)
    br i1 %7, label %8, label %11
    
; <label>: %8
    %9 = alloca i8*, align 8
    store i8* getelementptr inbounds ([1 x i8]* @.str14, i32 0, i32 0), i8** %9, align 8
    %10 = load i8** %9, align 8
    store i8* %10, i8** %str, align 8
    br label %25
    
; <label>: %11
    %12 = getelementptr inbounds %struct.Ring* %this, i32 0, i32 2
    %13 = load %struct.Ring** %12, align 8
    %14 = getelementptr inbounds %struct.Ring* %13, i32 0, i32 0
    %15 = load %struct.Ring$vtable** %14, align 8
    %16 = getelementptr inbounds %struct.Ring$vtable* %15, i32 0, i32 2
    %17 = load i8* (%struct.Ring*)** %16, align 8
    %18 = call i8* %17(%struct.Ring* %13)
    %19 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str15, i32 0, i32 0), i8** %19, align 8
    %20 = load i8** %19, align 8
    %21 = call i8* @$concat(i8* %18, i8* %20)
    %22 = getelementptr inbounds %struct.Ring* %this, i32 0, i32 1
    %23 = load i32* %22, align 4
    %24 = call i8* @$concatStringInt(i8* %21, i32 %23)
    store i8* %24, i8** %str, align 8
    br label %25
    
; <label>: %25
    %26 = load i8** %str, align 8
    ret i8* %26
}

define %struct.Ring* @Ring$push(%struct.Ring* %this, %struct.Ring* %_r) nounwind ssp {
    %r = alloca %struct.Ring*, align 8
    store %struct.Ring* %_r, %struct.Ring** %r, align 8
    
    %1 = load %struct.Ring** %r, align 8
    %2 = getelementptr inbounds %struct.Ring* %this, i32 0, i32 2
    store %struct.Ring* %1, %struct.Ring** %2, align 8
    %3 = alloca %struct.Ring*, align 8
    store %struct.Ring* %this, %struct.Ring** %3, align 8
    %4 = load %struct.Ring** %3, align 8
    ret %struct.Ring* %4
}

define %struct.Ring* @Ring$pop(%struct.Ring* %this) nounwind ssp {
    %tmp = alloca %struct.Ring*, align 8
    %1 = getelementptr inbounds %struct.Ring* %this, i32 0, i32 2
    %2 = load %struct.Ring** %1, align 8
    store %struct.Ring* %2, %struct.Ring** %tmp, align 8
    %3 = call %struct.LeafRing* @new$LeafRing()
    %4 = bitcast %struct.LeafRing* %3 to %struct.Ring*
    %5 = getelementptr inbounds %struct.Ring* %this, i32 0, i32 2
    store %struct.Ring* %4, %struct.Ring** %5, align 8
    %6 = load %struct.Ring** %tmp, align 8
    ret %struct.Ring* %6
}


define %struct.LeafRing* @new$LeafRing() nounwind ssp {
    %obj = alloca %struct.LeafRing*, align 8
    %1 = call i8* @_mymalloc(i64 20)
    %2 = bitcast i8* %1 to %struct.LeafRing*
    store %struct.LeafRing* %2, %struct.LeafRing** %obj, align 8
    %3 = load %struct.LeafRing** %obj, align 8
    %4 = getelementptr inbounds %struct.LeafRing* %3, i32 0, i32 0
    store %struct.LeafRing$vtable* @LeafRing$vtable, %struct.LeafRing$vtable** %4, align 8
    %5 = load %struct.LeafRing** %obj, align 8
    ret %struct.LeafRing* %5
}

define i1 @LeafRing$isLeaf(%struct.LeafRing* %this) nounwind ssp {
    
    
    %1 = alloca i1, align 4
    store i1 true, i1* %1, align 4
    %2 = load i1* %1, align 4
    ret i1 %2
}

define i8* @LeafRing$print(%struct.LeafRing* %this) nounwind ssp {
    
    
    %1 = alloca i8*, align 8
    store i8* getelementptr inbounds ([1 x i8]* @.str16, i32 0, i32 0), i8** %1, align 8
    %2 = load i8** %1, align 8
    ret i8* %2
}


define %struct.Tower* @new$Tower() nounwind ssp {
    %obj = alloca %struct.Tower*, align 8
    %1 = call i8* @_mymalloc(i64 16)
    %2 = bitcast i8* %1 to %struct.Tower*
    store %struct.Tower* %2, %struct.Tower** %obj, align 8
    %3 = load %struct.Tower** %obj, align 8
    %4 = getelementptr inbounds %struct.Tower* %3, i32 0, i32 0
    store %struct.Tower$vtable* @Tower$vtable, %struct.Tower$vtable** %4, align 8
    %5 = load %struct.Tower** %obj, align 8
    ret %struct.Tower* %5
}

define %struct.Tower* @Tower$init(%struct.Tower* %this, %struct.Ring* %_r) nounwind ssp {
    %r = alloca %struct.Ring*, align 8
    store %struct.Ring* %_r, %struct.Ring** %r, align 8
    
    %1 = load %struct.Ring** %r, align 8
    %2 = getelementptr inbounds %struct.Tower* %this, i32 0, i32 1
    store %struct.Ring* %1, %struct.Ring** %2, align 8
    %3 = alloca %struct.Tower*, align 8
    store %struct.Tower* %this, %struct.Tower** %3, align 8
    %4 = load %struct.Tower** %3, align 8
    ret %struct.Tower* %4
}

define i1 @Tower$push(%struct.Tower* %this, %struct.Ring* %_r) nounwind ssp {
    %r = alloca %struct.Ring*, align 8
    store %struct.Ring* %_r, %struct.Ring** %r, align 8
    
    %1 = load %struct.Ring** %r, align 8
    %2 = getelementptr inbounds %struct.Tower* %this, i32 0, i32 1
    %3 = load %struct.Ring** %2, align 8
    %4 = getelementptr inbounds %struct.Ring* %1, i32 0, i32 0
    %5 = load %struct.Ring$vtable** %4, align 8
    %6 = getelementptr inbounds %struct.Ring$vtable* %5, i32 0, i32 3
    %7 = load %struct.Ring* (%struct.Ring*, %struct.Ring*)** %6, align 8
    %8 = call %struct.Ring* %7(%struct.Ring* %1, %struct.Ring* %3)
    %9 = getelementptr inbounds %struct.Tower* %this, i32 0, i32 1
    store %struct.Ring* %8, %struct.Ring** %9, align 8
    %10 = alloca i1, align 4
    store i1 true, i1* %10, align 4
    %11 = load i1* %10, align 4
    ret i1 %11
}

define %struct.Ring* @Tower$pop(%struct.Tower* %this) nounwind ssp {
    %tmp = alloca %struct.Ring*, align 8
    %1 = getelementptr inbounds %struct.Tower* %this, i32 0, i32 1
    %2 = load %struct.Ring** %1, align 8
    store %struct.Ring* %2, %struct.Ring** %tmp, align 8
    %3 = load %struct.Ring** %tmp, align 8
    %4 = getelementptr inbounds %struct.Ring* %3, i32 0, i32 0
    %5 = load %struct.Ring$vtable** %4, align 8
    %6 = getelementptr inbounds %struct.Ring$vtable* %5, i32 0, i32 4
    %7 = load %struct.Ring* (%struct.Ring*)** %6, align 8
    %8 = call %struct.Ring* %7(%struct.Ring* %3)
    %9 = getelementptr inbounds %struct.Tower* %this, i32 0, i32 1
    store %struct.Ring* %8, %struct.Ring** %9, align 8
    %10 = load %struct.Ring** %tmp, align 8
    ret %struct.Ring* %10
}

define i8* @Tower$print(%struct.Tower* %this) nounwind ssp {
    
    
    %1 = getelementptr inbounds %struct.Tower* %this, i32 0, i32 1
    %2 = load %struct.Ring** %1, align 8
    %3 = getelementptr inbounds %struct.Ring* %2, i32 0, i32 0
    %4 = load %struct.Ring$vtable** %3, align 8
    %5 = getelementptr inbounds %struct.Ring$vtable* %4, i32 0, i32 2
    %6 = load i8* (%struct.Ring*)** %5, align 8
    %7 = call i8* %6(%struct.Ring* %2)
    ret i8* %7
}

define i32 @main() nounwind ssp {
    %1 = call %struct.HanoiPresenter* @new$HanoiPresenter()
    %2 = getelementptr inbounds %struct.HanoiPresenter* %1, i32 0, i32 0
    %3 = load %struct.HanoiPresenter$vtable** %2, align 8
    %4 = getelementptr inbounds %struct.HanoiPresenter$vtable* %3, i32 0, i32 0
    %5 = load i1 (%struct.HanoiPresenter*)** %4, align 8
    %6 = call i1 %5(%struct.HanoiPresenter* %1)
    br i1 %6, label %7, label %11
    
; <label>: %7
    %8 = alloca i8*, align 8
    store i8* getelementptr inbounds ([3 x i8]* @.str17, i32 0, i32 0), i8** %8, align 8
    %9 = load i8** %8, align 8
    %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %9)
    br label %15
    
; <label>: %11
    %12 = alloca i8*, align 8
    store i8* getelementptr inbounds ([6 x i8]* @.str18, i32 0, i32 0), i8** %12, align 8
    %13 = load i8** %12, align 8
    %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %13)
    br label %15
    
; <label>: %15
    %16 = load %struct._List** @l, align 8
    call void @_List_free(%struct._List* %16)
    ret i32 0
}

declare i32 @printf(i8*, ...)
declare i8* @malloc(i64)

      ; Function Attrs: nounwind uwtable
define i8* @$concat(i8* %s, i8* %t) {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  %size = alloca i32, align 4
  %str = alloca i8*, align 8
  store i8* %s, i8** %1, align 8
  store i8* %t, i8** %2, align 8
  %3 = load i8** %1, align 8
  %4 = call i64 @strlen(i8* %3)
  %5 = load i8** %2, align 8
  %6 = call i64 @strlen(i8* %5)
  %7 = add i64 %4, %6
  %8 = add i64 %7, 1
  %9 = trunc i64 %8 to i32
  store i32 %9, i32* %size, align 4
  %10 = load i32* %size, align 4
  %11 = sext i32 %10 to i64
  %12 = mul i64 %11, 1
  %13 = call noalias i8* @_mymalloc(i64 %12)
  store i8* %13, i8** %str, align 8
  %14 = load i8** %str, align 8
  %15 = load i8** %1, align 8
  %16 = call i8* @strcpy(i8* %14, i8* %15)
  store i8* %16, i8** %str, align 8
  %17 = load i8** %str, align 8
  %18 = load i8** %2, align 8
  %19 = call i8* @strcat(i8* %17, i8* %18)
  store i8* %19, i8** %str, align 8
  %20 = load i8** %str, align 8
  ret i8* %20
}

; Function Attrs: nounwind readonly
declare i64 @strlen(i8*)

; Function Attrs: nounwind
declare i8* @strcpy(i8*, i8*)

; Function Attrs: nounwind
declare i8* @strcat(i8*, i8*)

; Function Attrs: nounwind uwtable
define i8* @$concatStringInt(i8* %s, i32 %i) {
  %1 = alloca i8*, align 8
  %2 = alloca i32, align 4
  %str = alloca [15 x i8], align 1
  store i8* %s, i8** %1, align 8
  store i32 %i, i32* %2, align 4
  %3 = getelementptr inbounds [15 x i8]* %str, i32 0, i32 0
  %4 = load i32* %2, align 4
  %5 = call i32 (i8*, i8*, ...)* @sprintf(i8* %3, i8* getelementptr inbounds ([3 x i8]* @.str2, i32 0, i32 0), i32 %4)
  %6 = load i8** %1, align 8
  %7 = getelementptr inbounds [15 x i8]* %str, i32 0, i32 0
  %8 = call i8* @$concat(i8* %6, i8* %7)
  ret i8* %8
}

; Function Attrs: nounwind
declare i32 @sprintf(i8*, i8*, ...)

; Function Attrs: nounwind uwtable
define i8* @$concatIntString(i32 %i, i8* %s) {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %str = alloca [15 x i8], align 1
  store i32 %i, i32* %1, align 4
  store i8* %s, i8** %2, align 8
  %3 = getelementptr inbounds [15 x i8]* %str, i32 0, i32 0
  %4 = load i32* %1, align 4
  %5 = call i32 (i8*, i8*, ...)* @sprintf(i8* %3, i8* getelementptr inbounds ([3 x i8]* @.str2, i32 0, i32 0), i32 %4)
  %6 = getelementptr inbounds [15 x i8]* %str, i32 0, i32 0
  %7 = load i8** %2, align 8
  %8 = call i8* @$concat(i8* %6, i8* %7)
  ret i8* %8
}

define i8* @boolToString(i1 %b) nounwind ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i1, align 4
  store i1 %b, i1* %2, align 4
  %3 = load i1* %2, align 4
  %4 = icmp ne i1 %3, 0
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  store i8* getelementptr inbounds ([5 x i8]* @.str3, i32 0, i32 0), i8** %1
  br label %7

; <label>:6                                       ; preds = %0
  store i8* getelementptr inbounds ([6 x i8]* @.str4, i32 0, i32 0), i8** %1
  br label %7

; <label>:7                                       ; preds = %6, %5
  %8 = load i8** %1
  ret i8* %8
}
      
      
      
      
      
define %struct._List* @_List_add(%struct._List* %list, i8* %ptr) nounwind ssp {
  %1 = alloca %struct._List*, align 8
  %2 = alloca i8*, align 8
  %newNode = alloca %struct._List*, align 8
  store %struct._List* %list, %struct._List** %1, align 8
  store i8* %ptr, i8** %2, align 8
  %3 = call i8* @malloc(i64 16)
  %4 = bitcast i8* %3 to %struct._List*
  store %struct._List* %4, %struct._List** %newNode, align 8
  %5 = load i8** %2, align 8
  %6 = load %struct._List** %newNode, align 8
  %7 = getelementptr inbounds %struct._List* %6, i32 0, i32 1
  store i8* %5, i8** %7, align 8
  %8 = load %struct._List** %1, align 8
  %9 = load %struct._List** %newNode, align 8
  %10 = getelementptr inbounds %struct._List* %9, i32 0, i32 0
  store %struct._List* %8, %struct._List** %10, align 8
  %11 = load %struct._List** %newNode, align 8
  ret %struct._List* %11
}

define void @_List_free(%struct._List* %list) nounwind ssp {
  %1 = alloca %struct._List*, align 8
  store %struct._List* %list, %struct._List** %1, align 8
  %2 = load %struct._List** %1, align 8
  %3 = getelementptr inbounds %struct._List* %2, i32 0, i32 0
  %4 = load %struct._List** %3, align 8
  %5 = icmp ne %struct._List* %4, null
  br i1 %5, label %6, label %14

; <label>:6                                       ; preds = %0
  %7 = load %struct._List** %1, align 8
  %8 = getelementptr inbounds %struct._List* %7, i32 0, i32 0
  %9 = load %struct._List** %8, align 8
  call void @_List_free(%struct._List* %9)
  %10 = load %struct._List** %1, align 8
  %11 = getelementptr inbounds %struct._List* %10, i32 0, i32 0
  %12 = load %struct._List** %11, align 8
  %13 = bitcast %struct._List* %12 to i8*
  call void @free(i8* %13)
  br label %14

; <label>:14                                      ; preds = %6, %0
  %15 = load %struct._List** %1, align 8
  %16 = getelementptr inbounds %struct._List* %15, i32 0, i32 1
  %17 = load i8** %16, align 8
  call void @free(i8* %17)
  ret void
}

declare void @free(i8*)

define i8* @_mymalloc(i64 %size) nounwind ssp {
  %1 = alloca i64, align 8
  %ptr = alloca i8*, align 8
  store i64 %size, i64* %1, align 8
  %2 = load i64* %1, align 8
  %3 = call i8* @malloc(i64 %2)
  store i8* %3, i8** %ptr, align 8
  %4 = load %struct._List** @l, align 8
  %5 = load i8** %ptr, align 8
  %6 = call %struct._List* @_List_add(%struct._List* %4, i8* %5)
  store %struct._List* %6, %struct._List** @l, align 8
  %7 = load i8** %ptr, align 8
  ret i8* %7
}
      
      
define %struct.$IntArray* @$new_$IntArray(i32 %size) nounwind ssp {
  %1 = alloca i32, align 4
  %intArray = alloca %struct.$IntArray*, align 8
  store i32 %size, i32* %1, align 4
  %2 = call i8* @_mymalloc(i64 12)
  %3 = bitcast i8* %2 to %struct.$IntArray*
  store %struct.$IntArray* %3, %struct.$IntArray** %intArray, align 8
  %4 = load i32* %1, align 4
  %5 = sext i32 %4 to i64
  %6 = mul nsw i64 %5, 4
  %7 = call i8* @_mymalloc(i64 %6)
  %8 = bitcast i8* %7 to i32*
  %9 = load %struct.$IntArray** %intArray, align 8
  %10 = getelementptr inbounds %struct.$IntArray* %9, i32 0, i32 0
  store i32* %8, i32** %10, align 8
  %11 = load i32* %1, align 4
  %12 = load %struct.$IntArray** %intArray, align 8
  %13 = getelementptr inbounds %struct.$IntArray* %12, i32 0, i32 1
  store i32 %11, i32* %13, align 4
  %14 = load %struct.$IntArray** %intArray, align 8
  ret %struct.$IntArray* %14
}

define i32 @$IntArray_Read(%struct.$IntArray* %intArray, i32 %index) nounwind ssp {
  %1 = alloca %struct.$IntArray*, align 8
  %2 = alloca i32, align 4
  store %struct.$IntArray* %intArray, %struct.$IntArray** %1, align 8
  store i32 %index, i32* %2, align 4
  %3 = load i32* %2, align 4
  %4 = sext i32 %3 to i64
  %5 = load %struct.$IntArray** %1, align 8
  %6 = getelementptr inbounds %struct.$IntArray* %5, i32 0, i32 0
  %7 = load i32** %6, align 8
  %8 = getelementptr inbounds i32* %7, i32 %3
  %9 = load i32* %8
  ret i32 %9
}

define %struct.$IntArray* @$IntArray_Assign(%struct.$IntArray* %intArray, i32 %index, i32 %data) nounwind ssp {
  %1 = alloca %struct.$IntArray*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store %struct.$IntArray* %intArray, %struct.$IntArray** %1, align 8
  store i32 %index, i32* %2, align 4
  store i32 %data, i32* %3, align 4
  %4 = load i32* %3, align 4
  %5 = load i32* %2, align 4
  %6 = sext i32 %5 to i64
  %7 = load %struct.$IntArray** %1, align 8
  %8 = getelementptr inbounds %struct.$IntArray* %7, i32 0, i32 0
  %9 = load i32** %8, align 8
  %10 = getelementptr inbounds i32* %9, i32 %5
  store i32 %4, i32* %10
  ret %struct.$IntArray* %7
}

define i32 @$IntArray_Length(%struct.$IntArray* %intArray) nounwind ssp {
  %1 = alloca %struct.$IntArray*, align 8
  store %struct.$IntArray* %intArray, %struct.$IntArray** %1, align 8
  %2 = load %struct.$IntArray** %1, align 8
  %3 = getelementptr inbounds %struct.$IntArray* %2, i32 0, i32 1
  %4 = load i32* %3, align 4
  ret i32 %4
}