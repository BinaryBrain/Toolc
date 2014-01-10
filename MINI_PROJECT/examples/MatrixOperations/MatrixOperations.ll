; ModuleID = 'MatrixOperations.tool'
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
@.str5 = private unnamed_addr constant [5 x i8] c"m1: \00"
@.str6 = private unnamed_addr constant [5 x i8] c"m2: \00"
@.str7 = private unnamed_addr constant [5 x i8] c"m3: \00"
@.str8 = private unnamed_addr constant [11 x i8] c"m1 + m1 = \00"
@.str9 = private unnamed_addr constant [11 x i8] c"m1 * m2 = \00"
@.str10 = private unnamed_addr constant [10 x i8] c"det m3 = \00"
@.str11 = private unnamed_addr constant [15 x i8] c" (should be 0)\00"
@.str12 = private unnamed_addr constant [2 x i8] c"{\00"
@.str13 = private unnamed_addr constant [2 x i8] c"{\00"
@.str14 = private unnamed_addr constant [3 x i8] c", \00"
@.str15 = private unnamed_addr constant [2 x i8] c"}\00"
@.str16 = private unnamed_addr constant [3 x i8] c", \00"
@.str17 = private unnamed_addr constant [2 x i8] c"}\00"

%struct.Test = type <{ %struct.Test$vtable* }>
%struct.Test$vtable = type { i1 (%struct.Test*)* , %struct.Matrix* (%struct.Test*)* , %struct.Matrix* (%struct.Test*)* , %struct.Matrix* (%struct.Test*)* }
@Test$vtable = global %struct.Test$vtable { i1 (%struct.Test*)* @Test$launch , %struct.Matrix* (%struct.Test*)* @Test$createMatrix1 , %struct.Matrix* (%struct.Test*)* @Test$createMatrix2 , %struct.Matrix* (%struct.Test*)* @Test$createMatrix3 }, align 8


%struct.Matrix = type <{ %struct.Matrix$vtable*, %struct.$IntArray*, i32, i32 }>
%struct.Matrix$vtable = type { %struct.Matrix* (%struct.Matrix*, i32, i32)* , i32 (%struct.Matrix*)* , i32 (%struct.Matrix*)* , i32 (%struct.Matrix*, i32, i32)* , %struct.Matrix* (%struct.Matrix*, i32, i32, i32)* , %struct.Matrix* (%struct.Matrix*, %struct.Matrix*)* , %struct.Matrix* (%struct.Matrix*, %struct.Matrix*)* , i32 (%struct.Matrix*)* , %struct.Matrix* (%struct.Matrix*, i32)* , i8* (%struct.Matrix*)* }
@Matrix$vtable = global %struct.Matrix$vtable { %struct.Matrix* (%struct.Matrix*, i32, i32)* @Matrix$init , i32 (%struct.Matrix*)* @Matrix$getNbRows , i32 (%struct.Matrix*)* @Matrix$getNbCols , i32 (%struct.Matrix*, i32, i32)* @Matrix$at , %struct.Matrix* (%struct.Matrix*, i32, i32, i32)* @Matrix$setAt , %struct.Matrix* (%struct.Matrix*, %struct.Matrix*)* @Matrix$plus , %struct.Matrix* (%struct.Matrix*, %struct.Matrix*)* @Matrix$times , i32 (%struct.Matrix*)* @Matrix$det , %struct.Matrix* (%struct.Matrix*, i32)* @Matrix$extractSubMatrix , i8* (%struct.Matrix*)* @Matrix$toString }, align 8

define %struct.Test* @new$Test() nounwind ssp {
    %obj = alloca %struct.Test*, align 8
    %1 = call i8* @_mymalloc(i64 8)
    %2 = bitcast i8* %1 to %struct.Test*
    store %struct.Test* %2, %struct.Test** %obj, align 8
    %3 = load %struct.Test** %obj, align 8
    %4 = getelementptr inbounds %struct.Test* %3, i32 0, i32 0
    store %struct.Test$vtable* @Test$vtable, %struct.Test$vtable** %4, align 8
    %5 = load %struct.Test** %obj, align 8
    ret %struct.Test* %5
}

define i1 @Test$launch(%struct.Test* %this) nounwind ssp {
    %matrix1 = alloca %struct.Matrix*, align 8
    %matrix2 = alloca %struct.Matrix*, align 8
    %matrix3 = alloca %struct.Matrix*, align 8
    %1 = alloca %struct.Test*, align 8
    store %struct.Test* %this, %struct.Test** %1, align 8
    %2 = load %struct.Test** %1, align 8
    %3 = getelementptr inbounds %struct.Test* %2, i32 0, i32 0
    %4 = load %struct.Test$vtable** %3, align 8
    %5 = getelementptr inbounds %struct.Test$vtable* %4, i32 0, i32 1
    %6 = load %struct.Matrix* (%struct.Test*)** %5, align 8
    %7 = call %struct.Matrix* %6(%struct.Test* %2)
    store %struct.Matrix* %7, %struct.Matrix** %matrix1, align 8
    %8 = alloca i8*, align 8
    store i8* getelementptr inbounds ([5 x i8]* @.str5, i32 0, i32 0), i8** %8, align 8
    %9 = load i8** %8, align 8
    %10 = load %struct.Matrix** %matrix1, align 8
    %11 = getelementptr inbounds %struct.Matrix* %10, i32 0, i32 0
    %12 = load %struct.Matrix$vtable** %11, align 8
    %13 = getelementptr inbounds %struct.Matrix$vtable* %12, i32 0, i32 9
    %14 = load i8* (%struct.Matrix*)** %13, align 8
    %15 = call i8* %14(%struct.Matrix* %10)
    %16 = call i8* @$concat(i8* %9, i8* %15)
    %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %16)
    %18 = alloca %struct.Test*, align 8
    store %struct.Test* %this, %struct.Test** %18, align 8
    %19 = load %struct.Test** %18, align 8
    %20 = getelementptr inbounds %struct.Test* %19, i32 0, i32 0
    %21 = load %struct.Test$vtable** %20, align 8
    %22 = getelementptr inbounds %struct.Test$vtable* %21, i32 0, i32 2
    %23 = load %struct.Matrix* (%struct.Test*)** %22, align 8
    %24 = call %struct.Matrix* %23(%struct.Test* %19)
    store %struct.Matrix* %24, %struct.Matrix** %matrix2, align 8
    %25 = alloca i8*, align 8
    store i8* getelementptr inbounds ([5 x i8]* @.str6, i32 0, i32 0), i8** %25, align 8
    %26 = load i8** %25, align 8
    %27 = load %struct.Matrix** %matrix2, align 8
    %28 = getelementptr inbounds %struct.Matrix* %27, i32 0, i32 0
    %29 = load %struct.Matrix$vtable** %28, align 8
    %30 = getelementptr inbounds %struct.Matrix$vtable* %29, i32 0, i32 9
    %31 = load i8* (%struct.Matrix*)** %30, align 8
    %32 = call i8* %31(%struct.Matrix* %27)
    %33 = call i8* @$concat(i8* %26, i8* %32)
    %34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %33)
    %35 = alloca %struct.Test*, align 8
    store %struct.Test* %this, %struct.Test** %35, align 8
    %36 = load %struct.Test** %35, align 8
    %37 = getelementptr inbounds %struct.Test* %36, i32 0, i32 0
    %38 = load %struct.Test$vtable** %37, align 8
    %39 = getelementptr inbounds %struct.Test$vtable* %38, i32 0, i32 3
    %40 = load %struct.Matrix* (%struct.Test*)** %39, align 8
    %41 = call %struct.Matrix* %40(%struct.Test* %36)
    store %struct.Matrix* %41, %struct.Matrix** %matrix3, align 8
    %42 = alloca i8*, align 8
    store i8* getelementptr inbounds ([5 x i8]* @.str7, i32 0, i32 0), i8** %42, align 8
    %43 = load i8** %42, align 8
    %44 = load %struct.Matrix** %matrix3, align 8
    %45 = getelementptr inbounds %struct.Matrix* %44, i32 0, i32 0
    %46 = load %struct.Matrix$vtable** %45, align 8
    %47 = getelementptr inbounds %struct.Matrix$vtable* %46, i32 0, i32 9
    %48 = load i8* (%struct.Matrix*)** %47, align 8
    %49 = call i8* %48(%struct.Matrix* %44)
    %50 = call i8* @$concat(i8* %43, i8* %49)
    %51 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %50)
    %52 = alloca i8*, align 8
    store i8* getelementptr inbounds ([11 x i8]* @.str8, i32 0, i32 0), i8** %52, align 8
    %53 = load i8** %52, align 8
    %54 = load %struct.Matrix** %matrix1, align 8
    %55 = load %struct.Matrix** %matrix1, align 8
    %56 = getelementptr inbounds %struct.Matrix* %54, i32 0, i32 0
    %57 = load %struct.Matrix$vtable** %56, align 8
    %58 = getelementptr inbounds %struct.Matrix$vtable* %57, i32 0, i32 5
    %59 = load %struct.Matrix* (%struct.Matrix*, %struct.Matrix*)** %58, align 8
    %60 = call %struct.Matrix* %59(%struct.Matrix* %54, %struct.Matrix* %55)
    %61 = getelementptr inbounds %struct.Matrix* %60, i32 0, i32 0
    %62 = load %struct.Matrix$vtable** %61, align 8
    %63 = getelementptr inbounds %struct.Matrix$vtable* %62, i32 0, i32 9
    %64 = load i8* (%struct.Matrix*)** %63, align 8
    %65 = call i8* %64(%struct.Matrix* %60)
    %66 = call i8* @$concat(i8* %53, i8* %65)
    %67 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %66)
    %68 = alloca i8*, align 8
    store i8* getelementptr inbounds ([11 x i8]* @.str9, i32 0, i32 0), i8** %68, align 8
    %69 = load i8** %68, align 8
    %70 = load %struct.Matrix** %matrix1, align 8
    %71 = load %struct.Matrix** %matrix2, align 8
    %72 = getelementptr inbounds %struct.Matrix* %70, i32 0, i32 0
    %73 = load %struct.Matrix$vtable** %72, align 8
    %74 = getelementptr inbounds %struct.Matrix$vtable* %73, i32 0, i32 6
    %75 = load %struct.Matrix* (%struct.Matrix*, %struct.Matrix*)** %74, align 8
    %76 = call %struct.Matrix* %75(%struct.Matrix* %70, %struct.Matrix* %71)
    %77 = getelementptr inbounds %struct.Matrix* %76, i32 0, i32 0
    %78 = load %struct.Matrix$vtable** %77, align 8
    %79 = getelementptr inbounds %struct.Matrix$vtable* %78, i32 0, i32 9
    %80 = load i8* (%struct.Matrix*)** %79, align 8
    %81 = call i8* %80(%struct.Matrix* %76)
    %82 = call i8* @$concat(i8* %69, i8* %81)
    %83 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %82)
    %84 = alloca i8*, align 8
    store i8* getelementptr inbounds ([10 x i8]* @.str10, i32 0, i32 0), i8** %84, align 8
    %85 = load i8** %84, align 8
    %86 = load %struct.Matrix** %matrix3, align 8
    %87 = getelementptr inbounds %struct.Matrix* %86, i32 0, i32 0
    %88 = load %struct.Matrix$vtable** %87, align 8
    %89 = getelementptr inbounds %struct.Matrix$vtable* %88, i32 0, i32 7
    %90 = load i32 (%struct.Matrix*)** %89, align 8
    %91 = call i32 %90(%struct.Matrix* %86)
    %92 = call i8* @$concatStringInt(i8* %85, i32 %91)
    %93 = alloca i8*, align 8
    store i8* getelementptr inbounds ([15 x i8]* @.str11, i32 0, i32 0), i8** %93, align 8
    %94 = load i8** %93, align 8
    %95 = call i8* @$concat(i8* %92, i8* %94)
    %96 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %95)
    %97 = alloca i1, align 4
    store i1 true, i1* %97, align 4
    %98 = load i1* %97, align 4
    ret i1 %98
}

define %struct.Matrix* @Test$createMatrix1(%struct.Test* %this) nounwind ssp {
    %matrix = alloca %struct.Matrix*, align 8
    %i = alloca i32, align 4
    %j = alloca i32, align 4
    %k = alloca i32, align 4
    %1 = call %struct.Matrix* @new$Matrix()
    %2 = alloca i32, align 4
    store i32 2, i32* %2, align 4
    %3 = load i32* %2, align 4
    %4 = alloca i32, align 4
    store i32 4, i32* %4, align 4
    %5 = load i32* %4, align 4
    %6 = getelementptr inbounds %struct.Matrix* %1, i32 0, i32 0
    %7 = load %struct.Matrix$vtable** %6, align 8
    %8 = getelementptr inbounds %struct.Matrix$vtable* %7, i32 0, i32 0
    %9 = load %struct.Matrix* (%struct.Matrix*, i32, i32)** %8, align 8
    %10 = call %struct.Matrix* %9(%struct.Matrix* %1, i32 %3, i32 %5)
    store %struct.Matrix* %10, %struct.Matrix** %matrix, align 8
    %11 = alloca i32, align 4
    store i32 0, i32* %11, align 4
    %12 = load i32* %11, align 4
    store i32 %12, i32* %i, align 4
    %13 = alloca i32, align 4
    store i32 0, i32* %13, align 4
    %14 = load i32* %13, align 4
    store i32 %14, i32* %j, align 4
    %15 = alloca i32, align 4
    store i32 1, i32* %15, align 4
    %16 = load i32* %15, align 4
    store i32 %16, i32* %k, align 4
    br label %17
    
; <label>: %17
    %18 = load i32* %i, align 4
    %19 = alloca i32, align 4
    store i32 2, i32* %19, align 4
    %20 = load i32* %19, align 4
    %21 = icmp slt i32 %18, %20
    br i1 %21, label %22, label %53
    
; <label>: %22
    %23 = alloca i32, align 4
    store i32 0, i32* %23, align 4
    %24 = load i32* %23, align 4
    store i32 %24, i32* %j, align 4
    br label %25
    
; <label>: %25
    %26 = load i32* %j, align 4
    %27 = alloca i32, align 4
    store i32 4, i32* %27, align 4
    %28 = load i32* %27, align 4
    %29 = icmp slt i32 %26, %28
    br i1 %29, label %30, label %48
    
; <label>: %30
    %31 = load %struct.Matrix** %matrix, align 8
    %32 = load i32* %i, align 4
    %33 = load i32* %j, align 4
    %34 = load i32* %k, align 4
    %35 = getelementptr inbounds %struct.Matrix* %31, i32 0, i32 0
    %36 = load %struct.Matrix$vtable** %35, align 8
    %37 = getelementptr inbounds %struct.Matrix$vtable* %36, i32 0, i32 4
    %38 = load %struct.Matrix* (%struct.Matrix*, i32, i32, i32)** %37, align 8
    %39 = call %struct.Matrix* %38(%struct.Matrix* %31, i32 %32, i32 %33, i32 %34)
    store %struct.Matrix* %39, %struct.Matrix** %matrix, align 8
    %40 = load i32* %j, align 4
    %41 = alloca i32, align 4
    store i32 1, i32* %41, align 4
    %42 = load i32* %41, align 4
    %43 = add nsw i32 %40, %42
    store i32 %43, i32* %j, align 4
    %44 = load i32* %k, align 4
    %45 = alloca i32, align 4
    store i32 1, i32* %45, align 4
    %46 = load i32* %45, align 4
    %47 = add nsw i32 %44, %46
    store i32 %47, i32* %k, align 4
    br label %25
    
; <label>: %48
    %49 = load i32* %i, align 4
    %50 = alloca i32, align 4
    store i32 1, i32* %50, align 4
    %51 = load i32* %50, align 4
    %52 = add nsw i32 %49, %51
    store i32 %52, i32* %i, align 4
    br label %17
    
; <label>: %53
    %54 = load %struct.Matrix** %matrix, align 8
    ret %struct.Matrix* %54
}

define %struct.Matrix* @Test$createMatrix2(%struct.Test* %this) nounwind ssp {
    %matrix = alloca %struct.Matrix*, align 8
    %i = alloca i32, align 4
    %j = alloca i32, align 4
    %k = alloca i32, align 4
    %1 = call %struct.Matrix* @new$Matrix()
    %2 = alloca i32, align 4
    store i32 4, i32* %2, align 4
    %3 = load i32* %2, align 4
    %4 = alloca i32, align 4
    store i32 3, i32* %4, align 4
    %5 = load i32* %4, align 4
    %6 = getelementptr inbounds %struct.Matrix* %1, i32 0, i32 0
    %7 = load %struct.Matrix$vtable** %6, align 8
    %8 = getelementptr inbounds %struct.Matrix$vtable* %7, i32 0, i32 0
    %9 = load %struct.Matrix* (%struct.Matrix*, i32, i32)** %8, align 8
    %10 = call %struct.Matrix* %9(%struct.Matrix* %1, i32 %3, i32 %5)
    store %struct.Matrix* %10, %struct.Matrix** %matrix, align 8
    %11 = alloca i32, align 4
    store i32 0, i32* %11, align 4
    %12 = load i32* %11, align 4
    store i32 %12, i32* %i, align 4
    %13 = alloca i32, align 4
    store i32 0, i32* %13, align 4
    %14 = load i32* %13, align 4
    store i32 %14, i32* %j, align 4
    %15 = alloca i32, align 4
    store i32 4, i32* %15, align 4
    %16 = load i32* %15, align 4
    store i32 %16, i32* %k, align 4
    br label %17
    
; <label>: %17
    %18 = load i32* %i, align 4
    %19 = alloca i32, align 4
    store i32 4, i32* %19, align 4
    %20 = load i32* %19, align 4
    %21 = icmp slt i32 %18, %20
    br i1 %21, label %22, label %53
    
; <label>: %22
    %23 = alloca i32, align 4
    store i32 0, i32* %23, align 4
    %24 = load i32* %23, align 4
    store i32 %24, i32* %j, align 4
    br label %25
    
; <label>: %25
    %26 = load i32* %j, align 4
    %27 = alloca i32, align 4
    store i32 3, i32* %27, align 4
    %28 = load i32* %27, align 4
    %29 = icmp slt i32 %26, %28
    br i1 %29, label %30, label %48
    
; <label>: %30
    %31 = load %struct.Matrix** %matrix, align 8
    %32 = load i32* %i, align 4
    %33 = load i32* %j, align 4
    %34 = load i32* %k, align 4
    %35 = getelementptr inbounds %struct.Matrix* %31, i32 0, i32 0
    %36 = load %struct.Matrix$vtable** %35, align 8
    %37 = getelementptr inbounds %struct.Matrix$vtable* %36, i32 0, i32 4
    %38 = load %struct.Matrix* (%struct.Matrix*, i32, i32, i32)** %37, align 8
    %39 = call %struct.Matrix* %38(%struct.Matrix* %31, i32 %32, i32 %33, i32 %34)
    store %struct.Matrix* %39, %struct.Matrix** %matrix, align 8
    %40 = load i32* %j, align 4
    %41 = alloca i32, align 4
    store i32 1, i32* %41, align 4
    %42 = load i32* %41, align 4
    %43 = add nsw i32 %40, %42
    store i32 %43, i32* %j, align 4
    %44 = load i32* %k, align 4
    %45 = alloca i32, align 4
    store i32 1, i32* %45, align 4
    %46 = load i32* %45, align 4
    %47 = add nsw i32 %44, %46
    store i32 %47, i32* %k, align 4
    br label %25
    
; <label>: %48
    %49 = load i32* %i, align 4
    %50 = alloca i32, align 4
    store i32 1, i32* %50, align 4
    %51 = load i32* %50, align 4
    %52 = add nsw i32 %49, %51
    store i32 %52, i32* %i, align 4
    br label %17
    
; <label>: %53
    %54 = load %struct.Matrix** %matrix, align 8
    ret %struct.Matrix* %54
}

define %struct.Matrix* @Test$createMatrix3(%struct.Test* %this) nounwind ssp {
    %matrix = alloca %struct.Matrix*, align 8
    %i = alloca i32, align 4
    %j = alloca i32, align 4
    %k = alloca i32, align 4
    %1 = call %struct.Matrix* @new$Matrix()
    %2 = alloca i32, align 4
    store i32 3, i32* %2, align 4
    %3 = load i32* %2, align 4
    %4 = alloca i32, align 4
    store i32 3, i32* %4, align 4
    %5 = load i32* %4, align 4
    %6 = getelementptr inbounds %struct.Matrix* %1, i32 0, i32 0
    %7 = load %struct.Matrix$vtable** %6, align 8
    %8 = getelementptr inbounds %struct.Matrix$vtable* %7, i32 0, i32 0
    %9 = load %struct.Matrix* (%struct.Matrix*, i32, i32)** %8, align 8
    %10 = call %struct.Matrix* %9(%struct.Matrix* %1, i32 %3, i32 %5)
    store %struct.Matrix* %10, %struct.Matrix** %matrix, align 8
    %11 = alloca i32, align 4
    store i32 0, i32* %11, align 4
    %12 = load i32* %11, align 4
    store i32 %12, i32* %i, align 4
    %13 = alloca i32, align 4
    store i32 0, i32* %13, align 4
    %14 = load i32* %13, align 4
    store i32 %14, i32* %j, align 4
    %15 = alloca i32, align 4
    store i32 4, i32* %15, align 4
    %16 = load i32* %15, align 4
    store i32 %16, i32* %k, align 4
    br label %17
    
; <label>: %17
    %18 = load i32* %i, align 4
    %19 = alloca i32, align 4
    store i32 3, i32* %19, align 4
    %20 = load i32* %19, align 4
    %21 = icmp slt i32 %18, %20
    br i1 %21, label %22, label %53
    
; <label>: %22
    %23 = alloca i32, align 4
    store i32 0, i32* %23, align 4
    %24 = load i32* %23, align 4
    store i32 %24, i32* %j, align 4
    br label %25
    
; <label>: %25
    %26 = load i32* %j, align 4
    %27 = alloca i32, align 4
    store i32 3, i32* %27, align 4
    %28 = load i32* %27, align 4
    %29 = icmp slt i32 %26, %28
    br i1 %29, label %30, label %48
    
; <label>: %30
    %31 = load %struct.Matrix** %matrix, align 8
    %32 = load i32* %i, align 4
    %33 = load i32* %j, align 4
    %34 = load i32* %k, align 4
    %35 = getelementptr inbounds %struct.Matrix* %31, i32 0, i32 0
    %36 = load %struct.Matrix$vtable** %35, align 8
    %37 = getelementptr inbounds %struct.Matrix$vtable* %36, i32 0, i32 4
    %38 = load %struct.Matrix* (%struct.Matrix*, i32, i32, i32)** %37, align 8
    %39 = call %struct.Matrix* %38(%struct.Matrix* %31, i32 %32, i32 %33, i32 %34)
    store %struct.Matrix* %39, %struct.Matrix** %matrix, align 8
    %40 = load i32* %j, align 4
    %41 = alloca i32, align 4
    store i32 1, i32* %41, align 4
    %42 = load i32* %41, align 4
    %43 = add nsw i32 %40, %42
    store i32 %43, i32* %j, align 4
    %44 = load i32* %k, align 4
    %45 = alloca i32, align 4
    store i32 1, i32* %45, align 4
    %46 = load i32* %45, align 4
    %47 = add nsw i32 %44, %46
    store i32 %47, i32* %k, align 4
    br label %25
    
; <label>: %48
    %49 = load i32* %i, align 4
    %50 = alloca i32, align 4
    store i32 1, i32* %50, align 4
    %51 = load i32* %50, align 4
    %52 = add nsw i32 %49, %51
    store i32 %52, i32* %i, align 4
    br label %17
    
; <label>: %53
    %54 = load %struct.Matrix** %matrix, align 8
    ret %struct.Matrix* %54
}


define %struct.Matrix* @new$Matrix() nounwind ssp {
    %obj = alloca %struct.Matrix*, align 8
    %1 = call i8* @_mymalloc(i64 24)
    %2 = bitcast i8* %1 to %struct.Matrix*
    store %struct.Matrix* %2, %struct.Matrix** %obj, align 8
    %3 = load %struct.Matrix** %obj, align 8
    %4 = getelementptr inbounds %struct.Matrix* %3, i32 0, i32 0
    store %struct.Matrix$vtable* @Matrix$vtable, %struct.Matrix$vtable** %4, align 8
    %5 = load %struct.Matrix** %obj, align 8
    ret %struct.Matrix* %5
}

define %struct.Matrix* @Matrix$init(%struct.Matrix* %this, i32 %_row, i32 %_col) nounwind ssp {
    %row = alloca i32, align 4
    store i32 %_row, i32* %row, align 4
    %col = alloca i32, align 4
    store i32 %_col, i32* %col, align 4
    
    %1 = load i32* %row, align 4
    %2 = load i32* %col, align 4
    %3 = mul nsw i32 %1, %2
    %4 = call %struct.$IntArray* @$new_$IntArray(i32 %3)
    %5 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 1
    store %struct.$IntArray* %4, %struct.$IntArray** %5, align 8
    %6 = load i32* %row, align 4
    %7 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    store i32 %6, i32* %7, align 4
    %8 = load i32* %col, align 4
    %9 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 3
    store i32 %8, i32* %9, align 4
    %10 = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %this, %struct.Matrix** %10, align 8
    %11 = load %struct.Matrix** %10, align 8
    ret %struct.Matrix* %11
}

define i32 @Matrix$getNbRows(%struct.Matrix* %this) nounwind ssp {
    
    
    %1 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %2 = load i32* %1, align 4
    ret i32 %2
}

define i32 @Matrix$getNbCols(%struct.Matrix* %this) nounwind ssp {
    
    
    %1 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 3
    %2 = load i32* %1, align 4
    ret i32 %2
}

define i32 @Matrix$at(%struct.Matrix* %this, i32 %_row, i32 %_col) nounwind ssp {
    %row = alloca i32, align 4
    store i32 %_row, i32* %row, align 4
    %col = alloca i32, align 4
    store i32 %_col, i32* %col, align 4
    %index = alloca i32, align 4
    %1 = load i32* %row, align 4
    %2 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 3
    %3 = load i32* %2, align 4
    %4 = mul nsw i32 %1, %3
    %5 = load i32* %col, align 4
    %6 = add nsw i32 %4, %5
    store i32 %6, i32* %index, align 4
    %7 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 1
    %8 = load %struct.$IntArray** %7, align 8
    %9 = load i32* %index, align 4
    %10 = call i32 @$IntArray_Read(%struct.$IntArray* %8, i32 %9)
    ret i32 %10
}

define %struct.Matrix* @Matrix$setAt(%struct.Matrix* %this, i32 %_row, i32 %_col, i32 %_value) nounwind ssp {
    %row = alloca i32, align 4
    store i32 %_row, i32* %row, align 4
    %col = alloca i32, align 4
    store i32 %_col, i32* %col, align 4
    %value = alloca i32, align 4
    store i32 %_value, i32* %value, align 4
    
    %1 = load i32* %row, align 4
    %2 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 3
    %3 = load i32* %2, align 4
    %4 = mul nsw i32 %1, %3
    %5 = load i32* %col, align 4
    %6 = add nsw i32 %4, %5
    %7 = load i32* %value, align 4
    %8 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 1
    %9 = load %struct.$IntArray** %8, align 8
    %10 = call %struct.$IntArray* @$IntArray_Assign(%struct.$IntArray* %9, i32 %6, i32 %7)
    %11 = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %this, %struct.Matrix** %11, align 8
    %12 = load %struct.Matrix** %11, align 8
    ret %struct.Matrix* %12
}

define %struct.Matrix* @Matrix$plus(%struct.Matrix* %this, %struct.Matrix* %_mat) nounwind ssp {
    %mat = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %_mat, %struct.Matrix** %mat, align 8
    %res = alloca %struct.Matrix*, align 8
    %i = alloca i32, align 4
    %j = alloca i32, align 4
    %1 = call %struct.Matrix* @new$Matrix()
    %2 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %3 = load i32* %2, align 4
    %4 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 3
    %5 = load i32* %4, align 4
    %6 = getelementptr inbounds %struct.Matrix* %1, i32 0, i32 0
    %7 = load %struct.Matrix$vtable** %6, align 8
    %8 = getelementptr inbounds %struct.Matrix$vtable* %7, i32 0, i32 0
    %9 = load %struct.Matrix* (%struct.Matrix*, i32, i32)** %8, align 8
    %10 = call %struct.Matrix* %9(%struct.Matrix* %1, i32 %3, i32 %5)
    store %struct.Matrix* %10, %struct.Matrix** %res, align 8
    %11 = alloca i32, align 4
    store i32 0, i32* %11, align 4
    %12 = load i32* %11, align 4
    store i32 %12, i32* %i, align 4
    br label %13
    
; <label>: %13
    %14 = load i32* %i, align 4
    %15 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %16 = load i32* %15, align 4
    %17 = icmp slt i32 %14, %16
    br i1 %17, label %18, label %62
    
; <label>: %18
    %19 = alloca i32, align 4
    store i32 0, i32* %19, align 4
    %20 = load i32* %19, align 4
    store i32 %20, i32* %j, align 4
    br label %21
    
; <label>: %21
    %22 = load i32* %j, align 4
    %23 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 3
    %24 = load i32* %23, align 4
    %25 = icmp slt i32 %22, %24
    br i1 %25, label %26, label %57
    
; <label>: %26
    %27 = load %struct.Matrix** %res, align 8
    %28 = load i32* %i, align 4
    %29 = load i32* %j, align 4
    %30 = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %this, %struct.Matrix** %30, align 8
    %31 = load %struct.Matrix** %30, align 8
    %32 = load i32* %i, align 4
    %33 = load i32* %j, align 4
    %34 = getelementptr inbounds %struct.Matrix* %31, i32 0, i32 0
    %35 = load %struct.Matrix$vtable** %34, align 8
    %36 = getelementptr inbounds %struct.Matrix$vtable* %35, i32 0, i32 3
    %37 = load i32 (%struct.Matrix*, i32, i32)** %36, align 8
    %38 = call i32 %37(%struct.Matrix* %31, i32 %32, i32 %33)
    %39 = load %struct.Matrix** %mat, align 8
    %40 = load i32* %i, align 4
    %41 = load i32* %j, align 4
    %42 = getelementptr inbounds %struct.Matrix* %39, i32 0, i32 0
    %43 = load %struct.Matrix$vtable** %42, align 8
    %44 = getelementptr inbounds %struct.Matrix$vtable* %43, i32 0, i32 3
    %45 = load i32 (%struct.Matrix*, i32, i32)** %44, align 8
    %46 = call i32 %45(%struct.Matrix* %39, i32 %40, i32 %41)
    %47 = add nsw i32 %38, %46
    %48 = getelementptr inbounds %struct.Matrix* %27, i32 0, i32 0
    %49 = load %struct.Matrix$vtable** %48, align 8
    %50 = getelementptr inbounds %struct.Matrix$vtable* %49, i32 0, i32 4
    %51 = load %struct.Matrix* (%struct.Matrix*, i32, i32, i32)** %50, align 8
    %52 = call %struct.Matrix* %51(%struct.Matrix* %27, i32 %28, i32 %29, i32 %47)
    store %struct.Matrix* %52, %struct.Matrix** %res, align 8
    %53 = load i32* %j, align 4
    %54 = alloca i32, align 4
    store i32 1, i32* %54, align 4
    %55 = load i32* %54, align 4
    %56 = add nsw i32 %53, %55
    store i32 %56, i32* %j, align 4
    br label %21
    
; <label>: %57
    %58 = load i32* %i, align 4
    %59 = alloca i32, align 4
    store i32 1, i32* %59, align 4
    %60 = load i32* %59, align 4
    %61 = add nsw i32 %58, %60
    store i32 %61, i32* %i, align 4
    br label %13
    
; <label>: %62
    %63 = load %struct.Matrix** %res, align 8
    ret %struct.Matrix* %63
}

define %struct.Matrix* @Matrix$times(%struct.Matrix* %this, %struct.Matrix* %_mat) nounwind ssp {
    %mat = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %_mat, %struct.Matrix** %mat, align 8
    %res = alloca %struct.Matrix*, align 8
    %i = alloca i32, align 4
    %j = alloca i32, align 4
    %k = alloca i32, align 4
    %sum = alloca i32, align 4
    %1 = call %struct.Matrix* @new$Matrix()
    %2 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %3 = load i32* %2, align 4
    %4 = load %struct.Matrix** %mat, align 8
    %5 = getelementptr inbounds %struct.Matrix* %4, i32 0, i32 0
    %6 = load %struct.Matrix$vtable** %5, align 8
    %7 = getelementptr inbounds %struct.Matrix$vtable* %6, i32 0, i32 2
    %8 = load i32 (%struct.Matrix*)** %7, align 8
    %9 = call i32 %8(%struct.Matrix* %4)
    %10 = getelementptr inbounds %struct.Matrix* %1, i32 0, i32 0
    %11 = load %struct.Matrix$vtable** %10, align 8
    %12 = getelementptr inbounds %struct.Matrix$vtable* %11, i32 0, i32 0
    %13 = load %struct.Matrix* (%struct.Matrix*, i32, i32)** %12, align 8
    %14 = call %struct.Matrix* %13(%struct.Matrix* %1, i32 %3, i32 %9)
    store %struct.Matrix* %14, %struct.Matrix** %res, align 8
    %15 = alloca i32, align 4
    store i32 0, i32* %15, align 4
    %16 = load i32* %15, align 4
    store i32 %16, i32* %i, align 4
    br label %17
    
; <label>: %17
    %18 = load i32* %i, align 4
    %19 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %20 = load i32* %19, align 4
    %21 = icmp slt i32 %18, %20
    br i1 %21, label %22, label %88
    
; <label>: %22
    %23 = alloca i32, align 4
    store i32 0, i32* %23, align 4
    %24 = load i32* %23, align 4
    store i32 %24, i32* %j, align 4
    br label %25
    
; <label>: %25
    %26 = load i32* %j, align 4
    %27 = load %struct.Matrix** %mat, align 8
    %28 = getelementptr inbounds %struct.Matrix* %27, i32 0, i32 0
    %29 = load %struct.Matrix$vtable** %28, align 8
    %30 = getelementptr inbounds %struct.Matrix$vtable* %29, i32 0, i32 2
    %31 = load i32 (%struct.Matrix*)** %30, align 8
    %32 = call i32 %31(%struct.Matrix* %27)
    %33 = icmp slt i32 %26, %32
    br i1 %33, label %34, label %83
    
; <label>: %34
    %35 = alloca i32, align 4
    store i32 0, i32* %35, align 4
    %36 = load i32* %35, align 4
    store i32 %36, i32* %k, align 4
    %37 = alloca i32, align 4
    store i32 0, i32* %37, align 4
    %38 = load i32* %37, align 4
    store i32 %38, i32* %sum, align 4
    br label %39
    
; <label>: %39
    %40 = load i32* %k, align 4
    %41 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 3
    %42 = load i32* %41, align 4
    %43 = icmp slt i32 %40, %42
    br i1 %43, label %44, label %69
    
; <label>: %44
    %45 = load i32* %sum, align 4
    %46 = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %this, %struct.Matrix** %46, align 8
    %47 = load %struct.Matrix** %46, align 8
    %48 = load i32* %i, align 4
    %49 = load i32* %k, align 4
    %50 = getelementptr inbounds %struct.Matrix* %47, i32 0, i32 0
    %51 = load %struct.Matrix$vtable** %50, align 8
    %52 = getelementptr inbounds %struct.Matrix$vtable* %51, i32 0, i32 3
    %53 = load i32 (%struct.Matrix*, i32, i32)** %52, align 8
    %54 = call i32 %53(%struct.Matrix* %47, i32 %48, i32 %49)
    %55 = load %struct.Matrix** %mat, align 8
    %56 = load i32* %k, align 4
    %57 = load i32* %j, align 4
    %58 = getelementptr inbounds %struct.Matrix* %55, i32 0, i32 0
    %59 = load %struct.Matrix$vtable** %58, align 8
    %60 = getelementptr inbounds %struct.Matrix$vtable* %59, i32 0, i32 3
    %61 = load i32 (%struct.Matrix*, i32, i32)** %60, align 8
    %62 = call i32 %61(%struct.Matrix* %55, i32 %56, i32 %57)
    %63 = mul nsw i32 %54, %62
    %64 = add nsw i32 %45, %63
    store i32 %64, i32* %sum, align 4
    %65 = load i32* %k, align 4
    %66 = alloca i32, align 4
    store i32 1, i32* %66, align 4
    %67 = load i32* %66, align 4
    %68 = add nsw i32 %65, %67
    store i32 %68, i32* %k, align 4
    br label %39
    
; <label>: %69
    %70 = load %struct.Matrix** %res, align 8
    %71 = load i32* %i, align 4
    %72 = load i32* %j, align 4
    %73 = load i32* %sum, align 4
    %74 = getelementptr inbounds %struct.Matrix* %70, i32 0, i32 0
    %75 = load %struct.Matrix$vtable** %74, align 8
    %76 = getelementptr inbounds %struct.Matrix$vtable* %75, i32 0, i32 4
    %77 = load %struct.Matrix* (%struct.Matrix*, i32, i32, i32)** %76, align 8
    %78 = call %struct.Matrix* %77(%struct.Matrix* %70, i32 %71, i32 %72, i32 %73)
    store %struct.Matrix* %78, %struct.Matrix** %res, align 8
    %79 = load i32* %j, align 4
    %80 = alloca i32, align 4
    store i32 1, i32* %80, align 4
    %81 = load i32* %80, align 4
    %82 = add nsw i32 %79, %81
    store i32 %82, i32* %j, align 4
    br label %25
    
; <label>: %83
    %84 = load i32* %i, align 4
    %85 = alloca i32, align 4
    store i32 1, i32* %85, align 4
    %86 = load i32* %85, align 4
    %87 = add nsw i32 %84, %86
    store i32 %87, i32* %i, align 4
    br label %17
    
; <label>: %88
    %89 = load %struct.Matrix** %res, align 8
    ret %struct.Matrix* %89
}

define i32 @Matrix$det(%struct.Matrix* %this) nounwind ssp {
    %res = alloca i32, align 4
    %i = alloca i32, align 4
    %neg = alloca i32, align 4
    %mat = alloca %struct.Matrix*, align 8
    %1 = alloca i32, align 4
    store i32 0, i32* %1, align 4
    %2 = load i32* %1, align 4
    store i32 %2, i32* %res, align 4
    %3 = alloca i32, align 4
    store i32 0, i32* %3, align 4
    %4 = load i32* %3, align 4
    store i32 %4, i32* %i, align 4
    %5 = alloca i32, align 4
    store i32 1, i32* %5, align 4
    %6 = load i32* %5, align 4
    store i32 %6, i32* %neg, align 4
    %7 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %8 = load i32* %7, align 4
    %9 = alloca i32, align 4
    store i32 1, i32* %9, align 4
    %10 = load i32* %9, align 4
    %11 = icmp eq  i32 %8, %10
    br i1 %11, label %12, label %24
    
; <label>: %12
    %13 = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %this, %struct.Matrix** %13, align 8
    %14 = load %struct.Matrix** %13, align 8
    %15 = alloca i32, align 4
    store i32 0, i32* %15, align 4
    %16 = load i32* %15, align 4
    %17 = alloca i32, align 4
    store i32 0, i32* %17, align 4
    %18 = load i32* %17, align 4
    %19 = getelementptr inbounds %struct.Matrix* %14, i32 0, i32 0
    %20 = load %struct.Matrix$vtable** %19, align 8
    %21 = getelementptr inbounds %struct.Matrix$vtable* %20, i32 0, i32 3
    %22 = load i32 (%struct.Matrix*, i32, i32)** %21, align 8
    %23 = call i32 %22(%struct.Matrix* %14, i32 %16, i32 %18)
    store i32 %23, i32* %res, align 4
    br label %69
    
; <label>: %24
    br label %25
    
; <label>: %25
    %26 = load i32* %i, align 4
    %27 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %28 = load i32* %27, align 4
    %29 = icmp slt i32 %26, %28
    br i1 %29, label %30, label %68
    
; <label>: %30
    %31 = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %this, %struct.Matrix** %31, align 8
    %32 = load %struct.Matrix** %31, align 8
    %33 = load i32* %i, align 4
    %34 = getelementptr inbounds %struct.Matrix* %32, i32 0, i32 0
    %35 = load %struct.Matrix$vtable** %34, align 8
    %36 = getelementptr inbounds %struct.Matrix$vtable* %35, i32 0, i32 8
    %37 = load %struct.Matrix* (%struct.Matrix*, i32)** %36, align 8
    %38 = call %struct.Matrix* %37(%struct.Matrix* %32, i32 %33)
    store %struct.Matrix* %38, %struct.Matrix** %mat, align 8
    %39 = load i32* %res, align 4
    %40 = load i32* %neg, align 4
    %41 = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %this, %struct.Matrix** %41, align 8
    %42 = load %struct.Matrix** %41, align 8
    %43 = load i32* %i, align 4
    %44 = alloca i32, align 4
    store i32 0, i32* %44, align 4
    %45 = load i32* %44, align 4
    %46 = getelementptr inbounds %struct.Matrix* %42, i32 0, i32 0
    %47 = load %struct.Matrix$vtable** %46, align 8
    %48 = getelementptr inbounds %struct.Matrix$vtable* %47, i32 0, i32 3
    %49 = load i32 (%struct.Matrix*, i32, i32)** %48, align 8
    %50 = call i32 %49(%struct.Matrix* %42, i32 %43, i32 %45)
    %51 = mul nsw i32 %40, %50
    %52 = load %struct.Matrix** %mat, align 8
    %53 = getelementptr inbounds %struct.Matrix* %52, i32 0, i32 0
    %54 = load %struct.Matrix$vtable** %53, align 8
    %55 = getelementptr inbounds %struct.Matrix$vtable* %54, i32 0, i32 7
    %56 = load i32 (%struct.Matrix*)** %55, align 8
    %57 = call i32 %56(%struct.Matrix* %52)
    %58 = mul nsw i32 %51, %57
    %59 = add nsw i32 %39, %58
    store i32 %59, i32* %res, align 4
    %60 = alloca i32, align 4
    store i32 0, i32* %60, align 4
    %61 = load i32* %60, align 4
    %62 = load i32* %neg, align 4
    %63 = sub nsw i32 %61, %62
    store i32 %63, i32* %neg, align 4
    %64 = load i32* %i, align 4
    %65 = alloca i32, align 4
    store i32 1, i32* %65, align 4
    %66 = load i32* %65, align 4
    %67 = add nsw i32 %64, %66
    store i32 %67, i32* %i, align 4
    br label %25
    
; <label>: %68
    br label %69
    
; <label>: %69
    %70 = load i32* %res, align 4
    ret i32 %70
}

define %struct.Matrix* @Matrix$extractSubMatrix(%struct.Matrix* %this, i32 %_row) nounwind ssp {
    %row = alloca i32, align 4
    store i32 %_row, i32* %row, align 4
    %mat = alloca %struct.Matrix*, align 8
    %i = alloca i32, align 4
    %j = alloca i32, align 4
    %k = alloca i32, align 4
    %1 = alloca i32, align 4
    store i32 0, i32* %1, align 4
    %2 = load i32* %1, align 4
    store i32 %2, i32* %i, align 4
    %3 = alloca i32, align 4
    store i32 0, i32* %3, align 4
    %4 = load i32* %3, align 4
    store i32 %4, i32* %j, align 4
    %5 = alloca i32, align 4
    store i32 0, i32* %5, align 4
    %6 = load i32* %5, align 4
    store i32 %6, i32* %k, align 4
    %7 = call %struct.Matrix* @new$Matrix()
    %8 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %9 = load i32* %8, align 4
    %10 = alloca i32, align 4
    store i32 1, i32* %10, align 4
    %11 = load i32* %10, align 4
    %12 = sub nsw i32 %9, %11
    %13 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 3
    %14 = load i32* %13, align 4
    %15 = alloca i32, align 4
    store i32 1, i32* %15, align 4
    %16 = load i32* %15, align 4
    %17 = sub nsw i32 %14, %16
    %18 = getelementptr inbounds %struct.Matrix* %7, i32 0, i32 0
    %19 = load %struct.Matrix$vtable** %18, align 8
    %20 = getelementptr inbounds %struct.Matrix$vtable* %19, i32 0, i32 0
    %21 = load %struct.Matrix* (%struct.Matrix*, i32, i32)** %20, align 8
    %22 = call %struct.Matrix* %21(%struct.Matrix* %7, i32 %12, i32 %17)
    store %struct.Matrix* %22, %struct.Matrix** %mat, align 8
    br label %23
    
; <label>: %23
    %24 = load i32* %i, align 4
    %25 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %26 = load i32* %25, align 4
    %27 = alloca i32, align 4
    store i32 1, i32* %27, align 4
    %28 = load i32* %27, align 4
    %29 = sub nsw i32 %26, %28
    %30 = icmp slt i32 %24, %29
    br i1 %30, label %31, label %83
    
; <label>: %31
    %32 = load i32* %k, align 4
    %33 = load i32* %row, align 4
    %34 = icmp eq  i32 %32, %33
    %35 = xor i1 %34, 1
    br i1 %35, label %36, label %78
    
; <label>: %36
    %37 = alloca i32, align 4
    store i32 0, i32* %37, align 4
    %38 = load i32* %37, align 4
    store i32 %38, i32* %j, align 4
    br label %39
    
; <label>: %39
    %40 = load i32* %j, align 4
    %41 = load %struct.Matrix** %mat, align 8
    %42 = getelementptr inbounds %struct.Matrix* %41, i32 0, i32 0
    %43 = load %struct.Matrix$vtable** %42, align 8
    %44 = getelementptr inbounds %struct.Matrix$vtable* %43, i32 0, i32 2
    %45 = load i32 (%struct.Matrix*)** %44, align 8
    %46 = call i32 %45(%struct.Matrix* %41)
    %47 = icmp slt i32 %40, %46
    br i1 %47, label %48, label %73
    
; <label>: %48
    %49 = load %struct.Matrix** %mat, align 8
    %50 = load i32* %i, align 4
    %51 = load i32* %j, align 4
    %52 = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %this, %struct.Matrix** %52, align 8
    %53 = load %struct.Matrix** %52, align 8
    %54 = load i32* %k, align 4
    %55 = load i32* %j, align 4
    %56 = alloca i32, align 4
    store i32 1, i32* %56, align 4
    %57 = load i32* %56, align 4
    %58 = add nsw i32 %55, %57
    %59 = getelementptr inbounds %struct.Matrix* %53, i32 0, i32 0
    %60 = load %struct.Matrix$vtable** %59, align 8
    %61 = getelementptr inbounds %struct.Matrix$vtable* %60, i32 0, i32 3
    %62 = load i32 (%struct.Matrix*, i32, i32)** %61, align 8
    %63 = call i32 %62(%struct.Matrix* %53, i32 %54, i32 %58)
    %64 = getelementptr inbounds %struct.Matrix* %49, i32 0, i32 0
    %65 = load %struct.Matrix$vtable** %64, align 8
    %66 = getelementptr inbounds %struct.Matrix$vtable* %65, i32 0, i32 4
    %67 = load %struct.Matrix* (%struct.Matrix*, i32, i32, i32)** %66, align 8
    %68 = call %struct.Matrix* %67(%struct.Matrix* %49, i32 %50, i32 %51, i32 %63)
    store %struct.Matrix* %68, %struct.Matrix** %mat, align 8
    %69 = load i32* %j, align 4
    %70 = alloca i32, align 4
    store i32 1, i32* %70, align 4
    %71 = load i32* %70, align 4
    %72 = add nsw i32 %69, %71
    store i32 %72, i32* %j, align 4
    br label %39
    
; <label>: %73
    %74 = load i32* %i, align 4
    %75 = alloca i32, align 4
    store i32 1, i32* %75, align 4
    %76 = load i32* %75, align 4
    %77 = add nsw i32 %74, %76
    store i32 %77, i32* %i, align 4
    br label %78
    
; <label>: %78
    %79 = load i32* %k, align 4
    %80 = alloca i32, align 4
    store i32 1, i32* %80, align 4
    %81 = load i32* %80, align 4
    %82 = add nsw i32 %79, %81
    store i32 %82, i32* %k, align 4
    br label %23
    
; <label>: %83
    %84 = load %struct.Matrix** %mat, align 8
    ret %struct.Matrix* %84
}

define i8* @Matrix$toString(%struct.Matrix* %this) nounwind ssp {
    %row = alloca i32, align 4
    %col = alloca i32, align 4
    %str = alloca i8*, align 8
    %1 = alloca i32, align 4
    store i32 0, i32* %1, align 4
    %2 = load i32* %1, align 4
    store i32 %2, i32* %row, align 4
    %3 = alloca i32, align 4
    store i32 0, i32* %3, align 4
    %4 = load i32* %3, align 4
    store i32 %4, i32* %col, align 4
    %5 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str12, i32 0, i32 0), i8** %5, align 8
    %6 = load i8** %5, align 8
    store i8* %6, i8** %str, align 8
    br label %7
    
; <label>: %7
    %8 = load i32* %row, align 4
    %9 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %10 = load i32* %9, align 4
    %11 = icmp slt i32 %8, %10
    br i1 %11, label %12, label %69
    
; <label>: %12
    %13 = alloca i32, align 4
    store i32 0, i32* %13, align 4
    %14 = load i32* %13, align 4
    store i32 %14, i32* %col, align 4
    %15 = load i8** %str, align 8
    %16 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str13, i32 0, i32 0), i8** %16, align 8
    %17 = load i8** %16, align 8
    %18 = call i8* @$concat(i8* %15, i8* %17)
    store i8* %18, i8** %str, align 8
    br label %19
    
; <label>: %19
    %20 = load i32* %col, align 4
    %21 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 3
    %22 = load i32* %21, align 4
    %23 = icmp slt i32 %20, %22
    br i1 %23, label %24, label %50
    
; <label>: %24
    %25 = load i8** %str, align 8
    %26 = alloca %struct.Matrix*, align 8
    store %struct.Matrix* %this, %struct.Matrix** %26, align 8
    %27 = load %struct.Matrix** %26, align 8
    %28 = load i32* %row, align 4
    %29 = load i32* %col, align 4
    %30 = getelementptr inbounds %struct.Matrix* %27, i32 0, i32 0
    %31 = load %struct.Matrix$vtable** %30, align 8
    %32 = getelementptr inbounds %struct.Matrix$vtable* %31, i32 0, i32 3
    %33 = load i32 (%struct.Matrix*, i32, i32)** %32, align 8
    %34 = call i32 %33(%struct.Matrix* %27, i32 %28, i32 %29)
    %35 = call i8* @$concatStringInt(i8* %25, i32 %34)
    store i8* %35, i8** %str, align 8
    %36 = load i32* %col, align 4
    %37 = alloca i32, align 4
    store i32 1, i32* %37, align 4
    %38 = load i32* %37, align 4
    %39 = add nsw i32 %36, %38
    store i32 %39, i32* %col, align 4
    %40 = load i32* %col, align 4
    %41 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 3
    %42 = load i32* %41, align 4
    %43 = icmp slt i32 %40, %42
    br i1 %43, label %44, label %49
    
; <label>: %44
    %45 = load i8** %str, align 8
    %46 = alloca i8*, align 8
    store i8* getelementptr inbounds ([3 x i8]* @.str14, i32 0, i32 0), i8** %46, align 8
    %47 = load i8** %46, align 8
    %48 = call i8* @$concat(i8* %45, i8* %47)
    store i8* %48, i8** %str, align 8
    br label %49
    
; <label>: %49
    br label %19
    
; <label>: %50
    %51 = load i8** %str, align 8
    %52 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str15, i32 0, i32 0), i8** %52, align 8
    %53 = load i8** %52, align 8
    %54 = call i8* @$concat(i8* %51, i8* %53)
    store i8* %54, i8** %str, align 8
    %55 = load i32* %row, align 4
    %56 = alloca i32, align 4
    store i32 1, i32* %56, align 4
    %57 = load i32* %56, align 4
    %58 = add nsw i32 %55, %57
    store i32 %58, i32* %row, align 4
    %59 = load i32* %row, align 4
    %60 = getelementptr inbounds %struct.Matrix* %this, i32 0, i32 2
    %61 = load i32* %60, align 4
    %62 = icmp slt i32 %59, %61
    br i1 %62, label %63, label %68
    
; <label>: %63
    %64 = load i8** %str, align 8
    %65 = alloca i8*, align 8
    store i8* getelementptr inbounds ([3 x i8]* @.str16, i32 0, i32 0), i8** %65, align 8
    %66 = load i8** %65, align 8
    %67 = call i8* @$concat(i8* %64, i8* %66)
    store i8* %67, i8** %str, align 8
    br label %68
    
; <label>: %68
    br label %7
    
; <label>: %69
    %70 = load i8** %str, align 8
    %71 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str17, i32 0, i32 0), i8** %71, align 8
    %72 = load i8** %71, align 8
    %73 = call i8* @$concat(i8* %70, i8* %72)
    store i8* %73, i8** %str, align 8
    %74 = load i8** %str, align 8
    ret i8* %74
}

define i32 @main() nounwind ssp {
    %1 = call %struct.Test* @new$Test()
    %2 = getelementptr inbounds %struct.Test* %1, i32 0, i32 0
    %3 = load %struct.Test$vtable** %2, align 8
    %4 = getelementptr inbounds %struct.Test$vtable* %3, i32 0, i32 0
    %5 = load i1 (%struct.Test*)** %4, align 8
    %6 = call i1 %5(%struct.Test* %1)
    %7 = call i8* @boolToString(i1 %6)
    %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %7)
    %9 = load %struct._List** @l, align 8
    call void @_List_free(%struct._List* %9)
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