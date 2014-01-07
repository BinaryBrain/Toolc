object HelloWorld {
    def main(): Unit = {
    	println(new Animal().say(3));
    }
}

class Animal {
	def say(a: Int): Bool = {
		var i: Int;
		i = 0;
		while(i < a) {
			println(i);
			i = i + 1;
		}
		
		return true;
	}
}
