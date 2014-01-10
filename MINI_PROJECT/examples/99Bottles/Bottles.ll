; ModuleID = '99Bottles.tool'
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
@.str5 = private unnamed_addr constant [1 x i8] c"\00"
@.str6 = private unnamed_addr constant [1 x i8] c"\00"
@.str7 = private unnamed_addr constant [62 x i8] c"No more bottles of beer on the wall, no more bottles of beer.\00"
@.str8 = private unnamed_addr constant [48 x i8] c"1 bottle of beer on the wall, 1 bottle of beer.\00"
@.str9 = private unnamed_addr constant [31 x i8] c" bottles of beer on the wall, \00"
@.str10 = private unnamed_addr constant [18 x i8] c" bottles of beer.\00"
@.str11 = private unnamed_addr constant [1 x i8] c"\00"
@.str12 = private unnamed_addr constant [67 x i8] c"Go to the store and buy some more, 99 bottles of beer on the wall.\00"
@.str13 = private unnamed_addr constant [71 x i8] c"Take one down and pass it around, no more bottles of beer on the wall.\00"
@.str14 = private unnamed_addr constant [64 x i8] c"Take one down and pass it around, 1 bottle of beer on the wall.\00"
@.str15 = private unnamed_addr constant [35 x i8] c"Take one down and pass it around, \00"
@.str16 = private unnamed_addr constant [30 x i8] c" bottles of beer on the wall.\00"
@.str17 = private unnamed_addr constant [11 x i8] c"INFO: Done\00"

%struct.Wall = type <{ %struct.Wall$vtable*, i32 }>
%struct.Wall$vtable = type { i1 (%struct.Wall*)* , i32 (%struct.Wall*)* , i32 (%struct.Wall*)* , i8* (%struct.Wall*)* , i8* (%struct.Wall*)* }
@Wall$vtable = global %struct.Wall$vtable { i1 (%struct.Wall*)* @Wall$sing , i32 (%struct.Wall*)* @Wall$placeBottles , i32 (%struct.Wall*)* @Wall$drink , i8* (%struct.Wall*)* @Wall$whatsOnTheWall , i8* (%struct.Wall*)* @Wall$whatDoWeDoWithTheBottle }, align 8

define %struct.Wall* @new$Wall() nounwind ssp {
    %obj = alloca %struct.Wall*, align 8
    %1 = call i8* @_mymalloc(i64 12)
    %2 = bitcast i8* %1 to %struct.Wall*
    store %struct.Wall* %2, %struct.Wall** %obj, align 8
    %3 = load %struct.Wall** %obj, align 8
    %4 = getelementptr inbounds %struct.Wall* %3, i32 0, i32 0
    store %struct.Wall$vtable* @Wall$vtable, %struct.Wall$vtable** %4, align 8
    %5 = load %struct.Wall** %obj, align 8
    ret %struct.Wall* %5
}

define i1 @Wall$sing(%struct.Wall* %this) nounwind ssp {
    %i = alloca i32, align 4
    %dummy = alloca i32, align 4
    %1 = alloca %struct.Wall*, align 8
    store %struct.Wall* %this, %struct.Wall** %1, align 8
    %2 = load %struct.Wall** %1, align 8
    %3 = getelementptr inbounds %struct.Wall* %2, i32 0, i32 0
    %4 = load %struct.Wall$vtable** %3, align 8
    %5 = getelementptr inbounds %struct.Wall$vtable* %4, i32 0, i32 1
    %6 = load i32 (%struct.Wall*)** %5, align 8
    %7 = call i32 %6(%struct.Wall* %2)
    store i32 %7, i32* %dummy, align 4
    %8 = alloca i32, align 4
    store i32 0, i32* %8, align 4
    %9 = load i32* %8, align 4
    store i32 %9, i32* %i, align 4
    br label %10
    
; <label>: %10
    %11 = load i32* %i, align 4
    %12 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %13 = load i32* %12, align 4
    %14 = alloca i32, align 4
    store i32 1, i32* %14, align 4
    %15 = load i32* %14, align 4
    %16 = add nsw i32 %13, %15
    %17 = icmp slt i32 %11, %16
    br i1 %17, label %18, label %45
    
; <label>: %18
    %19 = alloca %struct.Wall*, align 8
    store %struct.Wall* %this, %struct.Wall** %19, align 8
    %20 = load %struct.Wall** %19, align 8
    %21 = getelementptr inbounds %struct.Wall* %20, i32 0, i32 0
    %22 = load %struct.Wall$vtable** %21, align 8
    %23 = getelementptr inbounds %struct.Wall$vtable* %22, i32 0, i32 3
    %24 = load i8* (%struct.Wall*)** %23, align 8
    %25 = call i8* %24(%struct.Wall* %20)
    %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %25)
    %27 = alloca %struct.Wall*, align 8
    store %struct.Wall* %this, %struct.Wall** %27, align 8
    %28 = load %struct.Wall** %27, align 8
    %29 = getelementptr inbounds %struct.Wall* %28, i32 0, i32 0
    %30 = load %struct.Wall$vtable** %29, align 8
    %31 = getelementptr inbounds %struct.Wall$vtable* %30, i32 0, i32 4
    %32 = load i8* (%struct.Wall*)** %31, align 8
    %33 = call i8* %32(%struct.Wall* %28)
    %34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %33)
    %35 = alloca %struct.Wall*, align 8
    store %struct.Wall* %this, %struct.Wall** %35, align 8
    %36 = load %struct.Wall** %35, align 8
    %37 = getelementptr inbounds %struct.Wall* %36, i32 0, i32 0
    %38 = load %struct.Wall$vtable** %37, align 8
    %39 = getelementptr inbounds %struct.Wall$vtable* %38, i32 0, i32 2
    %40 = load i32 (%struct.Wall*)** %39, align 8
    %41 = call i32 %40(%struct.Wall* %36)
    store i32 %41, i32* %dummy, align 4
    %42 = alloca i8*, align 8
    store i8* getelementptr inbounds ([1 x i8]* @.str5, i32 0, i32 0), i8** %42, align 8
    %43 = load i8** %42, align 8
    %44 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %43)
    br label %10
    
; <label>: %45
    %46 = alloca i1, align 4
    store i1 true, i1* %46, align 4
    %47 = load i1* %46, align 4
    ret i1 %47
}

define i32 @Wall$placeBottles(%struct.Wall* %this) nounwind ssp {
    
    %1 = alloca i32, align 4
    store i32 99, i32* %1, align 4
    %2 = load i32* %1, align 4
    %3 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    store i32 %2, i32* %3, align 4
    %4 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %5 = load i32* %4, align 4
    ret i32 %5
}

define i32 @Wall$drink(%struct.Wall* %this) nounwind ssp {
    
    %1 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %2 = load i32* %1, align 4
    %3 = alloca i32, align 4
    store i32 1, i32* %3, align 4
    %4 = load i32* %3, align 4
    %5 = sub nsw i32 %2, %4
    %6 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    store i32 %5, i32* %6, align 4
    %7 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %8 = load i32* %7, align 4
    ret i32 %8
}

define i8* @Wall$whatsOnTheWall(%struct.Wall* %this) nounwind ssp {
    %str = alloca i8*, align 8
    %1 = alloca i8*, align 8
    store i8* getelementptr inbounds ([1 x i8]* @.str6, i32 0, i32 0), i8** %1, align 8
    %2 = load i8** %1, align 8
    store i8* %2, i8** %str, align 8
    %3 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %4 = load i32* %3, align 4
    %5 = alloca i32, align 4
    store i32 0, i32* %5, align 4
    %6 = load i32* %5, align 4
    %7 = icmp eq  i32 %4, %6
    br i1 %7, label %8, label %11
    
; <label>: %8
    %9 = alloca i8*, align 8
    store i8* getelementptr inbounds ([62 x i8]* @.str7, i32 0, i32 0), i8** %9, align 8
    %10 = load i8** %9, align 8
    store i8* %10, i8** %str, align 8
    br label %11
    
; <label>: %11
    %12 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %13 = load i32* %12, align 4
    %14 = alloca i32, align 4
    store i32 1, i32* %14, align 4
    %15 = load i32* %14, align 4
    %16 = icmp eq  i32 %13, %15
    br i1 %16, label %17, label %20
    
; <label>: %17
    %18 = alloca i8*, align 8
    store i8* getelementptr inbounds ([48 x i8]* @.str8, i32 0, i32 0), i8** %18, align 8
    %19 = load i8** %18, align 8
    store i8* %19, i8** %str, align 8
    br label %20
    
; <label>: %20
    %21 = alloca i32, align 4
    store i32 1, i32* %21, align 4
    %22 = load i32* %21, align 4
    %23 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %24 = load i32* %23, align 4
    %25 = icmp slt i32 %22, %24
    br i1 %25, label %26, label %38
    
; <label>: %26
    %27 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %28 = load i32* %27, align 4
    %29 = alloca i8*, align 8
    store i8* getelementptr inbounds ([31 x i8]* @.str9, i32 0, i32 0), i8** %29, align 8
    %30 = load i8** %29, align 8
    %31 = call i8* @$concatIntString(i32 %28, i8* %30)
    %32 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %33 = load i32* %32, align 4
    %34 = call i8* @$concatStringInt(i8* %31, i32 %33)
    %35 = alloca i8*, align 8
    store i8* getelementptr inbounds ([18 x i8]* @.str10, i32 0, i32 0), i8** %35, align 8
    %36 = load i8** %35, align 8
    %37 = call i8* @$concat(i8* %34, i8* %36)
    store i8* %37, i8** %str, align 8
    br label %38
    
; <label>: %38
    %39 = load i8** %str, align 8
    ret i8* %39
}

define i8* @Wall$whatDoWeDoWithTheBottle(%struct.Wall* %this) nounwind ssp {
    %str = alloca i8*, align 8
    %1 = alloca i8*, align 8
    store i8* getelementptr inbounds ([1 x i8]* @.str11, i32 0, i32 0), i8** %1, align 8
    %2 = load i8** %1, align 8
    store i8* %2, i8** %str, align 8
    %3 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %4 = load i32* %3, align 4
    %5 = alloca i32, align 4
    store i32 0, i32* %5, align 4
    %6 = load i32* %5, align 4
    %7 = icmp eq  i32 %4, %6
    br i1 %7, label %8, label %11
    
; <label>: %8
    %9 = alloca i8*, align 8
    store i8* getelementptr inbounds ([67 x i8]* @.str12, i32 0, i32 0), i8** %9, align 8
    %10 = load i8** %9, align 8
    store i8* %10, i8** %str, align 8
    br label %11
    
; <label>: %11
    %12 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %13 = load i32* %12, align 4
    %14 = alloca i32, align 4
    store i32 1, i32* %14, align 4
    %15 = load i32* %14, align 4
    %16 = icmp eq  i32 %13, %15
    br i1 %16, label %17, label %20
    
; <label>: %17
    %18 = alloca i8*, align 8
    store i8* getelementptr inbounds ([71 x i8]* @.str13, i32 0, i32 0), i8** %18, align 8
    %19 = load i8** %18, align 8
    store i8* %19, i8** %str, align 8
    br label %20
    
; <label>: %20
    %21 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %22 = load i32* %21, align 4
    %23 = alloca i32, align 4
    store i32 2, i32* %23, align 4
    %24 = load i32* %23, align 4
    %25 = icmp eq  i32 %22, %24
    br i1 %25, label %26, label %29
    
; <label>: %26
    %27 = alloca i8*, align 8
    store i8* getelementptr inbounds ([64 x i8]* @.str14, i32 0, i32 0), i8** %27, align 8
    %28 = load i8** %27, align 8
    store i8* %28, i8** %str, align 8
    br label %29
    
; <label>: %29
    %30 = alloca i32, align 4
    store i32 2, i32* %30, align 4
    %31 = load i32* %30, align 4
    %32 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %33 = load i32* %32, align 4
    %34 = icmp slt i32 %31, %33
    br i1 %34, label %35, label %47
    
; <label>: %35
    %36 = alloca i8*, align 8
    store i8* getelementptr inbounds ([35 x i8]* @.str15, i32 0, i32 0), i8** %36, align 8
    %37 = load i8** %36, align 8
    %38 = getelementptr inbounds %struct.Wall* %this, i32 0, i32 1
    %39 = load i32* %38, align 4
    %40 = alloca i32, align 4
    store i32 1, i32* %40, align 4
    %41 = load i32* %40, align 4
    %42 = sub nsw i32 %39, %41
    %43 = call i8* @$concatStringInt(i8* %37, i32 %42)
    %44 = alloca i8*, align 8
    store i8* getelementptr inbounds ([30 x i8]* @.str16, i32 0, i32 0), i8** %44, align 8
    %45 = load i8** %44, align 8
    %46 = call i8* @$concat(i8* %43, i8* %45)
    store i8* %46, i8** %str, align 8
    br label %47
    
; <label>: %47
    %48 = load i8** %str, align 8
    ret i8* %48
}

define i32 @main() nounwind ssp {
    %1 = call %struct.Wall* @new$Wall()
    %2 = getelementptr inbounds %struct.Wall* %1, i32 0, i32 0
    %3 = load %struct.Wall$vtable** %2, align 8
    %4 = getelementptr inbounds %struct.Wall$vtable* %3, i32 0, i32 0
    %5 = load i1 (%struct.Wall*)** %4, align 8
    %6 = call i1 %5(%struct.Wall* %1)
    br i1 %6, label %7, label %11
    
; <label>: %7
    %8 = alloca i8*, align 8
    store i8* getelementptr inbounds ([11 x i8]* @.str17, i32 0, i32 0), i8** %8, align 8
    %9 = load i8** %8, align 8
    %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %9)
    br label %11
    
; <label>: %11
    %12 = load %struct._List** @l, align 8
    call void @_List_free(%struct._List* %12)
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