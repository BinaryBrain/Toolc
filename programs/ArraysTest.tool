object ArraysTest {
	def main(): Unit = {
		println(new Test().run());
	}
}

class Test {
	var array: Int[];
	def run(): Bool = {
		var size : Int;
		var alias: Int[];
		var t: Test;
		
		size = 3;
		array = new Int[size];
		array[0] = 4;
		array[1] = 5;
		array[2] = 6;
		
		alias = array;
		
		println(alias[0]);
		println(alias[1]);
		println(alias[2]);
		println(alias.length);
		
		t = new Test();
		
		return false && this.otherTest();
	}
	
	def otherTest(t: Test): Bool = {
		println("Hello");
		return true;
	}
}