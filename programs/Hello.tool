object Hello {
	def main(): Unit = {
		println(new Test().toString());
	}
}

class Test {
	def toString(): String = {
		var dummy: String;
		dummy = this.toString();
		return "Hello";
	}
}
