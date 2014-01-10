; ModuleID = 'Factorial.tool'
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

%struct.Fact = type <{ %struct.Fact$vtable* }>
%struct.Fact$vtable = type { i32 (%struct.Fact*, i32)* }
@Fact$vtable = global %struct.Fact$vtable { i32 (%struct.Fact*, i32)* @Fact$computeFactorial }, align 8

define %struct.Fact* @new$Fact() nounwind ssp {
    %obj = alloca %struct.Fact*, align 8
    %1 = call i8* @_mymalloc(i64 8)
    %2 = bitcast i8* %1 to %struct.Fact*
    store %struct.Fact* %2, %struct.Fact** %obj, align 8
    %3 = load %struct.Fact** %obj, align 8
    %4 = getelementptr inbounds %struct.Fact* %3, i32 0, i32 0
    store %struct.Fact$vtable* @Fact$vtable, %struct.Fact$vtable** %4, align 8
    %5 = load %struct.Fact** %obj, align 8
    ret %struct.Fact* %5
}

define i32 @Fact$computeFactorial(%struct.Fact* %this, i32 %_num) nounwind ssp {
    %num = alloca i32, align 4
    store i32 %_num, i32* %num, align 4
    %num_aux = alloca i32, align 4
    %1 = load i32* %num, align 4
    %2 = alloca i32, align 4
    store i32 0, i32* %2, align 4
    %3 = load i32* %2, align 4
    %4 = icmp slt i32 %1, %3
    br label %5
    
; <label>: %5
    br i1 %4, label %12, label %6
    
; <label>: %6
    %7 = load i32* %num, align 4
    %8 = alloca i32, align 4
    store i32 1, i32* %8, align 4
    %9 = load i32* %8, align 4
    %10 = icmp eq  i32 %7, %9
    br label %11
    
; <label>: %11
    br label %12
    
; <label>: %12
    %13 = phi i1 [ true, %5 ], [ %10, %11 ]
    br i1 %13, label %14, label %17
    
; <label>: %14
    %15 = alloca i32, align 4
    store i32 1, i32* %15, align 4
    %16 = load i32* %15, align 4
    store i32 %16, i32* %num_aux, align 4
    br label %31
    
; <label>: %17
    %18 = load i32* %num, align 4
    %19 = alloca %struct.Fact*, align 8
    store %struct.Fact* %this, %struct.Fact** %19, align 8
    %20 = load %struct.Fact** %19, align 8
    %21 = load i32* %num, align 4
    %22 = alloca i32, align 4
    store i32 1, i32* %22, align 4
    %23 = load i32* %22, align 4
    %24 = sub nsw i32 %21, %23
    %25 = getelementptr inbounds %struct.Fact* %20, i32 0, i32 0
    %26 = load %struct.Fact$vtable** %25, align 8
    %27 = getelementptr inbounds %struct.Fact$vtable* %26, i32 0, i32 0
    %28 = load i32 (%struct.Fact*, i32)** %27, align 8
    %29 = call i32 %28(%struct.Fact* %20, i32 %24)
    %30 = mul nsw i32 %18, %29
    store i32 %30, i32* %num_aux, align 4
    br label %31
    
; <label>: %31
    %32 = load i32* %num_aux, align 4
    ret i32 %32
}

define i32 @main() nounwind ssp {
    %1 = call %struct.Fact* @new$Fact()
    %2 = alloca i32, align 4
    store i32 10, i32* %2, align 4
    %3 = load i32* %2, align 4
    %4 = getelementptr inbounds %struct.Fact* %1, i32 0, i32 0
    %5 = load %struct.Fact$vtable** %4, align 8
    %6 = getelementptr inbounds %struct.Fact$vtable* %5, i32 0, i32 0
    %7 = load i32 (%struct.Fact*, i32)** %6, align 8
    %8 = call i32 %7(%struct.Fact* %1, i32 %3)
    %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %8)
    %10 = load %struct._List** @l, align 8
    call void @_List_free(%struct._List* %10)
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