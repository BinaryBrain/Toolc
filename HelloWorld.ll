; ModuleID = 'HelloWorld.tool'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-macosx10.7.4"

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"

%struct.Animal = type { %struct.Animal$vtable* }
%struct.Animal$vtable = type { i32 (%struct.Animal*, i32)* }
@Animal$vtable = global %struct.Animal$vtable { i32 (%struct.Animal*, i32)* @say }, align 8

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

define i32 @say(%struct.Animal* %this, i32 %_a) nounwind ssp {
    %a = alloca i32, align 4
    store i32 %_a, i32* %a, align 4
    
    
    %1 = load i32* %a, align 4
    ret i32 %1
}

define i32 @main() nounwind ssp {
    %1 = call %struct.Animal* @new$Animal()
    %2 = alloca i32, align 4
    store i32 3, i32* %2, align 4
    %3 = load i32* %2, align 4
    %4 = getelementptr inbounds %struct.Animal* %1, i32 0, i32 0
    %5 = load %struct.Animal$vtable** %4, align 8
    %6 = getelementptr inbounds %struct.Animal$vtable* %5, i32 0, i32 0
    %7 = load i32 (%struct.Animal*, i32)** %6, align 8
    %8 = call i32 %7(%struct.Animal* %1, i32 %3)
    %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %8)
    ret i32 0
}

declare i32 @printf(i8*, ...)
declare i8* @malloc(i64)
