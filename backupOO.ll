; ModuleID = 'OO.tool'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-macosx10.7.4"

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@.str2 = private unnamed_addr constant [7 x i8] c"Hello!\00"
@.str3 = private unnamed_addr constant [5 x i8] c"Bye!\00"
@.str4 = private unnamed_addr constant [6 x i8] c"Minou\00"
@.str5 = private unnamed_addr constant [6 x i8] c"Minet\00"

%struct.Animal = type { %struct.Animal$vtable*, i8*, i32 }
%struct.Animal$vtable = type { %struct.Animal* (%struct.Animal*, i8*, i32)* , i8* (%struct.Animal*)* , i8* (%struct.Animal*)* , i8* (%struct.Animal*, i8*)* , i32 (%struct.Animal*)* }
@Animal$vtable = global %struct.Animal$vtable { %struct.Animal* (%struct.Animal*, i8*, i32)* @Animal$init , i8* (%struct.Animal*)* @Animal$sayYourName , i8* (%struct.Animal*)* @Animal$sayHello , i8* (%struct.Animal*, i8*)* @Animal$say , i32 (%struct.Animal*)* @Animal$sayYourAge }, align 8

define %struct.Animal* @new$Animal() nounwind ssp {
    %obj = alloca %struct.Animal*, align 8
    %1 = call i8* @malloc(i64 20)
    %2 = bitcast i8* %1 to %struct.Animal*
    store %struct.Animal* %2, %struct.Animal** %obj, align 8
    %3 = load %struct.Animal** %obj, align 8
    %4 = getelementptr inbounds %struct.Animal* %3, i32 0, i32 0
    store %struct.Animal$vtable* @Animal$vtable, %struct.Animal$vtable** %4, align 8
    %5 = load %struct.Animal** %obj, align 8
    ret %struct.Animal* %5
}

define %struct.Animal* @Animal$init(%struct.Animal* %this, i8* %_n, i32 %_a) nounwind ssp {
    %n = alloca i8*, align 8
    store i8* %_n, i8** %n, align 8
    %a = alloca i32, align 4
    store i32 %_a, i32* %a, align 4
    
    %1 = load i8** %n, align 8
    %2 = getelementptr inbounds %struct.Animal* %this, i32 0, i32 1
    store i8* %1, i8** %2, align 8
    %3 = load i32* %a, align 4
    %4 = getelementptr inbounds %struct.Animal* %this, i32 0, i32 2
    store i32 %3, i32* %4, align 4
    %5 = alloca %struct.Animal*, align 8
    store %struct.Animal* %this, %struct.Animal** %5, align 8
    %6 = load %struct.Animal** %5, align 8
    ret %struct.Animal* %6
}

define i8* @Animal$sayYourName(%struct.Animal* %this) nounwind ssp {
    
    
    %1 = getelementptr inbounds %struct.Animal* %this, i32 0, i32 1
    %2 = load i8** %1, align 8
    ret i8* %2
}

define i8* @Animal$sayHello(%struct.Animal* %this) nounwind ssp {
    
    
    %1 = alloca i8*, align 8
    store i8* getelementptr inbounds ([7 x i8]* @.str2, i32 0, i32 0), i8** %1, align 8
    %2 = load i8** %1, align 8
    ret i8* %2
}

define i8* @Animal$say(%struct.Animal* %this, i8* %_thing) nounwind ssp {
    %thing = alloca i8*, align 8
    store i8* %_thing, i8** %thing, align 8
    
    
    %1 = load i8** %thing, align 8
    ret i8* %1
}

define i32 @Animal$sayYourAge(%struct.Animal* %this) nounwind ssp {
    
    
    %1 = getelementptr inbounds %struct.Animal* %this, i32 0, i32 2
    %2 = load i32* %1, align 4
    ret i32 %2
}

define i32 @main() nounwind ssp {
    %1 = call %struct.Animal* @new$Animal()
    %2 = getelementptr inbounds %struct.Animal* %1, i32 0, i32 0
    %3 = load %struct.Animal$vtable** %2, align 8
    %4 = getelementptr inbounds %struct.Animal$vtable* %3, i32 0, i32 2
    %5 = load i8* (%struct.Animal*)** %4, align 8
    %6 = call i8* %5(%struct.Animal* %1)
    %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %6)
    %8 = call %struct.Animal* @new$Animal()
    %9 = alloca i8*, align 8
    store i8* getelementptr inbounds ([5 x i8]* @.str3, i32 0, i32 0), i8** %9, align 8
    %10 = load i8** %9, align 8
    %11 = getelementptr inbounds %struct.Animal* %8, i32 0, i32 0
    %12 = load %struct.Animal$vtable** %11, align 8
    %13 = getelementptr inbounds %struct.Animal$vtable* %12, i32 0, i32 3
    %14 = load i8* (%struct.Animal*, i8*)** %13, align 8
    %15 = call i8* %14(%struct.Animal* %8, i8* %10)
    %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %15)
    %17 = call %struct.Animal* @new$Animal()
    %18 = alloca i8*, align 8
    store i8* getelementptr inbounds ([6 x i8]* @.str4, i32 0, i32 0), i8** %18, align 8
    %19 = load i8** %18, align 8
    %20 = alloca i32, align 4
    store i32 13, i32* %20, align 4
    %21 = load i32* %20, align 4
    %22 = getelementptr inbounds %struct.Animal* %17, i32 0, i32 0
    %23 = load %struct.Animal$vtable** %22, align 8
    %24 = getelementptr inbounds %struct.Animal$vtable* %23, i32 0, i32 0
    %25 = load %struct.Animal* (%struct.Animal*, i8*, i32)** %24, align 8
    %26 = call %struct.Animal* %25(%struct.Animal* %17, i8* %19, i32 %21)
    %27 = getelementptr inbounds %struct.Animal* %26, i32 0, i32 0
    %28 = load %struct.Animal$vtable** %27, align 8
    %29 = getelementptr inbounds %struct.Animal$vtable* %28, i32 0, i32 1
    %30 = load i8* (%struct.Animal*)** %29, align 8
    %31 = call i8* %30(%struct.Animal* %26)
    %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %31)
    %33 = call %struct.Animal* @new$Animal()
    %34 = alloca i8*, align 8
    store i8* getelementptr inbounds ([6 x i8]* @.str5, i32 0, i32 0), i8** %34, align 8
    %35 = load i8** %34, align 8
    %36 = alloca i32, align 4
    store i32 7, i32* %36, align 4
    %37 = load i32* %36, align 4
    %38 = getelementptr inbounds %struct.Animal* %33, i32 0, i32 0
    %39 = load %struct.Animal$vtable** %38, align 8
    %40 = getelementptr inbounds %struct.Animal$vtable* %39, i32 0, i32 0
    %41 = load %struct.Animal* (%struct.Animal*, i8*, i32)** %40, align 8
    %42 = call %struct.Animal* %41(%struct.Animal* %33, i8* %35, i32 %37)
    %43 = getelementptr inbounds %struct.Animal* %42, i32 0, i32 0
    %44 = load %struct.Animal$vtable** %43, align 8
    %45 = getelementptr inbounds %struct.Animal$vtable* %44, i32 0, i32 4
    %46 = load i32 (%struct.Animal*)** %45, align 8
    %47 = call i32 %46(%struct.Animal* %42)
    %48 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %47)
    ret i32 0
}

declare i32 @printf(i8*, ...)
declare i8* @malloc(i64)
