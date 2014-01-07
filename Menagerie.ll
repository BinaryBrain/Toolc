; ModuleID = 'Menagerie.tool'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-macosx10.7.4"

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@.str2 = private unnamed_addr constant [1 x i8] c"\00"
@.str3 = private unnamed_addr constant [27 x i8] c"Animal    : Animal's sound\00"
@.str4 = private unnamed_addr constant [11 x i8] c"Unknown   \00"
@.str5 = private unnamed_addr constant [11 x i8] c"Cat       \00"
@.str6 = private unnamed_addr constant [11 x i8] c"Dog       \00"
@.str7 = private unnamed_addr constant [11 x i8] c"John      \00"
@.str8 = private unnamed_addr constant [51 x i8] c": Unknown type of animal does not know how to talk\00"
@.str9 = private unnamed_addr constant [8 x i8] c": Meow!\00"
@.str10 = private unnamed_addr constant [8 x i8] c": Woof!\00"
@.str11 = private unnamed_addr constant [9 x i8] c": Hello!\00"
@.str12 = private unnamed_addr constant [3 x i8] c"Ok\00"
@.str13 = private unnamed_addr constant [6 x i8] c"Error\00"

%struct.House = type { %struct.House$vtable* }
%struct.House$vtable = type { i1 (%struct.House*)* }
@House$vtable = global %struct.House$vtable { i1 (%struct.House*)* @House$test }, align 8

define %struct.House* @new$House() nounwind ssp {
    %obj = alloca %struct.House*, align 8
    %1 = call i8* @malloc(i64 8)
    %2 = bitcast i8* %1 to %struct.House*
    store %struct.House* %2, %struct.House** %obj, align 8
    %3 = load %struct.House** %obj, align 8
    %4 = getelementptr inbounds %struct.House* %3, i32 0, i32 0
    store %struct.House$vtable* @House$vtable, %struct.House$vtable** %4, align 8
    %5 = load %struct.House** %obj, align 8
    ret %struct.House* %5
}

define i1 @House$test(%struct.House* %this) nounwind ssp {
    %dummy = alloca i1, align 4
    %animal = alloca %struct.Animal*, align 8
    %1 = alloca i8*, align 8
    store i8* getelementptr inbounds ([1 x i8]* @.str2, i32 0, i32 0), i8** %1, align 8
    %2 = load i8** %1, align 8
    %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %2)
    %4 = alloca i8*, align 8
    store i8* getelementptr inbounds ([27 x i8]* @.str3, i32 0, i32 0), i8** %4, align 8
    %5 = load i8** %4, align 8
    %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %5)
    %7 = call %struct.Animal* @new$Animal()
    %8 = alloca i8*, align 8
    store i8* getelementptr inbounds ([11 x i8]* @.str4, i32 0, i32 0), i8** %8, align 8
    %9 = load i8** %8, align 8
    %10 = getelementptr inbounds %struct.Animal* %7, i32 0, i32 0
    %11 = load %struct.Animal$vtable** %10, align 8
    %12 = getelementptr inbounds %struct.Animal$vtable* %11, i32 0, i32 0
    %13 = load %struct.toolc.analyzer.Symbols$ClassSymbol@496d864e* (%struct.Animal*, i8*)** %12, align 8
    %14 = call i32 %13(%struct.Animal* %7, i8* %9)
    %15 = getelementptr inbounds %struct.Animal* %14, i32 0, i32 0
    %16 = load %struct.Animal$vtable** %15, align 8
    %17 = getelementptr inbounds %struct.Animal$vtable* %16, i32 0, i32 0
    %18 = load i1 (%struct.Animal*)** %17, align 8
    %19 = call i32 %18(%struct.Animal* %14)
    store i1 %19, i1* %dummy, align 4
    %20 = call %struct.Cat* @new$Cat()
    %21 = alloca i8*, align 8
    store i8* getelementptr inbounds ([11 x i8]* @.str5, i32 0, i32 0), i8** %21, align 8
    %22 = load i8** %21, align 8
    %23 = getelementptr inbounds %struct.Cat* %20, i32 0, i32 0
    %24 = load %struct.Cat$vtable** %23, align 8
    %25 = getelementptr inbounds %struct.Cat$vtable* %24, i32 0, i32 0
    %26 = load %struct.toolc.analyzer.Symbols$ClassSymbol@496d864e* (%struct.Cat*, i8*)** %25, align 8
    %27 = call i32 %26(%struct.Cat* %20, i8* %22)
    %28 = getelementptr inbounds %struct.Animal* %27, i32 0, i32 0
    %29 = load %struct.Animal$vtable** %28, align 8
    %30 = getelementptr inbounds %struct.Animal$vtable* %29, i32 0, i32 0
    %31 = load i1 (%struct.Animal*)** %30, align 8
    %32 = call i32 %31(%struct.Animal* %27)
    store i1 %32, i1* %dummy, align 4
    %33 = call %struct.Dog* @new$Dog()
    %34 = alloca i8*, align 8
    store i8* getelementptr inbounds ([11 x i8]* @.str6, i32 0, i32 0), i8** %34, align 8
    %35 = load i8** %34, align 8
    %36 = getelementptr inbounds %struct.Dog* %33, i32 0, i32 0
    %37 = load %struct.Dog$vtable** %36, align 8
    %38 = getelementptr inbounds %struct.Dog$vtable* %37, i32 0, i32 0
    %39 = load %struct.toolc.analyzer.Symbols$ClassSymbol@496d864e* (%struct.Dog*, i8*)** %38, align 8
    %40 = call i32 %39(%struct.Dog* %33, i8* %35)
    %41 = getelementptr inbounds %struct.Animal* %40, i32 0, i32 0
    %42 = load %struct.Animal$vtable** %41, align 8
    %43 = getelementptr inbounds %struct.Animal$vtable* %42, i32 0, i32 0
    %44 = load i1 (%struct.Animal*)** %43, align 8
    %45 = call i32 %44(%struct.Animal* %40)
    store i1 %45, i1* %dummy, align 4
    %46 = call %struct.Human* @new$Human()
    %47 = alloca i8*, align 8
    store i8* getelementptr inbounds ([11 x i8]* @.str7, i32 0, i32 0), i8** %47, align 8
    %48 = load i8** %47, align 8
    %49 = getelementptr inbounds %struct.Human* %46, i32 0, i32 0
    %50 = load %struct.Human$vtable** %49, align 8
    %51 = getelementptr inbounds %struct.Human$vtable* %50, i32 0, i32 0
    %52 = load %struct.toolc.analyzer.Symbols$ClassSymbol@496d864e* (%struct.Human*, i8*)** %51, align 8
    %53 = call i32 %52(%struct.Human* %46, i8* %48)
    store %struct.toolc.analyzer.Symbols$ClassSymbol@496d864e* %53, %struct.toolc.analyzer.Symbols$ClassSymbol@496d864e** %animal, align 8
    %54 = load %struct.toolc.analyzer.Symbols$ClassSymbol@496d864e** %animal, align 8
    %55 = getelementptr inbounds %struct.Animal* %54, i32 0, i32 0
    %56 = load %struct.Animal$vtable** %55, align 8
    %57 = getelementptr inbounds %struct.Animal$vtable* %56, i32 0, i32 0
    %58 = load i1 (%struct.Animal*)** %57, align 8
    %59 = call i32 %58(%struct.Animal* %54)
    store i1 %59, i1* %dummy, align 4
    %60 = alloca i1, align 4
    store i1 true, i1* %60, align 4
    %61 = load i1* %60, align 4
    ret i1 %61
}


%struct.Animal = type { %struct.Animal$vtable* }
%struct.Animal$vtable = type { %struct.Animal* (%struct.Animal*, i8*)* , i1 (%struct.Animal*)* , i8* (%struct.Animal*)* }
@Animal$vtable = global %struct.Animal$vtable { %struct.Animal* (%struct.Animal*, i8*)* @Animal$withName , i1 (%struct.Animal*)* @Animal$talk , i8* (%struct.Animal*)* @Animal$getName }, align 8

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

define %struct.Animal* @Animal$withName(%struct.Animal* %this, i8* %_s) nounwind ssp {
    %s = alloca i8*, align 8
    store i8* %_s, i8** %s, align 8
    
    %1 = load i8** %s, align 8
    store i8* %1, i8** %name, align 8
    %2 = alloca %struct.Animal*, align 8
    store %struct.Animal* %this, %struct.Animal** %2, align 8
    %3 = load %struct.Animal** %2, align 8
    ret %struct.Animal* %3
}

define i1 @Animal$talk(%struct.Animal* %this) nounwind ssp {
    
    %1 = load i8** %name, align 8
    %2 = alloca i8*, align 8
    store i8* getelementptr inbounds ([51 x i8]* @.str8, i32 0, i32 0), i8** %2, align 8
    %3 = load i8** %2, align 8
    %4 = add nsw i32 %1, %3
    %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %4)
    %6 = alloca i1, align 4
    store i1 true, i1* %6, align 4
    %7 = load i1* %6, align 4
    ret i1 %7
}

define i8* @Animal$getName(%struct.Animal* %this) nounwind ssp {
    
    
    %1 = load i8** %name, align 8
    ret i8* %1
}


%struct.Cat = type { %struct.Cat$vtable* }
%struct.Cat$vtable = type { i1 (%struct.Cat*)* }
@Cat$vtable = global %struct.Cat$vtable { i1 (%struct.Cat*)* @Cat$talk }, align 8

define %struct.Cat* @new$Cat() nounwind ssp {
    %obj = alloca %struct.Cat*, align 8
    %1 = call i8* @malloc(i64 8)
    %2 = bitcast i8* %1 to %struct.Cat*
    store %struct.Cat* %2, %struct.Cat** %obj, align 8
    %3 = load %struct.Cat** %obj, align 8
    %4 = getelementptr inbounds %struct.Cat* %3, i32 0, i32 0
    store %struct.Cat$vtable* @Cat$vtable, %struct.Cat$vtable** %4, align 8
    %5 = load %struct.Cat** %obj, align 8
    ret %struct.Cat* %5
}

define i1 @Cat$talk(%struct.Cat* %this) nounwind ssp {
    
    %1 = alloca %struct.Cat*, align 8
    store %struct.Cat* %this, %struct.Cat** %1, align 8
    %2 = load %struct.Cat** %1, align 8
    %3 = getelementptr inbounds %struct.Cat* %2, i32 0, i32 0
    %4 = load %struct.Cat$vtable** %3, align 8
    %5 = getelementptr inbounds %struct.Cat$vtable* %4, i32 0, i32 0
    %6 = load i8* (%struct.Cat*)** %5, align 8
    %7 = call i32 %6(%struct.Cat* %2)
    %8 = alloca i8*, align 8
    store i8* getelementptr inbounds ([8 x i8]* @.str9, i32 0, i32 0), i8** %8, align 8
    %9 = load i8** %8, align 8
    %10 = add nsw i32 %7, %9
    %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %10)
    %12 = alloca i1, align 4
    store i1 true, i1* %12, align 4
    %13 = load i1* %12, align 4
    ret i1 %13
}


%struct.Dog = type { %struct.Dog$vtable* }
%struct.Dog$vtable = type { i1 (%struct.Dog*)* }
@Dog$vtable = global %struct.Dog$vtable { i1 (%struct.Dog*)* @Dog$talk }, align 8

define %struct.Dog* @new$Dog() nounwind ssp {
    %obj = alloca %struct.Dog*, align 8
    %1 = call i8* @malloc(i64 8)
    %2 = bitcast i8* %1 to %struct.Dog*
    store %struct.Dog* %2, %struct.Dog** %obj, align 8
    %3 = load %struct.Dog** %obj, align 8
    %4 = getelementptr inbounds %struct.Dog* %3, i32 0, i32 0
    store %struct.Dog$vtable* @Dog$vtable, %struct.Dog$vtable** %4, align 8
    %5 = load %struct.Dog** %obj, align 8
    ret %struct.Dog* %5
}

define i1 @Dog$talk(%struct.Dog* %this) nounwind ssp {
    
    %1 = alloca %struct.Dog*, align 8
    store %struct.Dog* %this, %struct.Dog** %1, align 8
    %2 = load %struct.Dog** %1, align 8
    %3 = getelementptr inbounds %struct.Dog* %2, i32 0, i32 0
    %4 = load %struct.Dog$vtable** %3, align 8
    %5 = getelementptr inbounds %struct.Dog$vtable* %4, i32 0, i32 0
    %6 = load i8* (%struct.Dog*)** %5, align 8
    %7 = call i32 %6(%struct.Dog* %2)
    %8 = alloca i8*, align 8
    store i8* getelementptr inbounds ([8 x i8]* @.str10, i32 0, i32 0), i8** %8, align 8
    %9 = load i8** %8, align 8
    %10 = add nsw i32 %7, %9
    %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %10)
    %12 = alloca i1, align 4
    store i1 true, i1* %12, align 4
    %13 = load i1* %12, align 4
    ret i1 %13
}


%struct.Human = type { %struct.Human$vtable* }
%struct.Human$vtable = type { i1 (%struct.Human*)* }
@Human$vtable = global %struct.Human$vtable { i1 (%struct.Human*)* @Human$talk }, align 8

define %struct.Human* @new$Human() nounwind ssp {
    %obj = alloca %struct.Human*, align 8
    %1 = call i8* @malloc(i64 8)
    %2 = bitcast i8* %1 to %struct.Human*
    store %struct.Human* %2, %struct.Human** %obj, align 8
    %3 = load %struct.Human** %obj, align 8
    %4 = getelementptr inbounds %struct.Human* %3, i32 0, i32 0
    store %struct.Human$vtable* @Human$vtable, %struct.Human$vtable** %4, align 8
    %5 = load %struct.Human** %obj, align 8
    ret %struct.Human* %5
}

define i1 @Human$talk(%struct.Human* %this) nounwind ssp {
    
    %1 = alloca %struct.Human*, align 8
    store %struct.Human* %this, %struct.Human** %1, align 8
    %2 = load %struct.Human** %1, align 8
    %3 = getelementptr inbounds %struct.Human* %2, i32 0, i32 0
    %4 = load %struct.Human$vtable** %3, align 8
    %5 = getelementptr inbounds %struct.Human$vtable* %4, i32 0, i32 0
    %6 = load i8* (%struct.Human*)** %5, align 8
    %7 = call i32 %6(%struct.Human* %2)
    %8 = alloca i8*, align 8
    store i8* getelementptr inbounds ([9 x i8]* @.str11, i32 0, i32 0), i8** %8, align 8
    %9 = load i8** %8, align 8
    %10 = add nsw i32 %7, %9
    %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %10)
    %12 = alloca i1, align 4
    store i1 true, i1* %12, align 4
    %13 = load i1* %12, align 4
    ret i1 %13
}

define i32 @main() nounwind ssp {
    %1 = call %struct.House* @new$House()
    %2 = getelementptr inbounds %struct.House* %1, i32 0, i32 0
    %3 = load %struct.House$vtable** %2, align 8
    %4 = getelementptr inbounds %struct.House$vtable* %3, i32 0, i32 0
    %5 = load i1 (%struct.House*)** %4, align 8
    %6 = call i32 %5(%struct.House* %1)
    br i1 %6, label %7, label %11
    
; <label>: %7
    %8 = alloca i8*, align 8
    store i8* getelementptr inbounds ([3 x i8]* @.str12, i32 0, i32 0), i8** %8, align 8
    %9 = load i8** %8, align 8
    %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %9)
    br label %15
    
; <label>: %11
    %12 = alloca i8*, align 8
    store i8* getelementptr inbounds ([6 x i8]* @.str13, i32 0, i32 0), i8** %12, align 8
    %13 = load i8** %12, align 8
    %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %13)
    br label %15
    
; <label>: %15
    ret i32 0
}

declare i32 @printf(i8*, ...)
declare i8* @malloc(i64)
