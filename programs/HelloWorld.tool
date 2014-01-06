object HelloWorld {
    def main(): Unit = {
    	println(new Animal().say(3));
    }
}

class Animal {
	def say(a: Int): Int = {
		return a;
	}
}
