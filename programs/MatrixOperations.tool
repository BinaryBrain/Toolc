/*
	Matrix implementation with some operations
	author: Andy Roulin
*/

object MatrixOperations {
	def main(): Unit = {
		println(new Test().launch());
	}
}

class Test {
	def launch(): Bool = {
		var matrix1: Matrix;
		var matrix2: Matrix;
		matrix1 = this.createMatrix1();
		println("m1: " + matrix1.toString());
		matrix2 = this.createMatrix2();
		println("m2: " + matrix2.toString());
		println("m1 + m1 = " + matrix1.plus(matrix1).toString());
		println("m1 * m2 = " + matrix1.times(matrix2).toString());
		return true;
	}
	
	def createMatrix1(): Matrix = {
		var matrix: Matrix;
		var i: Int;
		var j: Int;
		var k: Int;
		matrix = new Matrix().init(2,4);
		i = 0;
		j = 0;
		k = 1;
		while(i < 2) {
			j = 0;
			while(j < 4) {
				matrix = matrix.setAt(i,j, k);
				j = j + 1;
				k = k + 1;
			}
			i = i + 1;
		}
		
		return matrix;
	}
	
	def createMatrix2(): Matrix = {
		var matrix: Matrix;
		var i: Int;
		var j: Int;
		var k: Int;
		matrix = new Matrix().init(4,3);
		i = 0;
		j = 0;
		k = 4;
		while(i < 4) {
			j = 0;
			while(j < 3) {
				matrix = matrix.setAt(i,j, k);
				j = j + 1;
				k = k + 1;
			}
			i = i + 1;
		}
		
		return matrix;
	}
}

class Matrix {
	var array: Int[];
	var nbRows: Int;
	var nbCols: Int;
	
	def init(row: Int, col: Int): Matrix = {
		array = new Int[row*col];
		nbRows = row;
		nbCols = col;
		return this;
	}
	
	def getNbRows(): Int = {
		return nbRows;
	}
	
	def getNbCols(): Int = {
		return nbCols;
	}
	
	def at(row:Int, col:Int): Int = {
		var index: Int;
		index = row*nbCols + col;
		return array[index];
	}
	
	def setAt(row:Int, col:Int, value:Int): Matrix = {
		array[row*nbCols + col] = value;
		return this;
	}
	
	def plus(mat: Matrix): Matrix = {
		var res: Matrix;
		var i: Int;
		var j: Int;
		
		res = new Matrix().init(nbRows, nbCols);
		i = 0;
		while(i < nbRows) {
			j = 0;
			while(j < nbCols) {
				res = res.setAt(i,j, this.at(i,j) + mat.at(i,j));
				j = j + 1;
			}
			i = i + 1;
		}
		
		return res;
	}
	
	def times(mat: Matrix): Matrix = {
		var res: Matrix;
		var i: Int;
		var j: Int;
		var k: Int;
		var sum: Int;
		
		res = new Matrix().init(nbRows, mat.getNbCols());
		i = 0;
		while(i < nbRows) {
			j = 0;
			while(j < mat.getNbCols()) {
				k = 0;
				sum = 0;
				while(k < nbCols) {
					sum = sum + this.at(i,k) * mat.at(k,j);
					k = k + 1;
				}
				res = res.setAt(i,j, sum);
				j = j + 1;
			}
			i = i + 1;
		}
		
		return res;
	}
	
	def toString(): String = {
		var row: Int;
		var col: Int;
		var str: String;
		row = 0;
		col = 0;
		str = "{";
		
		while(row < nbRows) {
			col = 0;
			str = str + "{";
			while(col < nbCols) {
				str = str + this.at(row, col);
				col = col + 1;
				if(col < nbCols) {
					str = str + ", ";
				}
			}
			str = str + "}";
			row = row + 1;
			if (row < nbRows) {
				str = str + ", ";
			}
		}
		str = str + "}";
		return str;
	}
}