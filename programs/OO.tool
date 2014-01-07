object OO {
	def main ( ) : Unit = {
		println(new A().fa());
		println(new B().fa());
		println(new C().fc());
	} 
}

class A {
	var a: Int;
	def fa(): Int = {
		return a;
	}
}

class B extends A {
	var b: Int;
	def fb(): Int = {
		return b;
	}
}

class C extends B {
	var c: Int;
	def fa(): Int = {
		return a;
	}
	def fc(): Int = {
		c = a;
		return c;
	}
}
