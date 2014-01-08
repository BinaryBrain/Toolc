object ArraysTest {
	def main(): Unit = {
		println(new Test().run());
	}
}

class Test {
	var array: Int[];
	def run(): Bool = {
		var size : Int;
		var t: Test;
		
		size = 3;
		array = new Int[size];
		array[0] = 4;
		array[1] = 5;
		array[2] = 6;
		
		println(array[0]);
		println(array[1]);
		println(array[2]);
		println(array.length);
		
		t = new Test();
		println(this.otherTest(t));
		
		return true;
	}
	
	def otherTest(t: Test): Bool = {
		return true;
	}
}