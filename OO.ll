; ModuleID = 'OO.tool'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-macosx10.7.4"

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@.str2 = private unnamed_addr constant [2 x i8] c"0\00"
@.str3 = private unnamed_addr constant [7 x i8] c"Hello!\00"
@.str4 = private unnamed_addr constant [5 x i8] c"Bye!\00"
@.str5 = private unnamed_addr constant [10 x i8] c"Your Name\00"

%struct.Animal = type { %struct.Animal$vtable* }
%struct.Animal$vtable = type { i8* (%struct.Animal*)* , i8* (%struct.Animal*)* , i8* (%struct.Animal*, i8*)* }
@Animal$vtable = global %struct.Animal$vtable { i8* (%struct.Animal*)* @Animal$sayYourName , i8* (%struct.Animal*)* @Animal$sayHello , i8* (%struct.Animal*, i8*)* @Animal$say }, align 8

define %struct.Animal* @new$Animal() nounwind ssp {
    %obj = alloca %struct.Animal*, align 8
    %1 = call i8* @malloc(i64 8)
    %2 = bitcast i8* %1 to %struct.Animal*
    store %struct.Animal* %2, %struct.Animal** %obj, align 8
    %3 = load %struct.Animal** %obj, align 8
    %4 = getelementptr inbounds %struct.Animal* %3, i32 0, i32 0
    store %struct.Animal$vtable* @Animal$vtable, %struct.Animal$vtable** %4, align 8
    %5 = load %struct.Animal** %obj, align 8
    ret %struct.Animal* %5
}

define i8* @Animal$sayYourName(%struct.Animal* %this) nounwind ssp {
    
    
    %1 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str2, i32 0, i32 0), i8** %1, align 8
    %2 = load i8** %1, align 8
    ret i8* %2
}

define i8* @Animal$sayHello(%struct.Animal* %this) nounwind ssp {
    
    
    %1 = alloca i8*, align 8
    store i8* getelementptr inbounds ([7 x i8]* @.str3, i32 0, i32 0), i8** %1, align 8
    %2 = load i8** %1, align 8
    ret i8* %2
}

define i8* @Animal$say(%struct.Animal* %this, i8* %_thing) nounwind ssp {
    %thing = alloca i8*, align 8
    store i8* %_thing, i8** %thing, align 8
    
    
    %1 = load i8** %thing, align 8
    ret i8* %1
}

define i32 @main() nounwind ssp {
    %1 = call %struct.Animal* @new$Animal()
    %2 = getelementptr inbounds %struct.Animal* %1, i32 0, i32 0
    %3 = load %struct.Animal$vtable** %2, align 8
    %4 = getelementptr inbounds %struct.Animal$vtable* %3, i32 0, i32 0
    %5 = load i8* (%struct.Animal*)** %4, align 8
    %6 = call i8* %5(%struct.Animal* %1)
    %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %6)
    %8 = call %struct.Animal* @new$Animal()
    %9 = alloca i8*, align 8
    store i8* getelementptr inbounds ([5 x i8]* @.str4, i32 0, i32 0), i8** %9, align 8
    %10 = load i8** %9, align 8
    %11 = getelementptr inbounds %struct.Animal* %8, i32 0, i32 0
    %12 = load %struct.Animal$vtable** %11, align 8
    %13 = getelementptr inbounds %struct.Animal$vtable* %12, i32 0, i32 0
    %14 = load i8* (%struct.Animal*, i8*)** %13, align 8
    %15 = call i8* %14(%struct.Animal* %8, i8* %10)
    %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %15)
    %17 = call %struct.Animal* @new$Animal()
    %18 = alloca i8*, align 8
    store i8* getelementptr inbounds ([10 x i8]* @.str5, i32 0, i32 0), i8** %18, align 8
    %19 = load i8** %18, align 8
    %20 = getelementptr inbounds %struct.Animal* %17, i32 0, i32 0
    %21 = load %struct.Animal$vtable** %20, align 8
    %22 = getelementptr inbounds %struct.Animal$vtable* %21, i32 0, i32 0
    %23 = load i8* (%struct.Animal*, i8*)** %22, align 8
    %24 = call i8* %23(%struct.Animal* %17, i8* %19)
    %25 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %24)
    ret i32 0
}

declare i32 @printf(i8*, ...)
declare i8* @malloc(i64)
