object OO {
	def main ( ) : Unit = {
		 println(new Animal().sayHello());
		 println(new Animal().say("Bye!"));
		 println(new Animal().say("Your Name"));
	} 
}

class Animal {
	
	def sayYourName(): String = {
		return "0";
	}
	
	def sayHello(): String = {
		return "Hello!";
	}
	
	def say(thing: String): String = {
		return thing;
	}
}