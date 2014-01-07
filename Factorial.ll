; ModuleID = 'Factorial.tool'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-macosx10.7.4"

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"

%struct.Fact = type { %struct.Fact$vtable* }
%struct.Fact$vtable = type { i32 (%struct.Fact*, i32)* }
@Fact$vtable = global %struct.Fact$vtable { i32 (%struct.Fact*, i32)* @computeFactorial }, align 8

define %struct.Fact* @new$Fact() nounwind ssp {
    %obj = alloca %struct.Fact*, align 8
    %1 = call i8* @malloc(i64 8)
    %2 = bitcast i8* %1 to %struct.Fact*
    store %struct.Fact* %2, %struct.Fact** %obj, align 8
    %3 = load %struct.Fact** %obj, align 8
    %4 = getelementptr inbounds %struct.Fact* %3, i32 0, i32 0
    store %struct.Fact$vtable* @Fact$vtable, %struct.Fact$vtable** %4, align 8
    %5 = load %struct.Fact** %obj, align 8
    ret %struct.Fact* %5
}

define i32 @computeFactorial(%struct.Fact* %this, i32 %_num) nounwind ssp {
    %num = alloca i32, align 4
    store i32 %_num, i32* %num, align 4
    %num_aux = alloca i32, align 4
    %1 = load i32* %num, align 4
    %2 = alloca i32, align 4
    store i32 1, i32* %2, align 4
    %3 = load i32* %2, align 4
    %4 = icmp slt i32 %1, %3
    br i1 %4, label %5, label %8
    
; <label>: %5
    %6 = alloca i32, align 4
    store i32 1, i32* %6, align 4
    %7 = load i32* %6, align 4
    store i32 %7, i32* %num_aux, align 4
    br label %22
    
; <label>: %8
    %9 = load i32* %num, align 4
    %10 = alloca %struct.Fact*, align 8
    store %struct.Fact* %this, %struct.Fact** %10, align 8
    %11 = load %struct.Fact** %10, align 8
    %12 = load i32* %num, align 4
    %13 = alloca i32, align 4
    store i32 1, i32* %13, align 4
    %14 = load i32* %13, align 4
    %15 = sub nsw i32 %12, %14
    %16 = getelementptr inbounds %struct.Fact* %11, i32 0, i32 0
    %17 = load %struct.Fact$vtable** %16, align 8
    %18 = getelementptr inbounds %struct.Fact$vtable* %17, i32 0, i32 0
    %19 = load i32 (%struct.Fact*, i32)** %18, align 8
    %20 = call i32 %19(%struct.Fact* %11, i32 %15)
    %21 = mul nsw i32 %9, %20
    store i32 %21, i32* %num_aux, align 4
    br label %22
    
; <label>: %22
    %23 = load i32* %num_aux, align 4
    ret i32 %23
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
    ret i32 0
}

declare i32 @printf(i8*, ...)
declare i8* @malloc(i64)
