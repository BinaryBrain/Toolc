; ModuleID = 'Inheritance.tool'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-pc-linux"

%struct.$IntArray = type <{ i32*, i32 }>
%struct._List = type <{ %struct._List*, i8* }>
@l = global %struct._List* null, align 8

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@.str2 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str3 = private unnamed_addr constant [5 x i8] c"true\00"
@.str4 = private unnamed_addr constant [6 x i8] c"false\00"
@.str5 = private unnamed_addr constant [7 x i8] c"person\00"
@.str6 = private unnamed_addr constant [7 x i8] c"worker\00"
@.str7 = private unnamed_addr constant [5 x i8] c"temp\00"

%struct.Run = type <{ %struct.Run$vtable* }>
%struct.Run$vtable = type { i1 (%struct.Run*)* }
@Run$vtable = global %struct.Run$vtable { i1 (%struct.Run*)* @Run$run }, align 8


%struct.Person = type <{ %struct.Person$vtable*, i8* }>
%struct.Person$vtable = type { i32 (%struct.Person*)* , i8* (%struct.Person*)* , i8* (%struct.Person*, i8*)* }
@Person$vtable = global %struct.Person$vtable { i32 (%struct.Person*)* @Person$Work , i8* (%struct.Person*)* @Person$Name , i8* (%struct.Person*, i8*)* @Person$setName }, align 8


%struct.Worker = type <{ %struct.Worker$vtable*, i8*, i32 }>
%struct.Worker$vtable = type { i32 (%struct.Worker*)* , i8* (%struct.Worker*)* , i8* (%struct.Worker*, i8*)* , i1 (%struct.Worker*, i32)* }
@Worker$vtable = global %struct.Worker$vtable { i32 (%struct.Worker*)* @Worker$Work , i8* (%struct.Worker*)* bitcast (i8* (%struct.Person*)* @Person$Name to i8* (%struct.Worker*)*), i8* (%struct.Worker*, i8*)* bitcast (i8* (%struct.Person*, i8*)* @Person$setName to i8* (%struct.Worker*, i8*)*), i1 (%struct.Worker*, i32)* @Worker$setSalary }, align 8


%struct.Temporary = type <{ %struct.Temporary$vtable*, i8*, i32 }>
%struct.Temporary$vtable = type { i32 (%struct.Temporary*)* , i8* (%struct.Temporary*)* , i8* (%struct.Temporary*, i8*)* , i1 (%struct.Temporary*, i32)* }
@Temporary$vtable = global %struct.Temporary$vtable { i32 (%struct.Temporary*)* @Temporary$Work , i8* (%struct.Temporary*)* bitcast (i8* (%struct.Person*)* @Person$Name to i8* (%struct.Temporary*)*), i8* (%struct.Temporary*, i8*)* bitcast (i8* (%struct.Person*, i8*)* @Person$setName to i8* (%struct.Temporary*, i8*)*), i1 (%struct.Temporary*, i32)* bitcast (i1 (%struct.Worker*, i32)* @Worker$setSalary to i1 (%struct.Temporary*, i32)*)}, align 8

define %struct.Run* @new$Run() nounwind ssp {
    %obj = alloca %struct.Run*, align 8
    %1 = call i8* @_mymalloc(i64 8)
    %2 = bitcast i8* %1 to %struct.Run*
    store %struct.Run* %2, %struct.Run** %obj, align 8
    %3 = load %struct.Run** %obj, align 8
    %4 = getelementptr inbounds %struct.Run* %3, i32 0, i32 0
    store %struct.Run$vtable* @Run$vtable, %struct.Run$vtable** %4, align 8
    %5 = load %struct.Run** %obj, align 8
    ret %struct.Run* %5
}

define i1 @Run$run(%struct.Run* %this) nounwind ssp {
    %pers = alloca %struct.Person*, align 8
    %work = alloca %struct.Worker*, align 8
    %temp = alloca %struct.Temporary*, align 8
    %downcast = alloca %struct.Person*, align 8
    %dummy = alloca i1, align 4
    %upcast = alloca %struct.Temporary*, align 8
    %1 = call %struct.Person* @new$Person()
    store %struct.Person* %1, %struct.Person** %pers, align 8
    %2 = call %struct.Worker* @new$Worker()
    store %struct.Worker* %2, %struct.Worker** %work, align 8
    %3 = call %struct.Temporary* @new$Temporary()
    store %struct.Temporary* %3, %struct.Temporary** %temp, align 8
    %4 = call %struct.Worker* @new$Worker()
    %5 = bitcast %struct.Worker* %4 to %struct.Person*
    store %struct.Person* %5, %struct.Person** %downcast, align 8
    %6 = load %struct.Worker** %work, align 8
    %7 = alloca i32, align 4
    store i32 10, i32* %7, align 4
    %8 = load i32* %7, align 4
    %9 = getelementptr inbounds %struct.Worker* %6, i32 0, i32 0
    %10 = load %struct.Worker$vtable** %9, align 8
    %11 = getelementptr inbounds %struct.Worker$vtable* %10, i32 0, i32 3
    %12 = load i1 (%struct.Worker*, i32)** %11, align 8
    %13 = call i1 %12(%struct.Worker* %6, i32 %8)
    %14 = call i8* @boolToString(i1 %13)
    %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %14)
    %16 = load %struct.Temporary** %temp, align 8
    %17 = alloca i32, align 4
    store i32 10, i32* %17, align 4
    %18 = load i32* %17, align 4
    %19 = getelementptr inbounds %struct.Temporary* %16, i32 0, i32 0
    %20 = load %struct.Temporary$vtable** %19, align 8
    %21 = getelementptr inbounds %struct.Temporary$vtable* %20, i32 0, i32 3
    %22 = load i1 (%struct.Temporary*, i32)** %21, align 8
    %23 = call i1 %22(%struct.Temporary* %16, i32 %18)
    %24 = call i8* @boolToString(i1 %23)
    %25 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %24)
    %26 = load %struct.Person** %pers, align 8
    %27 = getelementptr inbounds %struct.Person* %26, i32 0, i32 0
    %28 = load %struct.Person$vtable** %27, align 8
    %29 = getelementptr inbounds %struct.Person$vtable* %28, i32 0, i32 0
    %30 = load i32 (%struct.Person*)** %29, align 8
    %31 = call i32 %30(%struct.Person* %26)
    %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %31)
    %33 = load %struct.Worker** %work, align 8
    %34 = getelementptr inbounds %struct.Worker* %33, i32 0, i32 0
    %35 = load %struct.Worker$vtable** %34, align 8
    %36 = getelementptr inbounds %struct.Worker$vtable* %35, i32 0, i32 0
    %37 = load i32 (%struct.Worker*)** %36, align 8
    %38 = call i32 %37(%struct.Worker* %33)
    %39 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %38)
    %40 = load %struct.Temporary** %temp, align 8
    %41 = getelementptr inbounds %struct.Temporary* %40, i32 0, i32 0
    %42 = load %struct.Temporary$vtable** %41, align 8
    %43 = getelementptr inbounds %struct.Temporary$vtable* %42, i32 0, i32 0
    %44 = load i32 (%struct.Temporary*)** %43, align 8
    %45 = call i32 %44(%struct.Temporary* %40)
    %46 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %45)
    %47 = load %struct.Person** %pers, align 8
    %48 = alloca i8*, align 8
    store i8* getelementptr inbounds ([7 x i8]* @.str5, i32 0, i32 0), i8** %48, align 8
    %49 = load i8** %48, align 8
    %50 = getelementptr inbounds %struct.Person* %47, i32 0, i32 0
    %51 = load %struct.Person$vtable** %50, align 8
    %52 = getelementptr inbounds %struct.Person$vtable* %51, i32 0, i32 2
    %53 = load i8* (%struct.Person*, i8*)** %52, align 8
    %54 = call i8* %53(%struct.Person* %47, i8* %49)
    %55 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %54)
    %56 = load %struct.Worker** %work, align 8
    %57 = alloca i8*, align 8
    store i8* getelementptr inbounds ([7 x i8]* @.str6, i32 0, i32 0), i8** %57, align 8
    %58 = load i8** %57, align 8
    %59 = getelementptr inbounds %struct.Worker* %56, i32 0, i32 0
    %60 = load %struct.Worker$vtable** %59, align 8
    %61 = getelementptr inbounds %struct.Worker$vtable* %60, i32 0, i32 2
    %62 = load i8* (%struct.Worker*, i8*)** %61, align 8
    %63 = call i8* %62(%struct.Worker* %56, i8* %58)
    %64 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %63)
    %65 = load %struct.Temporary** %temp, align 8
    %66 = alloca i8*, align 8
    store i8* getelementptr inbounds ([5 x i8]* @.str7, i32 0, i32 0), i8** %66, align 8
    %67 = load i8** %66, align 8
    %68 = getelementptr inbounds %struct.Temporary* %65, i32 0, i32 0
    %69 = load %struct.Temporary$vtable** %68, align 8
    %70 = getelementptr inbounds %struct.Temporary$vtable* %69, i32 0, i32 2
    %71 = load i8* (%struct.Temporary*, i8*)** %70, align 8
    %72 = call i8* %71(%struct.Temporary* %65, i8* %67)
    %73 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %72)
    %74 = alloca i1, align 4
    store i1 true, i1* %74, align 4
    %75 = load i1* %74, align 4
    ret i1 %75
}


define %struct.Person* @new$Person() nounwind ssp {
    %obj = alloca %struct.Person*, align 8
    %1 = call i8* @_mymalloc(i64 16)
    %2 = bitcast i8* %1 to %struct.Person*
    store %struct.Person* %2, %struct.Person** %obj, align 8
    %3 = load %struct.Person** %obj, align 8
    %4 = getelementptr inbounds %struct.Person* %3, i32 0, i32 0
    store %struct.Person$vtable* @Person$vtable, %struct.Person$vtable** %4, align 8
    %5 = load %struct.Person** %obj, align 8
    ret %struct.Person* %5
}

define i32 @Person$Work(%struct.Person* %this) nounwind ssp {
    
    
    %1 = alloca i32, align 4
    store i32 0, i32* %1, align 4
    %2 = load i32* %1, align 4
    ret i32 %2
}

define i8* @Person$Name(%struct.Person* %this) nounwind ssp {
    
    
    %1 = getelementptr inbounds %struct.Person* %this, i32 0, i32 1
    %2 = load i8** %1, align 8
    ret i8* %2
}

define i8* @Person$setName(%struct.Person* %this, i8* %_s) nounwind ssp {
    %s = alloca i8*, align 8
    store i8* %_s, i8** %s, align 8
    
    %1 = load i8** %s, align 8
    %2 = getelementptr inbounds %struct.Person* %this, i32 0, i32 1
    store i8* %1, i8** %2, align 8
    %3 = getelementptr inbounds %struct.Person* %this, i32 0, i32 1
    %4 = load i8** %3, align 8
    ret i8* %4
}


define %struct.Worker* @new$Worker() nounwind ssp {
    %obj = alloca %struct.Worker*, align 8
    %1 = call i8* @_mymalloc(i64 20)
    %2 = bitcast i8* %1 to %struct.Worker*
    store %struct.Worker* %2, %struct.Worker** %obj, align 8
    %3 = load %struct.Worker** %obj, align 8
    %4 = getelementptr inbounds %struct.Worker* %3, i32 0, i32 0
    store %struct.Worker$vtable* @Worker$vtable, %struct.Worker$vtable** %4, align 8
    %5 = load %struct.Worker** %obj, align 8
    ret %struct.Worker* %5
}

define i32 @Worker$Work(%struct.Worker* %this) nounwind ssp {
    
    
    %1 = getelementptr inbounds %struct.Worker* %this, i32 0, i32 2
    %2 = load i32* %1, align 4
    ret i32 %2
}

define i1 @Worker$setSalary(%struct.Worker* %this, i32 %_s) nounwind ssp {
    %s = alloca i32, align 4
    store i32 %_s, i32* %s, align 4
    
    %1 = load i32* %s, align 4
    %2 = getelementptr inbounds %struct.Worker* %this, i32 0, i32 2
    store i32 %1, i32* %2, align 4
    %3 = alloca i1, align 4
    store i1 true, i1* %3, align 4
    %4 = load i1* %3, align 4
    ret i1 %4
}


define %struct.Temporary* @new$Temporary() nounwind ssp {
    %obj = alloca %struct.Temporary*, align 8
    %1 = call i8* @_mymalloc(i64 20)
    %2 = bitcast i8* %1 to %struct.Temporary*
    store %struct.Temporary* %2, %struct.Temporary** %obj, align 8
    %3 = load %struct.Temporary** %obj, align 8
    %4 = getelementptr inbounds %struct.Temporary* %3, i32 0, i32 0
    store %struct.Temporary$vtable* @Temporary$vtable, %struct.Temporary$vtable** %4, align 8
    %5 = load %struct.Temporary** %obj, align 8
    ret %struct.Temporary* %5
}

define i32 @Temporary$Work(%struct.Temporary* %this) nounwind ssp {
    %res = alloca i32, align 4
    %1 = getelementptr inbounds %struct.Temporary* %this, i32 0, i32 2
    %2 = load i32* %1, align 4
    %3 = alloca i32, align 4
    store i32 2, i32* %3, align 4
    %4 = load i32* %3, align 4
    %5 = sdiv i32 %2, %4
    store i32 %5, i32* %res, align 4
    %6 = load i32* %res, align 4
    ret i32 %6
}

define i32 @main() nounwind ssp {
    %1 = call %struct.Run* @new$Run()
    %2 = getelementptr inbounds %struct.Run* %1, i32 0, i32 0
    %3 = load %struct.Run$vtable** %2, align 8
    %4 = getelementptr inbounds %struct.Run$vtable* %3, i32 0, i32 0
    %5 = load i1 (%struct.Run*)** %4, align 8
    %6 = call i1 %5(%struct.Run* %1)
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