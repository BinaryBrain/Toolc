; ModuleID = 'Maze.tool'
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
@.str5 = private unnamed_addr constant [2 x i8] c"|\00"
@.str6 = private unnamed_addr constant [2 x i8] c"-\00"
@.str7 = private unnamed_addr constant [2 x i8] c"+\00"
@.str8 = private unnamed_addr constant [2 x i8] c"+\00"
@.str9 = private unnamed_addr constant [2 x i8] c"+\00"
@.str10 = private unnamed_addr constant [2 x i8] c"+\00"
@.str11 = private unnamed_addr constant [2 x i8] c"+\00"
@.str12 = private unnamed_addr constant [2 x i8] c"+\00"
@.str13 = private unnamed_addr constant [2 x i8] c"+\00"
@.str14 = private unnamed_addr constant [2 x i8] c"+\00"
@.str15 = private unnamed_addr constant [2 x i8] c"+\00"
@.str16 = private unnamed_addr constant [2 x i8] c"+\00"
@.str17 = private unnamed_addr constant [2 x i8] c"+\00"
@.str18 = private unnamed_addr constant [2 x i8] c"+\00"
@.str19 = private unnamed_addr constant [2 x i8] c"+\00"
@.str20 = private unnamed_addr constant [2 x i8] c"=\00"
@.str21 = private unnamed_addr constant [2 x i8] c">\00"
@.str22 = private unnamed_addr constant [1 x i8] c"\00"
@.str23 = private unnamed_addr constant [1 x i8] c"\00"
@.str24 = private unnamed_addr constant [4 x i8] c"   \00"
@.str25 = private unnamed_addr constant [1 x i8] c"\00"
@.str26 = private unnamed_addr constant [1 x i8] c"\00"
@.str27 = private unnamed_addr constant [2 x i8] c" \00"
@.str28 = private unnamed_addr constant [3 x i8] c"  \00"
@.str29 = private unnamed_addr constant [4 x i8] c"   \00"
@.str30 = private unnamed_addr constant [4 x i8] c"   \00"
@.str31 = private unnamed_addr constant [2 x i8] c" \00"
@.str32 = private unnamed_addr constant [4 x i8] c"   \00"
@.str33 = private unnamed_addr constant [3 x i8] c"  \00"
@.str34 = private unnamed_addr constant [4 x i8] c"   \00"
@.str35 = private unnamed_addr constant [4 x i8] c"   \00"
@.str36 = private unnamed_addr constant [4 x i8] c"   \00"
@.str37 = private unnamed_addr constant [15 x i8] c" ** Enjoy ! **\00"

%struct.MazeArray = type <{ %struct.MazeArray$vtable*, i32, %struct.PseudoRandomNumberGenerator*, %struct.$IntArray*, i32, i32, %struct.$IntArray*, %struct.$IntArray*, i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8* }>
%struct.MazeArray$vtable = type { %struct.MazeArray* (%struct.MazeArray*, i32)* , i32 (%struct.MazeArray*, i32)* , i1 (%struct.MazeArray*, i32, i32)* , i1 (%struct.MazeArray*)* , i32 (%struct.MazeArray*, i32, i32)* , i32 (%struct.MazeArray*, i32)* , i32 (%struct.MazeArray*, i32)* , i32 (%struct.MazeArray*, i1, i32, i32)* , i32 (%struct.MazeArray*, i32)* , i32 (%struct.MazeArray*, i32)* , i32 (%struct.MazeArray*, i32)* , i32 (%struct.MazeArray*, i32)* , i1 (%struct.MazeArray*, i32)* , i8* (%struct.MazeArray*)* , %struct.$IntArray* (%struct.MazeArray*, %struct.$IntArray*)* }
@MazeArray$vtable = global %struct.MazeArray$vtable { %struct.MazeArray* (%struct.MazeArray*, i32)* @MazeArray$init , i32 (%struct.MazeArray*, i32)* @MazeArray$cellRepresentative , i1 (%struct.MazeArray*, i32, i32)* @MazeArray$setRepresentative , i1 (%struct.MazeArray*)* @MazeArray$allMerged , i32 (%struct.MazeArray*, i32, i32)* @MazeArray$cellID , i32 (%struct.MazeArray*, i32)* @MazeArray$cellRow , i32 (%struct.MazeArray*, i32)* @MazeArray$cellCol , i32 (%struct.MazeArray*, i1, i32, i32)* @MazeArray$wallID , i32 (%struct.MazeArray*, i32)* @MazeArray$wallRow , i32 (%struct.MazeArray*, i32)* @MazeArray$wallCol , i32 (%struct.MazeArray*, i32)* @MazeArray$cellOneOfWall , i32 (%struct.MazeArray*, i32)* @MazeArray$cellTwoOfWall , i1 (%struct.MazeArray*, i32)* @MazeArray$destroyIfNotConnected , i8* (%struct.MazeArray*)* @MazeArray$printMaze , %struct.$IntArray* (%struct.MazeArray*, %struct.$IntArray*)* @MazeArray$shuffleArray }, align 8


%struct.PseudoRandomNumberGenerator = type <{ %struct.PseudoRandomNumberGenerator$vtable*, i32, i32 }>
%struct.PseudoRandomNumberGenerator$vtable = type { %struct.PseudoRandomNumberGenerator* (%struct.PseudoRandomNumberGenerator*)* , i32 (%struct.PseudoRandomNumberGenerator*, i32, i32)* , i32 (%struct.PseudoRandomNumberGenerator*, i32, i32)* , i32 (%struct.PseudoRandomNumberGenerator*)* }
@PseudoRandomNumberGenerator$vtable = global %struct.PseudoRandomNumberGenerator$vtable { %struct.PseudoRandomNumberGenerator* (%struct.PseudoRandomNumberGenerator*)* @PseudoRandomNumberGenerator$init , i32 (%struct.PseudoRandomNumberGenerator*, i32, i32)* @PseudoRandomNumberGenerator$getInt , i32 (%struct.PseudoRandomNumberGenerator*, i32, i32)* @PseudoRandomNumberGenerator$mod , i32 (%struct.PseudoRandomNumberGenerator*)* @PseudoRandomNumberGenerator$nextInt }, align 8

define %struct.MazeArray* @new$MazeArray() nounwind ssp {
    %obj = alloca %struct.MazeArray*, align 8
    %1 = call i8* @_mymalloc(i64 192)
    %2 = bitcast i8* %1 to %struct.MazeArray*
    store %struct.MazeArray* %2, %struct.MazeArray** %obj, align 8
    %3 = load %struct.MazeArray** %obj, align 8
    %4 = getelementptr inbounds %struct.MazeArray* %3, i32 0, i32 0
    store %struct.MazeArray$vtable* @MazeArray$vtable, %struct.MazeArray$vtable** %4, align 8
    %5 = load %struct.MazeArray** %obj, align 8
    ret %struct.MazeArray* %5
}

define %struct.MazeArray* @MazeArray$init(%struct.MazeArray* %this, i32 %_sze) nounwind ssp {
    %sze = alloca i32, align 4
    store i32 %_sze, i32* %sze, align 4
    %i = alloca i32, align 4
    %dummy = alloca i1, align 4
    %1 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str5, i32 0, i32 0), i8** %1, align 8
    %2 = load i8** %1, align 8
    %3 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 9
    store i8* %2, i8** %3, align 8
    %4 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str6, i32 0, i32 0), i8** %4, align 8
    %5 = load i8** %4, align 8
    %6 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    store i8* %5, i8** %6, align 8
    %7 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str7, i32 0, i32 0), i8** %7, align 8
    %8 = load i8** %7, align 8
    %9 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 11
    store i8* %8, i8** %9, align 8
    %10 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str8, i32 0, i32 0), i8** %10, align 8
    %11 = load i8** %10, align 8
    %12 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 12
    store i8* %11, i8** %12, align 8
    %13 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str9, i32 0, i32 0), i8** %13, align 8
    %14 = load i8** %13, align 8
    %15 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 13
    store i8* %14, i8** %15, align 8
    %16 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str10, i32 0, i32 0), i8** %16, align 8
    %17 = load i8** %16, align 8
    %18 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 14
    store i8* %17, i8** %18, align 8
    %19 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str11, i32 0, i32 0), i8** %19, align 8
    %20 = load i8** %19, align 8
    %21 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 15
    store i8* %20, i8** %21, align 8
    %22 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str12, i32 0, i32 0), i8** %22, align 8
    %23 = load i8** %22, align 8
    %24 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 16
    store i8* %23, i8** %24, align 8
    %25 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str13, i32 0, i32 0), i8** %25, align 8
    %26 = load i8** %25, align 8
    %27 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 17
    store i8* %26, i8** %27, align 8
    %28 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str14, i32 0, i32 0), i8** %28, align 8
    %29 = load i8** %28, align 8
    %30 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 18
    store i8* %29, i8** %30, align 8
    %31 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str15, i32 0, i32 0), i8** %31, align 8
    %32 = load i8** %31, align 8
    %33 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 19
    store i8* %32, i8** %33, align 8
    %34 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str16, i32 0, i32 0), i8** %34, align 8
    %35 = load i8** %34, align 8
    %36 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 20
    store i8* %35, i8** %36, align 8
    %37 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str17, i32 0, i32 0), i8** %37, align 8
    %38 = load i8** %37, align 8
    %39 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 21
    store i8* %38, i8** %39, align 8
    %40 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str18, i32 0, i32 0), i8** %40, align 8
    %41 = load i8** %40, align 8
    %42 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 22
    store i8* %41, i8** %42, align 8
    %43 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str19, i32 0, i32 0), i8** %43, align 8
    %44 = load i8** %43, align 8
    %45 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 23
    store i8* %44, i8** %45, align 8
    %46 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str20, i32 0, i32 0), i8** %46, align 8
    %47 = load i8** %46, align 8
    %48 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 24
    store i8* %47, i8** %48, align 8
    %49 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str21, i32 0, i32 0), i8** %49, align 8
    %50 = load i8** %49, align 8
    %51 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 25
    store i8* %50, i8** %51, align 8
    %52 = load i32* %sze, align 4
    %53 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    store i32 %52, i32* %53, align 4
    %54 = call %struct.PseudoRandomNumberGenerator* @new$PseudoRandomNumberGenerator()
    %55 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %54, i32 0, i32 0
    %56 = load %struct.PseudoRandomNumberGenerator$vtable** %55, align 8
    %57 = getelementptr inbounds %struct.PseudoRandomNumberGenerator$vtable* %56, i32 0, i32 0
    %58 = load %struct.PseudoRandomNumberGenerator* (%struct.PseudoRandomNumberGenerator*)** %57, align 8
    %59 = call %struct.PseudoRandomNumberGenerator* %58(%struct.PseudoRandomNumberGenerator* %54)
    %60 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 2
    store %struct.PseudoRandomNumberGenerator* %59, %struct.PseudoRandomNumberGenerator** %60, align 8
    %61 = alloca i32, align 4
    store i32 2, i32* %61, align 4
    %62 = load i32* %61, align 4
    %63 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %64 = load i32* %63, align 4
    %65 = mul nsw i32 %62, %64
    %66 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %67 = load i32* %66, align 4
    %68 = alloca i32, align 4
    store i32 1, i32* %68, align 4
    %69 = load i32* %68, align 4
    %70 = sub nsw i32 %67, %69
    %71 = mul nsw i32 %65, %70
    %72 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 4
    store i32 %71, i32* %72, align 4
    %73 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 4
    %74 = load i32* %73, align 4
    %75 = call %struct.$IntArray* @$new_$IntArray(i32 %74)
    %76 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    store %struct.$IntArray* %75, %struct.$IntArray** %76, align 8
    %77 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 4
    %78 = load i32* %77, align 4
    %79 = alloca i32, align 4
    store i32 2, i32* %79, align 4
    %80 = load i32* %79, align 4
    %81 = sdiv i32 %78, %80
    %82 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 5
    store i32 %81, i32* %82, align 4
    %83 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 4
    %84 = load i32* %83, align 4
    %85 = call %struct.$IntArray* @$new_$IntArray(i32 %84)
    %86 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 6
    store %struct.$IntArray* %85, %struct.$IntArray** %86, align 8
    %87 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %88 = load i32* %87, align 4
    %89 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %90 = load i32* %89, align 4
    %91 = mul nsw i32 %88, %90
    %92 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 8
    store i32 %91, i32* %92, align 4
    %93 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 8
    %94 = load i32* %93, align 4
    %95 = call %struct.$IntArray* @$new_$IntArray(i32 %94)
    %96 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 7
    store %struct.$IntArray* %95, %struct.$IntArray** %96, align 8
    %97 = alloca i32, align 4
    store i32 0, i32* %97, align 4
    %98 = load i32* %97, align 4
    store i32 %98, i32* %i, align 4
    br label %99
    
; <label>: %99
    %100 = load i32* %i, align 4
    %101 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 4
    %102 = load i32* %101, align 4
    %103 = icmp slt i32 %100, %102
    br i1 %103, label %104, label %120
    
; <label>: %104
    %105 = load i32* %i, align 4
    %106 = alloca i32, align 4
    store i32 1, i32* %106, align 4
    %107 = load i32* %106, align 4
    %108 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %109 = load %struct.$IntArray** %108, align 8
    %110 = call %struct.$IntArray* @$IntArray_Assign(%struct.$IntArray* %109, i32 %105, i32 %107)
    %111 = load i32* %i, align 4
    %112 = load i32* %i, align 4
    %113 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 6
    %114 = load %struct.$IntArray** %113, align 8
    %115 = call %struct.$IntArray* @$IntArray_Assign(%struct.$IntArray* %114, i32 %111, i32 %112)
    %116 = load i32* %i, align 4
    %117 = alloca i32, align 4
    store i32 1, i32* %117, align 4
    %118 = load i32* %117, align 4
    %119 = add nsw i32 %116, %118
    store i32 %119, i32* %i, align 4
    br label %99
    
; <label>: %120
    %121 = alloca i32, align 4
    store i32 0, i32* %121, align 4
    %122 = load i32* %121, align 4
    store i32 %122, i32* %i, align 4
    br label %123
    
; <label>: %123
    %124 = load i32* %i, align 4
    %125 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 8
    %126 = load i32* %125, align 4
    %127 = icmp slt i32 %124, %126
    br i1 %127, label %128, label %138
    
; <label>: %128
    %129 = load i32* %i, align 4
    %130 = load i32* %i, align 4
    %131 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 7
    %132 = load %struct.$IntArray** %131, align 8
    %133 = call %struct.$IntArray* @$IntArray_Assign(%struct.$IntArray* %132, i32 %129, i32 %130)
    %134 = load i32* %i, align 4
    %135 = alloca i32, align 4
    store i32 1, i32* %135, align 4
    %136 = load i32* %135, align 4
    %137 = add nsw i32 %134, %136
    store i32 %137, i32* %i, align 4
    br label %123
    
; <label>: %138
    %139 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %139, align 8
    %140 = load %struct.MazeArray** %139, align 8
    %141 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 6
    %142 = load %struct.$IntArray** %141, align 8
    %143 = getelementptr inbounds %struct.MazeArray* %140, i32 0, i32 0
    %144 = load %struct.MazeArray$vtable** %143, align 8
    %145 = getelementptr inbounds %struct.MazeArray$vtable* %144, i32 0, i32 14
    %146 = load %struct.$IntArray* (%struct.MazeArray*, %struct.$IntArray*)** %145, align 8
    %147 = call %struct.$IntArray* %146(%struct.MazeArray* %140, %struct.$IntArray* %142)
    %148 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 6
    store %struct.$IntArray* %147, %struct.$IntArray** %148, align 8
    %149 = alloca i32, align 4
    store i32 0, i32* %149, align 4
    %150 = load i32* %149, align 4
    store i32 %150, i32* %i, align 4
    br label %151
    
; <label>: %151
    %152 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %152, align 8
    %153 = load %struct.MazeArray** %152, align 8
    %154 = getelementptr inbounds %struct.MazeArray* %153, i32 0, i32 0
    %155 = load %struct.MazeArray$vtable** %154, align 8
    %156 = getelementptr inbounds %struct.MazeArray$vtable* %155, i32 0, i32 3
    %157 = load i1 (%struct.MazeArray*)** %156, align 8
    %158 = call i1 %157(%struct.MazeArray* %153)
    %159 = xor i1 %158, 1
    br i1 %159, label %160, label %176
    
; <label>: %160
    %161 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %161, align 8
    %162 = load %struct.MazeArray** %161, align 8
    %163 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 6
    %164 = load %struct.$IntArray** %163, align 8
    %165 = load i32* %i, align 4
    %166 = call i32 @$IntArray_Read(%struct.$IntArray* %164, i32 %165)
    %167 = getelementptr inbounds %struct.MazeArray* %162, i32 0, i32 0
    %168 = load %struct.MazeArray$vtable** %167, align 8
    %169 = getelementptr inbounds %struct.MazeArray$vtable* %168, i32 0, i32 12
    %170 = load i1 (%struct.MazeArray*, i32)** %169, align 8
    %171 = call i1 %170(%struct.MazeArray* %162, i32 %166)
    store i1 %171, i1* %dummy, align 4
    %172 = load i32* %i, align 4
    %173 = alloca i32, align 4
    store i32 1, i32* %173, align 4
    %174 = load i32* %173, align 4
    %175 = add nsw i32 %172, %174
    store i32 %175, i32* %i, align 4
    br label %151
    
; <label>: %176
    %177 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %177, align 8
    %178 = load %struct.MazeArray** %177, align 8
    ret %struct.MazeArray* %178
}

define i32 @MazeArray$cellRepresentative(%struct.MazeArray* %this, i32 %_cid) nounwind ssp {
    %cid = alloca i32, align 4
    store i32 %_cid, i32* %cid, align 4
    %ptr = alloca i32, align 4
    %1 = load i32* %cid, align 4
    store i32 %1, i32* %ptr, align 4
    br label %2
    
; <label>: %2
    %3 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 7
    %4 = load %struct.$IntArray** %3, align 8
    %5 = load i32* %ptr, align 4
    %6 = call i32 @$IntArray_Read(%struct.$IntArray* %4, i32 %5)
    %7 = load i32* %ptr, align 4
    %8 = icmp eq  i32 %6, %7
    %9 = xor i1 %8, 1
    br i1 %9, label %10, label %15
    
; <label>: %10
    %11 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 7
    %12 = load %struct.$IntArray** %11, align 8
    %13 = load i32* %ptr, align 4
    %14 = call i32 @$IntArray_Read(%struct.$IntArray* %12, i32 %13)
    store i32 %14, i32* %ptr, align 4
    br label %2
    
; <label>: %15
    %16 = load i32* %cid, align 4
    %17 = load i32* %ptr, align 4
    %18 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 7
    %19 = load %struct.$IntArray** %18, align 8
    %20 = call %struct.$IntArray* @$IntArray_Assign(%struct.$IntArray* %19, i32 %16, i32 %17)
    %21 = load i32* %ptr, align 4
    ret i32 %21
}

define i1 @MazeArray$setRepresentative(%struct.MazeArray* %this, i32 %_cid, i32 %_repr) nounwind ssp {
    %cid = alloca i32, align 4
    store i32 %_cid, i32* %cid, align 4
    %repr = alloca i32, align 4
    store i32 %_repr, i32* %repr, align 4
    
    %1 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %1, align 8
    %2 = load %struct.MazeArray** %1, align 8
    %3 = load i32* %cid, align 4
    %4 = getelementptr inbounds %struct.MazeArray* %2, i32 0, i32 0
    %5 = load %struct.MazeArray$vtable** %4, align 8
    %6 = getelementptr inbounds %struct.MazeArray$vtable* %5, i32 0, i32 1
    %7 = load i32 (%struct.MazeArray*, i32)** %6, align 8
    %8 = call i32 %7(%struct.MazeArray* %2, i32 %3)
    %9 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %9, align 8
    %10 = load %struct.MazeArray** %9, align 8
    %11 = load i32* %repr, align 4
    %12 = getelementptr inbounds %struct.MazeArray* %10, i32 0, i32 0
    %13 = load %struct.MazeArray$vtable** %12, align 8
    %14 = getelementptr inbounds %struct.MazeArray$vtable* %13, i32 0, i32 1
    %15 = load i32 (%struct.MazeArray*, i32)** %14, align 8
    %16 = call i32 %15(%struct.MazeArray* %10, i32 %11)
    %17 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 7
    %18 = load %struct.$IntArray** %17, align 8
    %19 = call %struct.$IntArray* @$IntArray_Assign(%struct.$IntArray* %18, i32 %8, i32 %16)
    %20 = alloca i1, align 4
    store i1 true, i1* %20, align 4
    %21 = load i1* %20, align 4
    ret i1 %21
}

define i1 @MazeArray$allMerged(%struct.MazeArray* %this) nounwind ssp {
    %i = alloca i32, align 4
    %1 = alloca i32, align 4
    store i32 1, i32* %1, align 4
    %2 = load i32* %1, align 4
    store i32 %2, i32* %i, align 4
    br label %3
    
; <label>: %3
    %4 = load i32* %i, align 4
    %5 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 8
    %6 = load i32* %5, align 4
    %7 = icmp slt i32 %4, %6
    br label %8
    
; <label>: %8
    br i1 %7, label %9, label %29
    
; <label>: %9
    %10 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %10, align 8
    %11 = load %struct.MazeArray** %10, align 8
    %12 = load i32* %i, align 4
    %13 = getelementptr inbounds %struct.MazeArray* %11, i32 0, i32 0
    %14 = load %struct.MazeArray$vtable** %13, align 8
    %15 = getelementptr inbounds %struct.MazeArray$vtable* %14, i32 0, i32 1
    %16 = load i32 (%struct.MazeArray*, i32)** %15, align 8
    %17 = call i32 %16(%struct.MazeArray* %11, i32 %12)
    %18 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %18, align 8
    %19 = load %struct.MazeArray** %18, align 8
    %20 = alloca i32, align 4
    store i32 0, i32* %20, align 4
    %21 = load i32* %20, align 4
    %22 = getelementptr inbounds %struct.MazeArray* %19, i32 0, i32 0
    %23 = load %struct.MazeArray$vtable** %22, align 8
    %24 = getelementptr inbounds %struct.MazeArray$vtable* %23, i32 0, i32 1
    %25 = load i32 (%struct.MazeArray*, i32)** %24, align 8
    %26 = call i32 %25(%struct.MazeArray* %19, i32 %21)
    %27 = icmp eq  i32 %17, %26
    br label %28
    
; <label>: %28
    br label %29
    
; <label>: %29
    %30 = phi i1 [ false, %8 ], [ %27, %28 ]
    br i1 %30, label %31, label %36
    
; <label>: %31
    %32 = load i32* %i, align 4
    %33 = alloca i32, align 4
    store i32 1, i32* %33, align 4
    %34 = load i32* %33, align 4
    %35 = add nsw i32 %32, %34
    store i32 %35, i32* %i, align 4
    br label %3
    
; <label>: %36
    %37 = load i32* %i, align 4
    %38 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 8
    %39 = load i32* %38, align 4
    %40 = icmp eq  i32 %37, %39
    ret i1 %40
}

define i32 @MazeArray$cellID(%struct.MazeArray* %this, i32 %_row, i32 %_col) nounwind ssp {
    %row = alloca i32, align 4
    store i32 %_row, i32* %row, align 4
    %col = alloca i32, align 4
    store i32 %_col, i32* %col, align 4
    
    
    %1 = load i32* %row, align 4
    %2 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %3 = load i32* %2, align 4
    %4 = mul nsw i32 %1, %3
    %5 = load i32* %col, align 4
    %6 = add nsw i32 %4, %5
    ret i32 %6
}

define i32 @MazeArray$cellRow(%struct.MazeArray* %this, i32 %_cid) nounwind ssp {
    %cid = alloca i32, align 4
    store i32 %_cid, i32* %cid, align 4
    
    
    %1 = load i32* %cid, align 4
    %2 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %3 = load i32* %2, align 4
    %4 = sdiv i32 %1, %3
    ret i32 %4
}

define i32 @MazeArray$cellCol(%struct.MazeArray* %this, i32 %_cid) nounwind ssp {
    %cid = alloca i32, align 4
    store i32 %_cid, i32* %cid, align 4
    
    
    %1 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 2
    %2 = load %struct.PseudoRandomNumberGenerator** %1, align 8
    %3 = load i32* %cid, align 4
    %4 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %5 = load i32* %4, align 4
    %6 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %2, i32 0, i32 0
    %7 = load %struct.PseudoRandomNumberGenerator$vtable** %6, align 8
    %8 = getelementptr inbounds %struct.PseudoRandomNumberGenerator$vtable* %7, i32 0, i32 2
    %9 = load i32 (%struct.PseudoRandomNumberGenerator*, i32, i32)** %8, align 8
    %10 = call i32 %9(%struct.PseudoRandomNumberGenerator* %2, i32 %3, i32 %5)
    ret i32 %10
}

define i32 @MazeArray$wallID(%struct.MazeArray* %this, i1 %_horizontal, i32 %_row, i32 %_col) nounwind ssp {
    %horizontal = alloca i1, align 4
    store i1 %_horizontal, i1* %horizontal, align 4
    %row = alloca i32, align 4
    store i32 %_row, i32* %row, align 4
    %col = alloca i32, align 4
    store i32 %_col, i32* %col, align 4
    %toRet = alloca i32, align 4
    %1 = load i1* %horizontal, align 4
    br i1 %1, label %2, label %9
    
; <label>: %2
    %3 = load i32* %row, align 4
    %4 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %5 = load i32* %4, align 4
    %6 = mul nsw i32 %3, %5
    %7 = load i32* %col, align 4
    %8 = add nsw i32 %6, %7
    store i32 %8, i32* %toRet, align 4
    br label %22
    
; <label>: %9
    %10 = load i32* %row, align 4
    %11 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %12 = load i32* %11, align 4
    %13 = alloca i32, align 4
    store i32 1, i32* %13, align 4
    %14 = load i32* %13, align 4
    %15 = sub nsw i32 %12, %14
    %16 = mul nsw i32 %10, %15
    %17 = load i32* %col, align 4
    %18 = add nsw i32 %16, %17
    %19 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 5
    %20 = load i32* %19, align 4
    %21 = add nsw i32 %18, %20
    store i32 %21, i32* %toRet, align 4
    br label %22
    
; <label>: %22
    %23 = load i32* %toRet, align 4
    ret i32 %23
}

define i32 @MazeArray$wallRow(%struct.MazeArray* %this, i32 %_wid) nounwind ssp {
    %wid = alloca i32, align 4
    store i32 %_wid, i32* %wid, align 4
    %toRet = alloca i32, align 4
    %1 = load i32* %wid, align 4
    %2 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 5
    %3 = load i32* %2, align 4
    %4 = icmp slt i32 %1, %3
    br i1 %4, label %5, label %10
    
; <label>: %5
    %6 = load i32* %wid, align 4
    %7 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %8 = load i32* %7, align 4
    %9 = sdiv i32 %6, %8
    store i32 %9, i32* %toRet, align 4
    br label %21
    
; <label>: %10
    %11 = load i32* %wid, align 4
    %12 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 5
    %13 = load i32* %12, align 4
    %14 = sub nsw i32 %11, %13
    %15 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %16 = load i32* %15, align 4
    %17 = alloca i32, align 4
    store i32 1, i32* %17, align 4
    %18 = load i32* %17, align 4
    %19 = sub nsw i32 %16, %18
    %20 = sdiv i32 %14, %19
    store i32 %20, i32* %toRet, align 4
    br label %21
    
; <label>: %21
    %22 = load i32* %toRet, align 4
    ret i32 %22
}

define i32 @MazeArray$wallCol(%struct.MazeArray* %this, i32 %_wid) nounwind ssp {
    %wid = alloca i32, align 4
    store i32 %_wid, i32* %wid, align 4
    %toRet = alloca i32, align 4
    %1 = load i32* %wid, align 4
    %2 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 5
    %3 = load i32* %2, align 4
    %4 = icmp slt i32 %1, %3
    br i1 %4, label %5, label %16
    
; <label>: %5
    %6 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 2
    %7 = load %struct.PseudoRandomNumberGenerator** %6, align 8
    %8 = load i32* %wid, align 4
    %9 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %10 = load i32* %9, align 4
    %11 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %7, i32 0, i32 0
    %12 = load %struct.PseudoRandomNumberGenerator$vtable** %11, align 8
    %13 = getelementptr inbounds %struct.PseudoRandomNumberGenerator$vtable* %12, i32 0, i32 2
    %14 = load i32 (%struct.PseudoRandomNumberGenerator*, i32, i32)** %13, align 8
    %15 = call i32 %14(%struct.PseudoRandomNumberGenerator* %7, i32 %8, i32 %10)
    store i32 %15, i32* %toRet, align 4
    br label %33
    
; <label>: %16
    %17 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 2
    %18 = load %struct.PseudoRandomNumberGenerator** %17, align 8
    %19 = load i32* %wid, align 4
    %20 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 5
    %21 = load i32* %20, align 4
    %22 = sub nsw i32 %19, %21
    %23 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %24 = load i32* %23, align 4
    %25 = alloca i32, align 4
    store i32 1, i32* %25, align 4
    %26 = load i32* %25, align 4
    %27 = sub nsw i32 %24, %26
    %28 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %18, i32 0, i32 0
    %29 = load %struct.PseudoRandomNumberGenerator$vtable** %28, align 8
    %30 = getelementptr inbounds %struct.PseudoRandomNumberGenerator$vtable* %29, i32 0, i32 2
    %31 = load i32 (%struct.PseudoRandomNumberGenerator*, i32, i32)** %30, align 8
    %32 = call i32 %31(%struct.PseudoRandomNumberGenerator* %18, i32 %22, i32 %27)
    store i32 %32, i32* %toRet, align 4
    br label %33
    
; <label>: %33
    %34 = load i32* %toRet, align 4
    ret i32 %34
}

define i32 @MazeArray$cellOneOfWall(%struct.MazeArray* %this, i32 %_wid) nounwind ssp {
    %wid = alloca i32, align 4
    store i32 %_wid, i32* %wid, align 4
    
    
    %1 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %1, align 8
    %2 = load %struct.MazeArray** %1, align 8
    %3 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %3, align 8
    %4 = load %struct.MazeArray** %3, align 8
    %5 = load i32* %wid, align 4
    %6 = getelementptr inbounds %struct.MazeArray* %4, i32 0, i32 0
    %7 = load %struct.MazeArray$vtable** %6, align 8
    %8 = getelementptr inbounds %struct.MazeArray$vtable* %7, i32 0, i32 8
    %9 = load i32 (%struct.MazeArray*, i32)** %8, align 8
    %10 = call i32 %9(%struct.MazeArray* %4, i32 %5)
    %11 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %11, align 8
    %12 = load %struct.MazeArray** %11, align 8
    %13 = load i32* %wid, align 4
    %14 = getelementptr inbounds %struct.MazeArray* %12, i32 0, i32 0
    %15 = load %struct.MazeArray$vtable** %14, align 8
    %16 = getelementptr inbounds %struct.MazeArray$vtable* %15, i32 0, i32 9
    %17 = load i32 (%struct.MazeArray*, i32)** %16, align 8
    %18 = call i32 %17(%struct.MazeArray* %12, i32 %13)
    %19 = getelementptr inbounds %struct.MazeArray* %2, i32 0, i32 0
    %20 = load %struct.MazeArray$vtable** %19, align 8
    %21 = getelementptr inbounds %struct.MazeArray$vtable* %20, i32 0, i32 4
    %22 = load i32 (%struct.MazeArray*, i32, i32)** %21, align 8
    %23 = call i32 %22(%struct.MazeArray* %2, i32 %10, i32 %18)
    ret i32 %23
}

define i32 @MazeArray$cellTwoOfWall(%struct.MazeArray* %this, i32 %_wid) nounwind ssp {
    %wid = alloca i32, align 4
    store i32 %_wid, i32* %wid, align 4
    %toRet = alloca i32, align 4
    %1 = load i32* %wid, align 4
    %2 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 5
    %3 = load i32* %2, align 4
    %4 = icmp slt i32 %1, %3
    br i1 %4, label %5, label %32
    
; <label>: %5
    %6 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %6, align 8
    %7 = load %struct.MazeArray** %6, align 8
    %8 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %8, align 8
    %9 = load %struct.MazeArray** %8, align 8
    %10 = load i32* %wid, align 4
    %11 = getelementptr inbounds %struct.MazeArray* %9, i32 0, i32 0
    %12 = load %struct.MazeArray$vtable** %11, align 8
    %13 = getelementptr inbounds %struct.MazeArray$vtable* %12, i32 0, i32 8
    %14 = load i32 (%struct.MazeArray*, i32)** %13, align 8
    %15 = call i32 %14(%struct.MazeArray* %9, i32 %10)
    %16 = alloca i32, align 4
    store i32 1, i32* %16, align 4
    %17 = load i32* %16, align 4
    %18 = add nsw i32 %15, %17
    %19 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %19, align 8
    %20 = load %struct.MazeArray** %19, align 8
    %21 = load i32* %wid, align 4
    %22 = getelementptr inbounds %struct.MazeArray* %20, i32 0, i32 0
    %23 = load %struct.MazeArray$vtable** %22, align 8
    %24 = getelementptr inbounds %struct.MazeArray$vtable* %23, i32 0, i32 9
    %25 = load i32 (%struct.MazeArray*, i32)** %24, align 8
    %26 = call i32 %25(%struct.MazeArray* %20, i32 %21)
    %27 = getelementptr inbounds %struct.MazeArray* %7, i32 0, i32 0
    %28 = load %struct.MazeArray$vtable** %27, align 8
    %29 = getelementptr inbounds %struct.MazeArray$vtable* %28, i32 0, i32 4
    %30 = load i32 (%struct.MazeArray*, i32, i32)** %29, align 8
    %31 = call i32 %30(%struct.MazeArray* %7, i32 %18, i32 %26)
    store i32 %31, i32* %toRet, align 4
    br label %59
    
; <label>: %32
    %33 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %33, align 8
    %34 = load %struct.MazeArray** %33, align 8
    %35 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %35, align 8
    %36 = load %struct.MazeArray** %35, align 8
    %37 = load i32* %wid, align 4
    %38 = getelementptr inbounds %struct.MazeArray* %36, i32 0, i32 0
    %39 = load %struct.MazeArray$vtable** %38, align 8
    %40 = getelementptr inbounds %struct.MazeArray$vtable* %39, i32 0, i32 8
    %41 = load i32 (%struct.MazeArray*, i32)** %40, align 8
    %42 = call i32 %41(%struct.MazeArray* %36, i32 %37)
    %43 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %43, align 8
    %44 = load %struct.MazeArray** %43, align 8
    %45 = load i32* %wid, align 4
    %46 = getelementptr inbounds %struct.MazeArray* %44, i32 0, i32 0
    %47 = load %struct.MazeArray$vtable** %46, align 8
    %48 = getelementptr inbounds %struct.MazeArray$vtable* %47, i32 0, i32 9
    %49 = load i32 (%struct.MazeArray*, i32)** %48, align 8
    %50 = call i32 %49(%struct.MazeArray* %44, i32 %45)
    %51 = alloca i32, align 4
    store i32 1, i32* %51, align 4
    %52 = load i32* %51, align 4
    %53 = add nsw i32 %50, %52
    %54 = getelementptr inbounds %struct.MazeArray* %34, i32 0, i32 0
    %55 = load %struct.MazeArray$vtable** %54, align 8
    %56 = getelementptr inbounds %struct.MazeArray$vtable* %55, i32 0, i32 4
    %57 = load i32 (%struct.MazeArray*, i32, i32)** %56, align 8
    %58 = call i32 %57(%struct.MazeArray* %34, i32 %42, i32 %53)
    store i32 %58, i32* %toRet, align 4
    br label %59
    
; <label>: %59
    %60 = load i32* %toRet, align 4
    ret i32 %60
}

define i1 @MazeArray$destroyIfNotConnected(%struct.MazeArray* %this, i32 %_wid) nounwind ssp {
    %wid = alloca i32, align 4
    store i32 %_wid, i32* %wid, align 4
    %c1 = alloca i32, align 4
    %c2 = alloca i32, align 4
    %dummy = alloca i1, align 4
    %1 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %1, align 8
    %2 = load %struct.MazeArray** %1, align 8
    %3 = load i32* %wid, align 4
    %4 = getelementptr inbounds %struct.MazeArray* %2, i32 0, i32 0
    %5 = load %struct.MazeArray$vtable** %4, align 8
    %6 = getelementptr inbounds %struct.MazeArray$vtable* %5, i32 0, i32 10
    %7 = load i32 (%struct.MazeArray*, i32)** %6, align 8
    %8 = call i32 %7(%struct.MazeArray* %2, i32 %3)
    store i32 %8, i32* %c1, align 4
    %9 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %9, align 8
    %10 = load %struct.MazeArray** %9, align 8
    %11 = load i32* %wid, align 4
    %12 = getelementptr inbounds %struct.MazeArray* %10, i32 0, i32 0
    %13 = load %struct.MazeArray$vtable** %12, align 8
    %14 = getelementptr inbounds %struct.MazeArray$vtable* %13, i32 0, i32 11
    %15 = load i32 (%struct.MazeArray*, i32)** %14, align 8
    %16 = call i32 %15(%struct.MazeArray* %10, i32 %11)
    store i32 %16, i32* %c2, align 4
    %17 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %17, align 8
    %18 = load %struct.MazeArray** %17, align 8
    %19 = load i32* %c1, align 4
    %20 = getelementptr inbounds %struct.MazeArray* %18, i32 0, i32 0
    %21 = load %struct.MazeArray$vtable** %20, align 8
    %22 = getelementptr inbounds %struct.MazeArray$vtable* %21, i32 0, i32 1
    %23 = load i32 (%struct.MazeArray*, i32)** %22, align 8
    %24 = call i32 %23(%struct.MazeArray* %18, i32 %19)
    %25 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %25, align 8
    %26 = load %struct.MazeArray** %25, align 8
    %27 = load i32* %c2, align 4
    %28 = getelementptr inbounds %struct.MazeArray* %26, i32 0, i32 0
    %29 = load %struct.MazeArray$vtable** %28, align 8
    %30 = getelementptr inbounds %struct.MazeArray$vtable* %29, i32 0, i32 1
    %31 = load i32 (%struct.MazeArray*, i32)** %30, align 8
    %32 = call i32 %31(%struct.MazeArray* %26, i32 %27)
    %33 = icmp eq  i32 %24, %32
    %34 = xor i1 %33, 1
    br i1 %34, label %35, label %51
    
; <label>: %35
    %36 = load i32* %wid, align 4
    %37 = alloca i32, align 4
    store i32 0, i32* %37, align 4
    %38 = load i32* %37, align 4
    %39 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %40 = load %struct.$IntArray** %39, align 8
    %41 = call %struct.$IntArray* @$IntArray_Assign(%struct.$IntArray* %40, i32 %36, i32 %38)
    %42 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %42, align 8
    %43 = load %struct.MazeArray** %42, align 8
    %44 = load i32* %c1, align 4
    %45 = load i32* %c2, align 4
    %46 = getelementptr inbounds %struct.MazeArray* %43, i32 0, i32 0
    %47 = load %struct.MazeArray$vtable** %46, align 8
    %48 = getelementptr inbounds %struct.MazeArray$vtable* %47, i32 0, i32 2
    %49 = load i1 (%struct.MazeArray*, i32, i32)** %48, align 8
    %50 = call i1 %49(%struct.MazeArray* %43, i32 %44, i32 %45)
    store i1 %50, i1* %dummy, align 4
    br label %51
    
; <label>: %51
    %52 = alloca i1, align 4
    store i1 true, i1* %52, align 4
    %53 = load i1* %52, align 4
    ret i1 %53
}

define i8* @MazeArray$printMaze(%struct.MazeArray* %this) nounwind ssp {
    %i = alloca i32, align 4
    %j = alloca i32, align 4
    %str = alloca i8*, align 8
    %c = alloca i8*, align 8
    %w1 = alloca i1, align 4
    %w2 = alloca i1, align 4
    %w3 = alloca i1, align 4
    %w4 = alloca i1, align 4
    %1 = alloca i32, align 4
    store i32 0, i32* %1, align 4
    %2 = load i32* %1, align 4
    store i32 %2, i32* %i, align 4
    %3 = alloca i32, align 4
    store i32 0, i32* %3, align 4
    %4 = load i32* %3, align 4
    store i32 %4, i32* %j, align 4
    %5 = alloca i8*, align 8
    store i8* getelementptr inbounds ([1 x i8]* @.str22, i32 0, i32 0), i8** %5, align 8
    %6 = load i8** %5, align 8
    store i8* %6, i8** %str, align 8
    %7 = alloca i8*, align 8
    store i8* getelementptr inbounds ([1 x i8]* @.str23, i32 0, i32 0), i8** %7, align 8
    %8 = load i8** %7, align 8
    store i8* %8, i8** %c, align 8
    %9 = alloca i1, align 4
    store i1 false, i1* %9, align 4
    %10 = load i1* %9, align 4
    store i1 %10, i1* %w1, align 4
    %11 = alloca i1, align 4
    store i1 false, i1* %11, align 4
    %12 = load i1* %11, align 4
    store i1 %12, i1* %w2, align 4
    %13 = alloca i1, align 4
    store i1 false, i1* %13, align 4
    %14 = load i1* %13, align 4
    store i1 %14, i1* %w3, align 4
    %15 = alloca i1, align 4
    store i1 false, i1* %15, align 4
    %16 = load i1* %15, align 4
    store i1 %16, i1* %w4, align 4
    %17 = alloca i32, align 4
    store i32 0, i32* %17, align 4
    %18 = load i32* %17, align 4
    store i32 %18, i32* %i, align 4
    %19 = alloca i8*, align 8
    store i8* getelementptr inbounds ([4 x i8]* @.str24, i32 0, i32 0), i8** %19, align 8
    %20 = load i8** %19, align 8
    %21 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 17
    %22 = load i8** %21, align 8
    %23 = call i8* @$concat(i8* %20, i8* %22)
    store i8* %23, i8** %str, align 8
    br label %24
    
; <label>: %24
    %25 = load i32* %i, align 4
    %26 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %27 = load i32* %26, align 4
    %28 = icmp slt i32 %25, %27
    br i1 %28, label %29, label %87
    
; <label>: %29
    %30 = load i8** %str, align 8
    %31 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %32 = load i8** %31, align 8
    %33 = call i8* @$concat(i8* %30, i8* %32)
    %34 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %35 = load i8** %34, align 8
    %36 = call i8* @$concat(i8* %33, i8* %35)
    %37 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %38 = load i8** %37, align 8
    %39 = call i8* @$concat(i8* %36, i8* %38)
    store i8* %39, i8** %str, align 8
    %40 = load i32* %i, align 4
    %41 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %42 = load i32* %41, align 4
    %43 = alloca i32, align 4
    store i32 1, i32* %43, align 4
    %44 = load i32* %43, align 4
    %45 = sub nsw i32 %42, %44
    %46 = icmp eq  i32 %40, %45
    br i1 %46, label %47, label %52
    
; <label>: %47
    %48 = load i8** %str, align 8
    %49 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 18
    %50 = load i8** %49, align 8
    %51 = call i8* @$concat(i8* %48, i8* %50)
    store i8* %51, i8** %str, align 8
    br label %82
    
; <label>: %52
    %53 = alloca i32, align 4
    store i32 0, i32* %53, align 4
    %54 = load i32* %53, align 4
    %55 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %56 = load %struct.$IntArray** %55, align 8
    %57 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %57, align 8
    %58 = load %struct.MazeArray** %57, align 8
    %59 = alloca i1, align 4
    store i1 false, i1* %59, align 4
    %60 = load i1* %59, align 4
    %61 = alloca i32, align 4
    store i32 0, i32* %61, align 4
    %62 = load i32* %61, align 4
    %63 = load i32* %i, align 4
    %64 = getelementptr inbounds %struct.MazeArray* %58, i32 0, i32 0
    %65 = load %struct.MazeArray$vtable** %64, align 8
    %66 = getelementptr inbounds %struct.MazeArray$vtable* %65, i32 0, i32 7
    %67 = load i32 (%struct.MazeArray*, i1, i32, i32)** %66, align 8
    %68 = call i32 %67(%struct.MazeArray* %58, i1 %60, i32 %62, i32 %63)
    %69 = call i32 @$IntArray_Read(%struct.$IntArray* %56, i32 %68)
    %70 = icmp slt i32 %54, %69
    br i1 %70, label %71, label %76
    
; <label>: %71
    %72 = load i8** %str, align 8
    %73 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 12
    %74 = load i8** %73, align 8
    %75 = call i8* @$concat(i8* %72, i8* %74)
    store i8* %75, i8** %str, align 8
    br label %81
    
; <label>: %76
    %77 = load i8** %str, align 8
    %78 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %79 = load i8** %78, align 8
    %80 = call i8* @$concat(i8* %77, i8* %79)
    store i8* %80, i8** %str, align 8
    br label %81
    
; <label>: %81
    br label %82
    
; <label>: %82
    %83 = load i32* %i, align 4
    %84 = alloca i32, align 4
    store i32 1, i32* %84, align 4
    %85 = load i32* %84, align 4
    %86 = add nsw i32 %83, %85
    store i32 %86, i32* %i, align 4
    br label %24
    
; <label>: %87
    %88 = load i8** %str, align 8
    %89 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %88)
    %90 = alloca i32, align 4
    store i32 0, i32* %90, align 4
    %91 = load i32* %90, align 4
    store i32 %91, i32* %i, align 4
    %92 = alloca i8*, align 8
    store i8* getelementptr inbounds ([1 x i8]* @.str25, i32 0, i32 0), i8** %92, align 8
    %93 = load i8** %92, align 8
    store i8* %93, i8** %str, align 8
    %94 = alloca i8*, align 8
    store i8* getelementptr inbounds ([1 x i8]* @.str26, i32 0, i32 0), i8** %94, align 8
    %95 = load i8** %94, align 8
    store i8* %95, i8** %c, align 8
    br label %96
    
; <label>: %96
    %97 = load i32* %i, align 4
    %98 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %99 = load i32* %98, align 4
    %100 = icmp slt i32 %97, %99
    br i1 %100, label %101, label %863
    
; <label>: %101
    %102 = load i32* %i, align 4
    %103 = alloca i32, align 4
    store i32 0, i32* %103, align 4
    %104 = load i32* %103, align 4
    %105 = icmp eq  i32 %102, %104
    br i1 %105, label %106, label %124
    
; <label>: %106
    %107 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str27, i32 0, i32 0), i8** %107, align 8
    %108 = load i8** %107, align 8
    %109 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 24
    %110 = load i8** %109, align 8
    %111 = call i8* @$concat(i8* %108, i8* %110)
    %112 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 24
    %113 = load i8** %112, align 8
    %114 = call i8* @$concat(i8* %111, i8* %113)
    %115 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 24
    %116 = load i8** %115, align 8
    %117 = call i8* @$concat(i8* %114, i8* %116)
    %118 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 25
    %119 = load i8** %118, align 8
    %120 = call i8* @$concat(i8* %117, i8* %119)
    %121 = alloca i8*, align 8
    store i8* getelementptr inbounds ([3 x i8]* @.str28, i32 0, i32 0), i8** %121, align 8
    %122 = load i8** %121, align 8
    %123 = call i8* @$concat(i8* %120, i8* %122)
    store i8* %123, i8** %str, align 8
    br label %133
    
; <label>: %124
    %125 = alloca i8*, align 8
    store i8* getelementptr inbounds ([4 x i8]* @.str29, i32 0, i32 0), i8** %125, align 8
    %126 = load i8** %125, align 8
    %127 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 9
    %128 = load i8** %127, align 8
    %129 = call i8* @$concat(i8* %126, i8* %128)
    %130 = alloca i8*, align 8
    store i8* getelementptr inbounds ([4 x i8]* @.str30, i32 0, i32 0), i8** %130, align 8
    %131 = load i8** %130, align 8
    %132 = call i8* @$concat(i8* %129, i8* %131)
    store i8* %132, i8** %str, align 8
    br label %133
    
; <label>: %133
    %134 = alloca i32, align 4
    store i32 0, i32* %134, align 4
    %135 = load i32* %134, align 4
    store i32 %135, i32* %j, align 4
    br label %136
    
; <label>: %136
    %137 = load i32* %j, align 4
    %138 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %139 = load i32* %138, align 4
    %140 = alloca i32, align 4
    store i32 1, i32* %140, align 4
    %141 = load i32* %140, align 4
    %142 = sub nsw i32 %139, %141
    %143 = icmp slt i32 %137, %142
    br i1 %143, label %144, label %210
    
; <label>: %144
    %145 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %146 = load %struct.$IntArray** %145, align 8
    %147 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %147, align 8
    %148 = load %struct.MazeArray** %147, align 8
    %149 = alloca i1, align 4
    store i1 false, i1* %149, align 4
    %150 = load i1* %149, align 4
    %151 = load i32* %i, align 4
    %152 = load i32* %j, align 4
    %153 = getelementptr inbounds %struct.MazeArray* %148, i32 0, i32 0
    %154 = load %struct.MazeArray$vtable** %153, align 8
    %155 = getelementptr inbounds %struct.MazeArray$vtable* %154, i32 0, i32 7
    %156 = load i32 (%struct.MazeArray*, i1, i32, i32)** %155, align 8
    %157 = call i32 %156(%struct.MazeArray* %148, i1 %150, i32 %151, i32 %152)
    %158 = call i32 @$IntArray_Read(%struct.$IntArray* %146, i32 %157)
    %159 = alloca i32, align 4
    store i32 1, i32* %159, align 4
    %160 = load i32* %159, align 4
    %161 = icmp eq  i32 %158, %160
    br i1 %161, label %162, label %165
    
; <label>: %162
    %163 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 9
    %164 = load i8** %163, align 8
    store i8* %164, i8** %c, align 8
    br label %168
    
; <label>: %165
    %166 = alloca i8*, align 8
    store i8* getelementptr inbounds ([2 x i8]* @.str31, i32 0, i32 0), i8** %166, align 8
    %167 = load i8** %166, align 8
    store i8* %167, i8** %c, align 8
    br label %168
    
; <label>: %168
    %169 = load i8** %str, align 8
    %170 = load i8** %c, align 8
    %171 = call i8* @$concat(i8* %169, i8* %170)
    store i8* %171, i8** %str, align 8
    %172 = load i32* %i, align 4
    %173 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %174 = load i32* %173, align 4
    %175 = alloca i32, align 4
    store i32 1, i32* %175, align 4
    %176 = load i32* %175, align 4
    %177 = sub nsw i32 %174, %176
    %178 = icmp eq  i32 %172, %177
    br label %179
    
; <label>: %179
    br i1 %178, label %180, label %189
    
; <label>: %180
    %181 = load i32* %j, align 4
    %182 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %183 = load i32* %182, align 4
    %184 = alloca i32, align 4
    store i32 2, i32* %184, align 4
    %185 = load i32* %184, align 4
    %186 = sub nsw i32 %183, %185
    %187 = icmp eq  i32 %181, %186
    br label %188
    
; <label>: %188
    br label %189
    
; <label>: %189
    %190 = phi i1 [ false, %179 ], [ %187, %188 ]
    %191 = xor i1 %190, 1
    br i1 %191, label %192, label %197
    
; <label>: %192
    %193 = load i8** %str, align 8
    %194 = alloca i8*, align 8
    store i8* getelementptr inbounds ([4 x i8]* @.str32, i32 0, i32 0), i8** %194, align 8
    %195 = load i8** %194, align 8
    %196 = call i8* @$concat(i8* %193, i8* %195)
    store i8* %196, i8** %str, align 8
    br label %205
    
; <label>: %197
    %198 = load i8** %str, align 8
    %199 = alloca i8*, align 8
    store i8* getelementptr inbounds ([3 x i8]* @.str33, i32 0, i32 0), i8** %199, align 8
    %200 = load i8** %199, align 8
    %201 = call i8* @$concat(i8* %198, i8* %200)
    %202 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 24
    %203 = load i8** %202, align 8
    %204 = call i8* @$concat(i8* %201, i8* %203)
    store i8* %204, i8** %str, align 8
    br label %205
    
; <label>: %205
    %206 = load i32* %j, align 4
    %207 = alloca i32, align 4
    store i32 1, i32* %207, align 4
    %208 = load i32* %207, align 4
    %209 = add nsw i32 %206, %208
    store i32 %209, i32* %j, align 4
    br label %136
    
; <label>: %210
    %211 = load i32* %i, align 4
    %212 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %213 = load i32* %212, align 4
    %214 = alloca i32, align 4
    store i32 1, i32* %214, align 4
    %215 = load i32* %214, align 4
    %216 = sub nsw i32 %213, %215
    %217 = icmp eq  i32 %211, %216
    %218 = xor i1 %217, 1
    br i1 %218, label %219, label %224
    
; <label>: %219
    %220 = load i8** %str, align 8
    %221 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 9
    %222 = load i8** %221, align 8
    %223 = call i8* @$concat(i8* %220, i8* %222)
    store i8* %223, i8** %str, align 8
    br label %235
    
; <label>: %224
    %225 = load i8** %str, align 8
    %226 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 24
    %227 = load i8** %226, align 8
    %228 = call i8* @$concat(i8* %225, i8* %227)
    %229 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 24
    %230 = load i8** %229, align 8
    %231 = call i8* @$concat(i8* %228, i8* %230)
    %232 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 25
    %233 = load i8** %232, align 8
    %234 = call i8* @$concat(i8* %231, i8* %233)
    store i8* %234, i8** %str, align 8
    br label %235
    
; <label>: %235
    %236 = load i8** %str, align 8
    %237 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %236)
    %238 = load i32* %i, align 4
    %239 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %240 = load i32* %239, align 4
    %241 = alloca i32, align 4
    store i32 1, i32* %241, align 4
    %242 = load i32* %241, align 4
    %243 = sub nsw i32 %240, %242
    %244 = icmp slt i32 %238, %243
    br i1 %244, label %245, label %858
    
; <label>: %245
    %246 = alloca i8*, align 8
    store i8* getelementptr inbounds ([4 x i8]* @.str34, i32 0, i32 0), i8** %246, align 8
    %247 = load i8** %246, align 8
    store i8* %247, i8** %str, align 8
    %248 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %249 = load %struct.$IntArray** %248, align 8
    %250 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %250, align 8
    %251 = load %struct.MazeArray** %250, align 8
    %252 = alloca i1, align 4
    store i1 true, i1* %252, align 4
    %253 = load i1* %252, align 4
    %254 = load i32* %i, align 4
    %255 = alloca i32, align 4
    store i32 0, i32* %255, align 4
    %256 = load i32* %255, align 4
    %257 = getelementptr inbounds %struct.MazeArray* %251, i32 0, i32 0
    %258 = load %struct.MazeArray$vtable** %257, align 8
    %259 = getelementptr inbounds %struct.MazeArray$vtable* %258, i32 0, i32 7
    %260 = load i32 (%struct.MazeArray*, i1, i32, i32)** %259, align 8
    %261 = call i32 %260(%struct.MazeArray* %251, i1 %253, i32 %254, i32 %256)
    %262 = call i32 @$IntArray_Read(%struct.$IntArray* %249, i32 %261)
    %263 = alloca i32, align 4
    store i32 1, i32* %263, align 4
    %264 = load i32* %263, align 4
    %265 = icmp eq  i32 %262, %264
    br i1 %265, label %266, label %271
    
; <label>: %266
    %267 = load i8** %str, align 8
    %268 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 15
    %269 = load i8** %268, align 8
    %270 = call i8* @$concat(i8* %267, i8* %269)
    store i8* %270, i8** %str, align 8
    br label %276
    
; <label>: %271
    %272 = load i8** %str, align 8
    %273 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 9
    %274 = load i8** %273, align 8
    %275 = call i8* @$concat(i8* %272, i8* %274)
    store i8* %275, i8** %str, align 8
    br label %276
    
; <label>: %276
    %277 = alloca i32, align 4
    store i32 0, i32* %277, align 4
    %278 = load i32* %277, align 4
    store i32 %278, i32* %j, align 4
    br label %279
    
; <label>: %279
    %280 = load i32* %j, align 4
    %281 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %282 = load i32* %281, align 4
    %283 = icmp slt i32 %280, %282
    br i1 %283, label %284, label %855
    
; <label>: %284
    %285 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %286 = load %struct.$IntArray** %285, align 8
    %287 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %287, align 8
    %288 = load %struct.MazeArray** %287, align 8
    %289 = alloca i1, align 4
    store i1 true, i1* %289, align 4
    %290 = load i1* %289, align 4
    %291 = load i32* %i, align 4
    %292 = load i32* %j, align 4
    %293 = getelementptr inbounds %struct.MazeArray* %288, i32 0, i32 0
    %294 = load %struct.MazeArray$vtable** %293, align 8
    %295 = getelementptr inbounds %struct.MazeArray$vtable* %294, i32 0, i32 7
    %296 = load i32 (%struct.MazeArray*, i1, i32, i32)** %295, align 8
    %297 = call i32 %296(%struct.MazeArray* %288, i1 %290, i32 %291, i32 %292)
    %298 = call i32 @$IntArray_Read(%struct.$IntArray* %286, i32 %297)
    %299 = alloca i32, align 4
    store i32 1, i32* %299, align 4
    %300 = load i32* %299, align 4
    %301 = icmp eq  i32 %298, %300
    br i1 %301, label %302, label %311
    
; <label>: %302
    %303 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %304 = load i8** %303, align 8
    %305 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %306 = load i8** %305, align 8
    %307 = call i8* @$concat(i8* %304, i8* %306)
    %308 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %309 = load i8** %308, align 8
    %310 = call i8* @$concat(i8* %307, i8* %309)
    store i8* %310, i8** %c, align 8
    br label %314
    
; <label>: %311
    %312 = alloca i8*, align 8
    store i8* getelementptr inbounds ([4 x i8]* @.str35, i32 0, i32 0), i8** %312, align 8
    %313 = load i8** %312, align 8
    store i8* %313, i8** %c, align 8
    br label %314
    
; <label>: %314
    %315 = load i8** %str, align 8
    %316 = load i8** %c, align 8
    %317 = call i8* @$concat(i8* %315, i8* %316)
    store i8* %317, i8** %str, align 8
    %318 = load i32* %j, align 4
    %319 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %320 = load i32* %319, align 4
    %321 = alloca i32, align 4
    store i32 1, i32* %321, align 4
    %322 = load i32* %321, align 4
    %323 = sub nsw i32 %320, %322
    %324 = icmp slt i32 %318, %323
    br i1 %324, label %325, label %817
    
; <label>: %325
    %326 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %327 = load %struct.$IntArray** %326, align 8
    %328 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %328, align 8
    %329 = load %struct.MazeArray** %328, align 8
    %330 = alloca i1, align 4
    store i1 false, i1* %330, align 4
    %331 = load i1* %330, align 4
    %332 = load i32* %i, align 4
    %333 = load i32* %j, align 4
    %334 = getelementptr inbounds %struct.MazeArray* %329, i32 0, i32 0
    %335 = load %struct.MazeArray$vtable** %334, align 8
    %336 = getelementptr inbounds %struct.MazeArray$vtable* %335, i32 0, i32 7
    %337 = load i32 (%struct.MazeArray*, i1, i32, i32)** %336, align 8
    %338 = call i32 %337(%struct.MazeArray* %329, i1 %331, i32 %332, i32 %333)
    %339 = call i32 @$IntArray_Read(%struct.$IntArray* %327, i32 %338)
    %340 = alloca i32, align 4
    store i32 1, i32* %340, align 4
    %341 = load i32* %340, align 4
    %342 = icmp eq  i32 %339, %341
    store i1 %342, i1* %w1, align 4
    %343 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %344 = load %struct.$IntArray** %343, align 8
    %345 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %345, align 8
    %346 = load %struct.MazeArray** %345, align 8
    %347 = alloca i1, align 4
    store i1 true, i1* %347, align 4
    %348 = load i1* %347, align 4
    %349 = load i32* %i, align 4
    %350 = load i32* %j, align 4
    %351 = alloca i32, align 4
    store i32 1, i32* %351, align 4
    %352 = load i32* %351, align 4
    %353 = add nsw i32 %350, %352
    %354 = getelementptr inbounds %struct.MazeArray* %346, i32 0, i32 0
    %355 = load %struct.MazeArray$vtable** %354, align 8
    %356 = getelementptr inbounds %struct.MazeArray$vtable* %355, i32 0, i32 7
    %357 = load i32 (%struct.MazeArray*, i1, i32, i32)** %356, align 8
    %358 = call i32 %357(%struct.MazeArray* %346, i1 %348, i32 %349, i32 %353)
    %359 = call i32 @$IntArray_Read(%struct.$IntArray* %344, i32 %358)
    %360 = alloca i32, align 4
    store i32 1, i32* %360, align 4
    %361 = load i32* %360, align 4
    %362 = icmp eq  i32 %359, %361
    store i1 %362, i1* %w2, align 4
    %363 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %364 = load %struct.$IntArray** %363, align 8
    %365 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %365, align 8
    %366 = load %struct.MazeArray** %365, align 8
    %367 = alloca i1, align 4
    store i1 false, i1* %367, align 4
    %368 = load i1* %367, align 4
    %369 = load i32* %i, align 4
    %370 = alloca i32, align 4
    store i32 1, i32* %370, align 4
    %371 = load i32* %370, align 4
    %372 = add nsw i32 %369, %371
    %373 = load i32* %j, align 4
    %374 = getelementptr inbounds %struct.MazeArray* %366, i32 0, i32 0
    %375 = load %struct.MazeArray$vtable** %374, align 8
    %376 = getelementptr inbounds %struct.MazeArray$vtable* %375, i32 0, i32 7
    %377 = load i32 (%struct.MazeArray*, i1, i32, i32)** %376, align 8
    %378 = call i32 %377(%struct.MazeArray* %366, i1 %368, i32 %372, i32 %373)
    %379 = call i32 @$IntArray_Read(%struct.$IntArray* %364, i32 %378)
    %380 = alloca i32, align 4
    store i32 1, i32* %380, align 4
    %381 = load i32* %380, align 4
    %382 = icmp eq  i32 %379, %381
    store i1 %382, i1* %w3, align 4
    %383 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %384 = load %struct.$IntArray** %383, align 8
    %385 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %385, align 8
    %386 = load %struct.MazeArray** %385, align 8
    %387 = alloca i1, align 4
    store i1 true, i1* %387, align 4
    %388 = load i1* %387, align 4
    %389 = load i32* %i, align 4
    %390 = load i32* %j, align 4
    %391 = getelementptr inbounds %struct.MazeArray* %386, i32 0, i32 0
    %392 = load %struct.MazeArray$vtable** %391, align 8
    %393 = getelementptr inbounds %struct.MazeArray$vtable* %392, i32 0, i32 7
    %394 = load i32 (%struct.MazeArray*, i1, i32, i32)** %393, align 8
    %395 = call i32 %394(%struct.MazeArray* %386, i1 %388, i32 %389, i32 %390)
    %396 = call i32 @$IntArray_Read(%struct.$IntArray* %384, i32 %395)
    %397 = alloca i32, align 4
    store i32 1, i32* %397, align 4
    %398 = load i32* %397, align 4
    %399 = icmp eq  i32 %396, %398
    store i1 %399, i1* %w4, align 4
    %400 = load i1* %w1, align 4
    br label %401
    
; <label>: %401
    br i1 %400, label %402, label %405
    
; <label>: %402
    %403 = load i1* %w2, align 4
    br label %404
    
; <label>: %404
    br label %405
    
; <label>: %405
    %406 = phi i1 [ false, %401 ], [ %403, %404 ]
    br label %407
    
; <label>: %407
    br i1 %406, label %408, label %411
    
; <label>: %408
    %409 = load i1* %w3, align 4
    br label %410
    
; <label>: %410
    br label %411
    
; <label>: %411
    %412 = phi i1 [ false, %407 ], [ %409, %410 ]
    br label %413
    
; <label>: %413
    br i1 %412, label %414, label %417
    
; <label>: %414
    %415 = load i1* %w4, align 4
    br label %416
    
; <label>: %416
    br label %417
    
; <label>: %417
    %418 = phi i1 [ false, %413 ], [ %415, %416 ]
    br i1 %418, label %419, label %424
    
; <label>: %419
    %420 = load i8** %str, align 8
    %421 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 11
    %422 = load i8** %421, align 8
    %423 = call i8* @$concat(i8* %420, i8* %422)
    store i8* %423, i8** %str, align 8
    br label %816
    
; <label>: %424
    %425 = load i1* %w1, align 4
    br label %426
    
; <label>: %426
    br i1 %425, label %427, label %430
    
; <label>: %427
    %428 = load i1* %w2, align 4
    br label %429
    
; <label>: %429
    br label %430
    
; <label>: %430
    %431 = phi i1 [ false, %426 ], [ %428, %429 ]
    br label %432
    
; <label>: %432
    br i1 %431, label %433, label %436
    
; <label>: %433
    %434 = load i1* %w3, align 4
    br label %435
    
; <label>: %435
    br label %436
    
; <label>: %436
    %437 = phi i1 [ false, %432 ], [ %434, %435 ]
    br label %438
    
; <label>: %438
    br i1 %437, label %439, label %443
    
; <label>: %439
    %440 = load i1* %w4, align 4
    %441 = xor i1 %440, 1
    br label %442
    
; <label>: %442
    br label %443
    
; <label>: %443
    %444 = phi i1 [ false, %438 ], [ %441, %442 ]
    br i1 %444, label %445, label %450
    
; <label>: %445
    %446 = load i8** %str, align 8
    %447 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 15
    %448 = load i8** %447, align 8
    %449 = call i8* @$concat(i8* %446, i8* %448)
    store i8* %449, i8** %str, align 8
    br label %815
    
; <label>: %450
    %451 = load i1* %w1, align 4
    br label %452
    
; <label>: %452
    br i1 %451, label %453, label %456
    
; <label>: %453
    %454 = load i1* %w2, align 4
    br label %455
    
; <label>: %455
    br label %456
    
; <label>: %456
    %457 = phi i1 [ false, %452 ], [ %454, %455 ]
    br label %458
    
; <label>: %458
    br i1 %457, label %459, label %463
    
; <label>: %459
    %460 = load i1* %w3, align 4
    %461 = xor i1 %460, 1
    br label %462
    
; <label>: %462
    br label %463
    
; <label>: %463
    %464 = phi i1 [ false, %458 ], [ %461, %462 ]
    br label %465
    
; <label>: %465
    br i1 %464, label %466, label %469
    
; <label>: %466
    %467 = load i1* %w4, align 4
    br label %468
    
; <label>: %468
    br label %469
    
; <label>: %469
    %470 = phi i1 [ false, %465 ], [ %467, %468 ]
    br i1 %470, label %471, label %476
    
; <label>: %471
    %472 = load i8** %str, align 8
    %473 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 14
    %474 = load i8** %473, align 8
    %475 = call i8* @$concat(i8* %472, i8* %474)
    store i8* %475, i8** %str, align 8
    br label %814
    
; <label>: %476
    %477 = load i1* %w1, align 4
    br label %478
    
; <label>: %478
    br i1 %477, label %479, label %483
    
; <label>: %479
    %480 = load i1* %w2, align 4
    %481 = xor i1 %480, 1
    br label %482
    
; <label>: %482
    br label %483
    
; <label>: %483
    %484 = phi i1 [ false, %478 ], [ %481, %482 ]
    br label %485
    
; <label>: %485
    br i1 %484, label %486, label %489
    
; <label>: %486
    %487 = load i1* %w3, align 4
    br label %488
    
; <label>: %488
    br label %489
    
; <label>: %489
    %490 = phi i1 [ false, %485 ], [ %487, %488 ]
    br label %491
    
; <label>: %491
    br i1 %490, label %492, label %495
    
; <label>: %492
    %493 = load i1* %w4, align 4
    br label %494
    
; <label>: %494
    br label %495
    
; <label>: %495
    %496 = phi i1 [ false, %491 ], [ %493, %494 ]
    br i1 %496, label %497, label %502
    
; <label>: %497
    %498 = load i8** %str, align 8
    %499 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 13
    %500 = load i8** %499, align 8
    %501 = call i8* @$concat(i8* %498, i8* %500)
    store i8* %501, i8** %str, align 8
    br label %813
    
; <label>: %502
    %503 = load i1* %w1, align 4
    %504 = xor i1 %503, 1
    br label %505
    
; <label>: %505
    br i1 %504, label %506, label %509
    
; <label>: %506
    %507 = load i1* %w2, align 4
    br label %508
    
; <label>: %508
    br label %509
    
; <label>: %509
    %510 = phi i1 [ false, %505 ], [ %507, %508 ]
    br label %511
    
; <label>: %511
    br i1 %510, label %512, label %515
    
; <label>: %512
    %513 = load i1* %w3, align 4
    br label %514
    
; <label>: %514
    br label %515
    
; <label>: %515
    %516 = phi i1 [ false, %511 ], [ %513, %514 ]
    br label %517
    
; <label>: %517
    br i1 %516, label %518, label %521
    
; <label>: %518
    %519 = load i1* %w4, align 4
    br label %520
    
; <label>: %520
    br label %521
    
; <label>: %521
    %522 = phi i1 [ false, %517 ], [ %519, %520 ]
    br i1 %522, label %523, label %528
    
; <label>: %523
    %524 = load i8** %str, align 8
    %525 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 12
    %526 = load i8** %525, align 8
    %527 = call i8* @$concat(i8* %524, i8* %526)
    store i8* %527, i8** %str, align 8
    br label %812
    
; <label>: %528
    %529 = load i1* %w1, align 4
    br label %530
    
; <label>: %530
    br i1 %529, label %531, label %535
    
; <label>: %531
    %532 = load i1* %w2, align 4
    %533 = xor i1 %532, 1
    br label %534
    
; <label>: %534
    br label %535
    
; <label>: %535
    %536 = phi i1 [ false, %530 ], [ %533, %534 ]
    br label %537
    
; <label>: %537
    br i1 %536, label %538, label %541
    
; <label>: %538
    %539 = load i1* %w3, align 4
    br label %540
    
; <label>: %540
    br label %541
    
; <label>: %541
    %542 = phi i1 [ false, %537 ], [ %539, %540 ]
    br label %543
    
; <label>: %543
    br i1 %542, label %544, label %548
    
; <label>: %544
    %545 = load i1* %w4, align 4
    %546 = xor i1 %545, 1
    br label %547
    
; <label>: %547
    br label %548
    
; <label>: %548
    %549 = phi i1 [ false, %543 ], [ %546, %547 ]
    br i1 %549, label %550, label %555
    
; <label>: %550
    %551 = load i8** %str, align 8
    %552 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 9
    %553 = load i8** %552, align 8
    %554 = call i8* @$concat(i8* %551, i8* %553)
    store i8* %554, i8** %str, align 8
    br label %811
    
; <label>: %555
    %556 = load i1* %w1, align 4
    %557 = xor i1 %556, 1
    br label %558
    
; <label>: %558
    br i1 %557, label %559, label %562
    
; <label>: %559
    %560 = load i1* %w2, align 4
    br label %561
    
; <label>: %561
    br label %562
    
; <label>: %562
    %563 = phi i1 [ false, %558 ], [ %560, %561 ]
    br label %564
    
; <label>: %564
    br i1 %563, label %565, label %569
    
; <label>: %565
    %566 = load i1* %w3, align 4
    %567 = xor i1 %566, 1
    br label %568
    
; <label>: %568
    br label %569
    
; <label>: %569
    %570 = phi i1 [ false, %564 ], [ %567, %568 ]
    br label %571
    
; <label>: %571
    br i1 %570, label %572, label %575
    
; <label>: %572
    %573 = load i1* %w4, align 4
    br label %574
    
; <label>: %574
    br label %575
    
; <label>: %575
    %576 = phi i1 [ false, %571 ], [ %573, %574 ]
    br i1 %576, label %577, label %582
    
; <label>: %577
    %578 = load i8** %str, align 8
    %579 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %580 = load i8** %579, align 8
    %581 = call i8* @$concat(i8* %578, i8* %580)
    store i8* %581, i8** %str, align 8
    br label %810
    
; <label>: %582
    %583 = load i1* %w1, align 4
    br label %584
    
; <label>: %584
    br i1 %583, label %585, label %588
    
; <label>: %585
    %586 = load i1* %w2, align 4
    br label %587
    
; <label>: %587
    br label %588
    
; <label>: %588
    %589 = phi i1 [ false, %584 ], [ %586, %587 ]
    br label %590
    
; <label>: %590
    br i1 %589, label %591, label %595
    
; <label>: %591
    %592 = load i1* %w3, align 4
    %593 = xor i1 %592, 1
    br label %594
    
; <label>: %594
    br label %595
    
; <label>: %595
    %596 = phi i1 [ false, %590 ], [ %593, %594 ]
    br label %597
    
; <label>: %597
    br i1 %596, label %598, label %602
    
; <label>: %598
    %599 = load i1* %w4, align 4
    %600 = xor i1 %599, 1
    br label %601
    
; <label>: %601
    br label %602
    
; <label>: %602
    %603 = phi i1 [ false, %597 ], [ %600, %601 ]
    br i1 %603, label %604, label %609
    
; <label>: %604
    %605 = load i8** %str, align 8
    %606 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 16
    %607 = load i8** %606, align 8
    %608 = call i8* @$concat(i8* %605, i8* %607)
    store i8* %608, i8** %str, align 8
    br label %809
    
; <label>: %609
    %610 = load i1* %w1, align 4
    %611 = xor i1 %610, 1
    br label %612
    
; <label>: %612
    br i1 %611, label %613, label %616
    
; <label>: %613
    %614 = load i1* %w2, align 4
    br label %615
    
; <label>: %615
    br label %616
    
; <label>: %616
    %617 = phi i1 [ false, %612 ], [ %614, %615 ]
    br label %618
    
; <label>: %618
    br i1 %617, label %619, label %622
    
; <label>: %619
    %620 = load i1* %w3, align 4
    br label %621
    
; <label>: %621
    br label %622
    
; <label>: %622
    %623 = phi i1 [ false, %618 ], [ %620, %621 ]
    br label %624
    
; <label>: %624
    br i1 %623, label %625, label %629
    
; <label>: %625
    %626 = load i1* %w4, align 4
    %627 = xor i1 %626, 1
    br label %628
    
; <label>: %628
    br label %629
    
; <label>: %629
    %630 = phi i1 [ false, %624 ], [ %627, %628 ]
    br i1 %630, label %631, label %636
    
; <label>: %631
    %632 = load i8** %str, align 8
    %633 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 17
    %634 = load i8** %633, align 8
    %635 = call i8* @$concat(i8* %632, i8* %634)
    store i8* %635, i8** %str, align 8
    br label %808
    
; <label>: %636
    %637 = load i1* %w1, align 4
    %638 = xor i1 %637, 1
    br label %639
    
; <label>: %639
    br i1 %638, label %640, label %644
    
; <label>: %640
    %641 = load i1* %w2, align 4
    %642 = xor i1 %641, 1
    br label %643
    
; <label>: %643
    br label %644
    
; <label>: %644
    %645 = phi i1 [ false, %639 ], [ %642, %643 ]
    br label %646
    
; <label>: %646
    br i1 %645, label %647, label %650
    
; <label>: %647
    %648 = load i1* %w3, align 4
    br label %649
    
; <label>: %649
    br label %650
    
; <label>: %650
    %651 = phi i1 [ false, %646 ], [ %648, %649 ]
    br label %652
    
; <label>: %652
    br i1 %651, label %653, label %656
    
; <label>: %653
    %654 = load i1* %w4, align 4
    br label %655
    
; <label>: %655
    br label %656
    
; <label>: %656
    %657 = phi i1 [ false, %652 ], [ %654, %655 ]
    br i1 %657, label %658, label %663
    
; <label>: %658
    %659 = load i8** %str, align 8
    %660 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 18
    %661 = load i8** %660, align 8
    %662 = call i8* @$concat(i8* %659, i8* %661)
    store i8* %662, i8** %str, align 8
    br label %807
    
; <label>: %663
    %664 = load i1* %w1, align 4
    br label %665
    
; <label>: %665
    br i1 %664, label %666, label %670
    
; <label>: %666
    %667 = load i1* %w2, align 4
    %668 = xor i1 %667, 1
    br label %669
    
; <label>: %669
    br label %670
    
; <label>: %670
    %671 = phi i1 [ false, %665 ], [ %668, %669 ]
    br label %672
    
; <label>: %672
    br i1 %671, label %673, label %677
    
; <label>: %673
    %674 = load i1* %w3, align 4
    %675 = xor i1 %674, 1
    br label %676
    
; <label>: %676
    br label %677
    
; <label>: %677
    %678 = phi i1 [ false, %672 ], [ %675, %676 ]
    br label %679
    
; <label>: %679
    br i1 %678, label %680, label %683
    
; <label>: %680
    %681 = load i1* %w4, align 4
    br label %682
    
; <label>: %682
    br label %683
    
; <label>: %683
    %684 = phi i1 [ false, %679 ], [ %681, %682 ]
    br i1 %684, label %685, label %690
    
; <label>: %685
    %686 = load i8** %str, align 8
    %687 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 19
    %688 = load i8** %687, align 8
    %689 = call i8* @$concat(i8* %686, i8* %688)
    store i8* %689, i8** %str, align 8
    br label %806
    
; <label>: %690
    %691 = load i1* %w1, align 4
    br label %692
    
; <label>: %692
    br i1 %691, label %693, label %697
    
; <label>: %693
    %694 = load i1* %w2, align 4
    %695 = xor i1 %694, 1
    br label %696
    
; <label>: %696
    br label %697
    
; <label>: %697
    %698 = phi i1 [ false, %692 ], [ %695, %696 ]
    br label %699
    
; <label>: %699
    br i1 %698, label %700, label %704
    
; <label>: %700
    %701 = load i1* %w3, align 4
    %702 = xor i1 %701, 1
    br label %703
    
; <label>: %703
    br label %704
    
; <label>: %704
    %705 = phi i1 [ false, %699 ], [ %702, %703 ]
    br label %706
    
; <label>: %706
    br i1 %705, label %707, label %711
    
; <label>: %707
    %708 = load i1* %w4, align 4
    %709 = xor i1 %708, 1
    br label %710
    
; <label>: %710
    br label %711
    
; <label>: %711
    %712 = phi i1 [ false, %706 ], [ %709, %710 ]
    br i1 %712, label %713, label %718
    
; <label>: %713
    %714 = load i8** %str, align 8
    %715 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 22
    %716 = load i8** %715, align 8
    %717 = call i8* @$concat(i8* %714, i8* %716)
    store i8* %717, i8** %str, align 8
    br label %805
    
; <label>: %718
    %719 = load i1* %w1, align 4
    %720 = xor i1 %719, 1
    br label %721
    
; <label>: %721
    br i1 %720, label %722, label %725
    
; <label>: %722
    %723 = load i1* %w2, align 4
    br label %724
    
; <label>: %724
    br label %725
    
; <label>: %725
    %726 = phi i1 [ false, %721 ], [ %723, %724 ]
    br label %727
    
; <label>: %727
    br i1 %726, label %728, label %732
    
; <label>: %728
    %729 = load i1* %w3, align 4
    %730 = xor i1 %729, 1
    br label %731
    
; <label>: %731
    br label %732
    
; <label>: %732
    %733 = phi i1 [ false, %727 ], [ %730, %731 ]
    br label %734
    
; <label>: %734
    br i1 %733, label %735, label %739
    
; <label>: %735
    %736 = load i1* %w4, align 4
    %737 = xor i1 %736, 1
    br label %738
    
; <label>: %738
    br label %739
    
; <label>: %739
    %740 = phi i1 [ false, %734 ], [ %737, %738 ]
    br i1 %740, label %741, label %746
    
; <label>: %741
    %742 = load i8** %str, align 8
    %743 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 23
    %744 = load i8** %743, align 8
    %745 = call i8* @$concat(i8* %742, i8* %744)
    store i8* %745, i8** %str, align 8
    br label %804
    
; <label>: %746
    %747 = load i1* %w1, align 4
    %748 = xor i1 %747, 1
    br label %749
    
; <label>: %749
    br i1 %748, label %750, label %754
    
; <label>: %750
    %751 = load i1* %w2, align 4
    %752 = xor i1 %751, 1
    br label %753
    
; <label>: %753
    br label %754
    
; <label>: %754
    %755 = phi i1 [ false, %749 ], [ %752, %753 ]
    br label %756
    
; <label>: %756
    br i1 %755, label %757, label %760
    
; <label>: %757
    %758 = load i1* %w3, align 4
    br label %759
    
; <label>: %759
    br label %760
    
; <label>: %760
    %761 = phi i1 [ false, %756 ], [ %758, %759 ]
    br label %762
    
; <label>: %762
    br i1 %761, label %763, label %767
    
; <label>: %763
    %764 = load i1* %w4, align 4
    %765 = xor i1 %764, 1
    br label %766
    
; <label>: %766
    br label %767
    
; <label>: %767
    %768 = phi i1 [ false, %762 ], [ %765, %766 ]
    br i1 %768, label %769, label %774
    
; <label>: %769
    %770 = load i8** %str, align 8
    %771 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 20
    %772 = load i8** %771, align 8
    %773 = call i8* @$concat(i8* %770, i8* %772)
    store i8* %773, i8** %str, align 8
    br label %803
    
; <label>: %774
    %775 = load i1* %w1, align 4
    %776 = xor i1 %775, 1
    br label %777
    
; <label>: %777
    br i1 %776, label %778, label %782
    
; <label>: %778
    %779 = load i1* %w2, align 4
    %780 = xor i1 %779, 1
    br label %781
    
; <label>: %781
    br label %782
    
; <label>: %782
    %783 = phi i1 [ false, %777 ], [ %780, %781 ]
    br label %784
    
; <label>: %784
    br i1 %783, label %785, label %789
    
; <label>: %785
    %786 = load i1* %w3, align 4
    %787 = xor i1 %786, 1
    br label %788
    
; <label>: %788
    br label %789
    
; <label>: %789
    %790 = phi i1 [ false, %784 ], [ %787, %788 ]
    br label %791
    
; <label>: %791
    br i1 %790, label %792, label %795
    
; <label>: %792
    %793 = load i1* %w4, align 4
    br label %794
    
; <label>: %794
    br label %795
    
; <label>: %795
    %796 = phi i1 [ false, %791 ], [ %793, %794 ]
    br i1 %796, label %797, label %802
    
; <label>: %797
    %798 = load i8** %str, align 8
    %799 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 21
    %800 = load i8** %799, align 8
    %801 = call i8* @$concat(i8* %798, i8* %800)
    store i8* %801, i8** %str, align 8
    br label %802
    
; <label>: %802
    br label %803
    
; <label>: %803
    br label %804
    
; <label>: %804
    br label %805
    
; <label>: %805
    br label %806
    
; <label>: %806
    br label %807
    
; <label>: %807
    br label %808
    
; <label>: %808
    br label %809
    
; <label>: %809
    br label %810
    
; <label>: %810
    br label %811
    
; <label>: %811
    br label %812
    
; <label>: %812
    br label %813
    
; <label>: %813
    br label %814
    
; <label>: %814
    br label %815
    
; <label>: %815
    br label %816
    
; <label>: %816
    br label %850
    
; <label>: %817
    %818 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %819 = load %struct.$IntArray** %818, align 8
    %820 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %820, align 8
    %821 = load %struct.MazeArray** %820, align 8
    %822 = alloca i1, align 4
    store i1 true, i1* %822, align 4
    %823 = load i1* %822, align 4
    %824 = load i32* %i, align 4
    %825 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %826 = load i32* %825, align 4
    %827 = alloca i32, align 4
    store i32 1, i32* %827, align 4
    %828 = load i32* %827, align 4
    %829 = sub nsw i32 %826, %828
    %830 = getelementptr inbounds %struct.MazeArray* %821, i32 0, i32 0
    %831 = load %struct.MazeArray$vtable** %830, align 8
    %832 = getelementptr inbounds %struct.MazeArray$vtable* %831, i32 0, i32 7
    %833 = load i32 (%struct.MazeArray*, i1, i32, i32)** %832, align 8
    %834 = call i32 %833(%struct.MazeArray* %821, i1 %823, i32 %824, i32 %829)
    %835 = call i32 @$IntArray_Read(%struct.$IntArray* %819, i32 %834)
    %836 = alloca i32, align 4
    store i32 1, i32* %836, align 4
    %837 = load i32* %836, align 4
    %838 = icmp eq  i32 %835, %837
    br i1 %838, label %839, label %844
    
; <label>: %839
    %840 = load i8** %str, align 8
    %841 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 13
    %842 = load i8** %841, align 8
    %843 = call i8* @$concat(i8* %840, i8* %842)
    store i8* %843, i8** %str, align 8
    br label %849
    
; <label>: %844
    %845 = load i8** %str, align 8
    %846 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 9
    %847 = load i8** %846, align 8
    %848 = call i8* @$concat(i8* %845, i8* %847)
    store i8* %848, i8** %str, align 8
    br label %849
    
; <label>: %849
    br label %850
    
; <label>: %850
    %851 = load i32* %j, align 4
    %852 = alloca i32, align 4
    store i32 1, i32* %852, align 4
    %853 = load i32* %852, align 4
    %854 = add nsw i32 %851, %853
    store i32 %854, i32* %j, align 4
    br label %279
    
; <label>: %855
    %856 = load i8** %str, align 8
    %857 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %856)
    br label %858
    
; <label>: %858
    %859 = load i32* %i, align 4
    %860 = alloca i32, align 4
    store i32 1, i32* %860, align 4
    %861 = load i32* %860, align 4
    %862 = add nsw i32 %859, %861
    store i32 %862, i32* %i, align 4
    br label %96
    
; <label>: %863
    %864 = alloca i32, align 4
    store i32 0, i32* %864, align 4
    %865 = load i32* %864, align 4
    store i32 %865, i32* %i, align 4
    %866 = alloca i8*, align 8
    store i8* getelementptr inbounds ([4 x i8]* @.str36, i32 0, i32 0), i8** %866, align 8
    %867 = load i8** %866, align 8
    %868 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 16
    %869 = load i8** %868, align 8
    %870 = call i8* @$concat(i8* %867, i8* %869)
    store i8* %870, i8** %str, align 8
    br label %871
    
; <label>: %871
    %872 = load i32* %i, align 4
    %873 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %874 = load i32* %873, align 4
    %875 = icmp slt i32 %872, %874
    br i1 %875, label %876, label %937
    
; <label>: %876
    %877 = load i8** %str, align 8
    %878 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %879 = load i8** %878, align 8
    %880 = call i8* @$concat(i8* %877, i8* %879)
    %881 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %882 = load i8** %881, align 8
    %883 = call i8* @$concat(i8* %880, i8* %882)
    %884 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %885 = load i8** %884, align 8
    %886 = call i8* @$concat(i8* %883, i8* %885)
    store i8* %886, i8** %str, align 8
    %887 = load i32* %i, align 4
    %888 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %889 = load i32* %888, align 4
    %890 = alloca i32, align 4
    store i32 1, i32* %890, align 4
    %891 = load i32* %890, align 4
    %892 = sub nsw i32 %889, %891
    %893 = icmp eq  i32 %887, %892
    br i1 %893, label %894, label %899
    
; <label>: %894
    %895 = load i8** %str, align 8
    %896 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 19
    %897 = load i8** %896, align 8
    %898 = call i8* @$concat(i8* %895, i8* %897)
    store i8* %898, i8** %str, align 8
    br label %932
    
; <label>: %899
    %900 = alloca i32, align 4
    store i32 0, i32* %900, align 4
    %901 = load i32* %900, align 4
    %902 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 3
    %903 = load %struct.$IntArray** %902, align 8
    %904 = alloca %struct.MazeArray*, align 8
    store %struct.MazeArray* %this, %struct.MazeArray** %904, align 8
    %905 = load %struct.MazeArray** %904, align 8
    %906 = alloca i1, align 4
    store i1 false, i1* %906, align 4
    %907 = load i1* %906, align 4
    %908 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 1
    %909 = load i32* %908, align 4
    %910 = alloca i32, align 4
    store i32 1, i32* %910, align 4
    %911 = load i32* %910, align 4
    %912 = sub nsw i32 %909, %911
    %913 = load i32* %i, align 4
    %914 = getelementptr inbounds %struct.MazeArray* %905, i32 0, i32 0
    %915 = load %struct.MazeArray$vtable** %914, align 8
    %916 = getelementptr inbounds %struct.MazeArray$vtable* %915, i32 0, i32 7
    %917 = load i32 (%struct.MazeArray*, i1, i32, i32)** %916, align 8
    %918 = call i32 %917(%struct.MazeArray* %905, i1 %907, i32 %912, i32 %913)
    %919 = call i32 @$IntArray_Read(%struct.$IntArray* %903, i32 %918)
    %920 = icmp slt i32 %901, %919
    br i1 %920, label %921, label %926
    
; <label>: %921
    %922 = load i8** %str, align 8
    %923 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 14
    %924 = load i8** %923, align 8
    %925 = call i8* @$concat(i8* %922, i8* %924)
    store i8* %925, i8** %str, align 8
    br label %931
    
; <label>: %926
    %927 = load i8** %str, align 8
    %928 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 10
    %929 = load i8** %928, align 8
    %930 = call i8* @$concat(i8* %927, i8* %929)
    store i8* %930, i8** %str, align 8
    br label %931
    
; <label>: %931
    br label %932
    
; <label>: %932
    %933 = load i32* %i, align 4
    %934 = alloca i32, align 4
    store i32 1, i32* %934, align 4
    %935 = load i32* %934, align 4
    %936 = add nsw i32 %933, %935
    store i32 %936, i32* %i, align 4
    br label %871
    
; <label>: %937
    %938 = load i8** %str, align 8
    %939 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %938)
    %940 = alloca i8*, align 8
    store i8* getelementptr inbounds ([15 x i8]* @.str37, i32 0, i32 0), i8** %940, align 8
    %941 = load i8** %940, align 8
    ret i8* %941
}

define %struct.$IntArray* @MazeArray$shuffleArray(%struct.MazeArray* %this, %struct.$IntArray* %_arr) nounwind ssp {
    %arr = alloca %struct.$IntArray*, align 8
    store %struct.$IntArray* %_arr, %struct.$IntArray** %arr, align 8
    %newarr = alloca %struct.$IntArray*, align 8
    %i = alloca i32, align 4
    %j = alloca i32, align 4
    %1 = load %struct.$IntArray** %arr, align 8
    %2 = call i32 @$IntArray_Length(%struct.$IntArray* %1)
    %3 = call %struct.$IntArray* @$new_$IntArray(i32 %2)
    store %struct.$IntArray* %3, %struct.$IntArray** %newarr, align 8
    %4 = alloca i32, align 4
    store i32 0, i32* %4, align 4
    %5 = load i32* %4, align 4
    store i32 %5, i32* %i, align 4
    br label %6
    
; <label>: %6
    %7 = load i32* %i, align 4
    %8 = load %struct.$IntArray** %newarr, align 8
    %9 = call i32 @$IntArray_Length(%struct.$IntArray* %8)
    %10 = icmp slt i32 %7, %9
    br i1 %10, label %11, label %24
    
; <label>: %11
    %12 = load i32* %i, align 4
    %13 = alloca i32, align 4
    store i32 0, i32* %13, align 4
    %14 = load i32* %13, align 4
    %15 = alloca i32, align 4
    store i32 1, i32* %15, align 4
    %16 = load i32* %15, align 4
    %17 = sub nsw i32 %14, %16
    %18 = load %struct.$IntArray** %newarr, align 8
    %19 = call %struct.$IntArray* @$IntArray_Assign(%struct.$IntArray* %18, i32 %12, i32 %17)
    %20 = load i32* %i, align 4
    %21 = alloca i32, align 4
    store i32 1, i32* %21, align 4
    %22 = load i32* %21, align 4
    %23 = add nsw i32 %20, %22
    store i32 %23, i32* %i, align 4
    br label %6
    
; <label>: %24
    %25 = alloca i32, align 4
    store i32 0, i32* %25, align 4
    %26 = load i32* %25, align 4
    store i32 %26, i32* %i, align 4
    br label %27
    
; <label>: %27
    %28 = load i32* %i, align 4
    %29 = load %struct.$IntArray** %arr, align 8
    %30 = call i32 @$IntArray_Length(%struct.$IntArray* %29)
    %31 = icmp slt i32 %28, %30
    br i1 %31, label %32, label %79
    
; <label>: %32
    %33 = getelementptr inbounds %struct.MazeArray* %this, i32 0, i32 2
    %34 = load %struct.PseudoRandomNumberGenerator** %33, align 8
    %35 = alloca i32, align 4
    store i32 0, i32* %35, align 4
    %36 = load i32* %35, align 4
    %37 = load %struct.$IntArray** %arr, align 8
    %38 = call i32 @$IntArray_Length(%struct.$IntArray* %37)
    %39 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %34, i32 0, i32 0
    %40 = load %struct.PseudoRandomNumberGenerator$vtable** %39, align 8
    %41 = getelementptr inbounds %struct.PseudoRandomNumberGenerator$vtable* %40, i32 0, i32 1
    %42 = load i32 (%struct.PseudoRandomNumberGenerator*, i32, i32)** %41, align 8
    %43 = call i32 %42(%struct.PseudoRandomNumberGenerator* %34, i32 %36, i32 %38)
    store i32 %43, i32* %j, align 4
    br label %44
    
; <label>: %44
    %45 = load %struct.$IntArray** %newarr, align 8
    %46 = load i32* %j, align 4
    %47 = call i32 @$IntArray_Read(%struct.$IntArray* %45, i32 %46)
    %48 = alloca i32, align 4
    store i32 0, i32* %48, align 4
    %49 = load i32* %48, align 4
    %50 = alloca i32, align 4
    store i32 1, i32* %50, align 4
    %51 = load i32* %50, align 4
    %52 = sub nsw i32 %49, %51
    %53 = icmp eq  i32 %47, %52
    %54 = xor i1 %53, 1
    br i1 %54, label %55, label %68
    
; <label>: %55
    %56 = load i32* %j, align 4
    %57 = alloca i32, align 4
    store i32 1, i32* %57, align 4
    %58 = load i32* %57, align 4
    %59 = add nsw i32 %56, %58
    store i32 %59, i32* %j, align 4
    %60 = load i32* %j, align 4
    %61 = load %struct.$IntArray** %newarr, align 8
    %62 = call i32 @$IntArray_Length(%struct.$IntArray* %61)
    %63 = icmp eq  i32 %60, %62
    br i1 %63, label %64, label %67
    
; <label>: %64
    %65 = alloca i32, align 4
    store i32 0, i32* %65, align 4
    %66 = load i32* %65, align 4
    store i32 %66, i32* %j, align 4
    br label %67
    
; <label>: %67
    br label %44
    
; <label>: %68
    %69 = load i32* %j, align 4
    %70 = load %struct.$IntArray** %arr, align 8
    %71 = load i32* %i, align 4
    %72 = call i32 @$IntArray_Read(%struct.$IntArray* %70, i32 %71)
    %73 = load %struct.$IntArray** %newarr, align 8
    %74 = call %struct.$IntArray* @$IntArray_Assign(%struct.$IntArray* %73, i32 %69, i32 %72)
    %75 = load i32* %i, align 4
    %76 = alloca i32, align 4
    store i32 1, i32* %76, align 4
    %77 = load i32* %76, align 4
    %78 = add nsw i32 %75, %77
    store i32 %78, i32* %i, align 4
    br label %27
    
; <label>: %79
    %80 = load %struct.$IntArray** %newarr, align 8
    ret %struct.$IntArray* %80
}


define %struct.PseudoRandomNumberGenerator* @new$PseudoRandomNumberGenerator() nounwind ssp {
    %obj = alloca %struct.PseudoRandomNumberGenerator*, align 8
    %1 = call i8* @_mymalloc(i64 16)
    %2 = bitcast i8* %1 to %struct.PseudoRandomNumberGenerator*
    store %struct.PseudoRandomNumberGenerator* %2, %struct.PseudoRandomNumberGenerator** %obj, align 8
    %3 = load %struct.PseudoRandomNumberGenerator** %obj, align 8
    %4 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %3, i32 0, i32 0
    store %struct.PseudoRandomNumberGenerator$vtable* @PseudoRandomNumberGenerator$vtable, %struct.PseudoRandomNumberGenerator$vtable** %4, align 8
    %5 = load %struct.PseudoRandomNumberGenerator** %obj, align 8
    ret %struct.PseudoRandomNumberGenerator* %5
}

define %struct.PseudoRandomNumberGenerator* @PseudoRandomNumberGenerator$init(%struct.PseudoRandomNumberGenerator* %this) nounwind ssp {
    
    %1 = alloca i32, align 4
    store i32 12345, i32* %1, align 4
    %2 = load i32* %1, align 4
    %3 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %this, i32 0, i32 1
    store i32 %2, i32* %3, align 4
    %4 = alloca i32, align 4
    store i32 67890, i32* %4, align 4
    %5 = load i32* %4, align 4
    %6 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %this, i32 0, i32 2
    store i32 %5, i32* %6, align 4
    %7 = alloca %struct.PseudoRandomNumberGenerator*, align 8
    store %struct.PseudoRandomNumberGenerator* %this, %struct.PseudoRandomNumberGenerator** %7, align 8
    %8 = load %struct.PseudoRandomNumberGenerator** %7, align 8
    ret %struct.PseudoRandomNumberGenerator* %8
}

define i32 @PseudoRandomNumberGenerator$getInt(%struct.PseudoRandomNumberGenerator* %this, i32 %_min, i32 %_max) nounwind ssp {
    %min = alloca i32, align 4
    store i32 %_min, i32* %min, align 4
    %max = alloca i32, align 4
    store i32 %_max, i32* %max, align 4
    %posInt = alloca i32, align 4
    %1 = alloca %struct.PseudoRandomNumberGenerator*, align 8
    store %struct.PseudoRandomNumberGenerator* %this, %struct.PseudoRandomNumberGenerator** %1, align 8
    %2 = load %struct.PseudoRandomNumberGenerator** %1, align 8
    %3 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %2, i32 0, i32 0
    %4 = load %struct.PseudoRandomNumberGenerator$vtable** %3, align 8
    %5 = getelementptr inbounds %struct.PseudoRandomNumberGenerator$vtable* %4, i32 0, i32 3
    %6 = load i32 (%struct.PseudoRandomNumberGenerator*)** %5, align 8
    %7 = call i32 %6(%struct.PseudoRandomNumberGenerator* %2)
    store i32 %7, i32* %posInt, align 4
    %8 = load i32* %posInt, align 4
    %9 = alloca i32, align 4
    store i32 0, i32* %9, align 4
    %10 = load i32* %9, align 4
    %11 = icmp slt i32 %8, %10
    br i1 %11, label %12, label %17
    
; <label>: %12
    %13 = alloca i32, align 4
    store i32 0, i32* %13, align 4
    %14 = load i32* %13, align 4
    %15 = load i32* %posInt, align 4
    %16 = sub nsw i32 %14, %15
    store i32 %16, i32* %posInt, align 4
    br label %17
    
; <label>: %17
    %18 = load i32* %min, align 4
    %19 = alloca %struct.PseudoRandomNumberGenerator*, align 8
    store %struct.PseudoRandomNumberGenerator* %this, %struct.PseudoRandomNumberGenerator** %19, align 8
    %20 = load %struct.PseudoRandomNumberGenerator** %19, align 8
    %21 = load i32* %posInt, align 4
    %22 = load i32* %max, align 4
    %23 = load i32* %min, align 4
    %24 = sub nsw i32 %22, %23
    %25 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %20, i32 0, i32 0
    %26 = load %struct.PseudoRandomNumberGenerator$vtable** %25, align 8
    %27 = getelementptr inbounds %struct.PseudoRandomNumberGenerator$vtable* %26, i32 0, i32 2
    %28 = load i32 (%struct.PseudoRandomNumberGenerator*, i32, i32)** %27, align 8
    %29 = call i32 %28(%struct.PseudoRandomNumberGenerator* %20, i32 %21, i32 %24)
    %30 = add nsw i32 %18, %29
    ret i32 %30
}

define i32 @PseudoRandomNumberGenerator$mod(%struct.PseudoRandomNumberGenerator* %this, i32 %_i, i32 %_j) nounwind ssp {
    %i = alloca i32, align 4
    store i32 %_i, i32* %i, align 4
    %j = alloca i32, align 4
    store i32 %_j, i32* %j, align 4
    
    
    %1 = load i32* %i, align 4
    %2 = load i32* %i, align 4
    %3 = load i32* %j, align 4
    %4 = sdiv i32 %2, %3
    %5 = load i32* %j, align 4
    %6 = mul nsw i32 %4, %5
    %7 = sub nsw i32 %1, %6
    ret i32 %7
}

define i32 @PseudoRandomNumberGenerator$nextInt(%struct.PseudoRandomNumberGenerator* %this) nounwind ssp {
    
    %1 = alloca i32, align 4
    store i32 36969, i32* %1, align 4
    %2 = load i32* %1, align 4
    %3 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %this, i32 0, i32 2
    %4 = load i32* %3, align 4
    %5 = alloca i32, align 4
    store i32 65536, i32* %5, align 4
    %6 = load i32* %5, align 4
    %7 = mul nsw i32 %4, %6
    %8 = alloca i32, align 4
    store i32 65536, i32* %8, align 4
    %9 = load i32* %8, align 4
    %10 = sdiv i32 %7, %9
    %11 = mul nsw i32 %2, %10
    %12 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %this, i32 0, i32 2
    %13 = load i32* %12, align 4
    %14 = alloca i32, align 4
    store i32 65536, i32* %14, align 4
    %15 = load i32* %14, align 4
    %16 = sdiv i32 %13, %15
    %17 = add nsw i32 %11, %16
    %18 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %this, i32 0, i32 2
    store i32 %17, i32* %18, align 4
    %19 = alloca i32, align 4
    store i32 18000, i32* %19, align 4
    %20 = load i32* %19, align 4
    %21 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %this, i32 0, i32 1
    %22 = load i32* %21, align 4
    %23 = alloca i32, align 4
    store i32 65536, i32* %23, align 4
    %24 = load i32* %23, align 4
    %25 = mul nsw i32 %22, %24
    %26 = alloca i32, align 4
    store i32 65536, i32* %26, align 4
    %27 = load i32* %26, align 4
    %28 = sdiv i32 %25, %27
    %29 = mul nsw i32 %20, %28
    %30 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %this, i32 0, i32 1
    %31 = load i32* %30, align 4
    %32 = alloca i32, align 4
    store i32 65536, i32* %32, align 4
    %33 = load i32* %32, align 4
    %34 = sdiv i32 %31, %33
    %35 = add nsw i32 %29, %34
    %36 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %this, i32 0, i32 1
    store i32 %35, i32* %36, align 4
    %37 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %this, i32 0, i32 2
    %38 = load i32* %37, align 4
    %39 = alloca i32, align 4
    store i32 65536, i32* %39, align 4
    %40 = load i32* %39, align 4
    %41 = mul nsw i32 %38, %40
    %42 = getelementptr inbounds %struct.PseudoRandomNumberGenerator* %this, i32 0, i32 1
    %43 = load i32* %42, align 4
    %44 = add nsw i32 %41, %43
    ret i32 %44
}

define i32 @main() nounwind ssp {
    %1 = call %struct.MazeArray* @new$MazeArray()
    %2 = alloca i32, align 4
    store i32 20, i32* %2, align 4
    %3 = load i32* %2, align 4
    %4 = getelementptr inbounds %struct.MazeArray* %1, i32 0, i32 0
    %5 = load %struct.MazeArray$vtable** %4, align 8
    %6 = getelementptr inbounds %struct.MazeArray$vtable* %5, i32 0, i32 0
    %7 = load %struct.MazeArray* (%struct.MazeArray*, i32)** %6, align 8
    %8 = call %struct.MazeArray* %7(%struct.MazeArray* %1, i32 %3)
    %9 = getelementptr inbounds %struct.MazeArray* %8, i32 0, i32 0
    %10 = load %struct.MazeArray$vtable** %9, align 8
    %11 = getelementptr inbounds %struct.MazeArray$vtable* %10, i32 0, i32 13
    %12 = load i8* (%struct.MazeArray*)** %11, align 8
    %13 = call i8* %12(%struct.MazeArray* %8)
    %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* %13)
    %15 = load %struct._List** @l, align 8
    call void @_List_free(%struct._List* %15)
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