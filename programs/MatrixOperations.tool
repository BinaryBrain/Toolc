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
	
	def plus(m: Matrix): Matrix = {
		var i: Int;
		var j: Int;
		var res: Matrix;
		var value: Int;
		
		res = new Matrix().init(nbRows, nbCols);
		while(i < nbRows) {
			while(j < nbCols) {
				value = this.at(i,j) + m.at(i,j);
				res = res.setAt(i,j, value);
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