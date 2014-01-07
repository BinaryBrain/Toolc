object OO {
	def main ( ) : Unit = {
		 println(new Animal().sayHello());
		 println(new Animal().say("Bye!"));
		 println(new Animal().init("Minou", 13).sayYourName());
		 println(new Animal().init("Minet", 7).sayYourAge());
	} 
}

class Animal {
	var name: String;
	var age: Int;
	
	def init(n: String, a: Int): Animal = {
		name = n;
		age = a;
		return this;
	}
	
	def sayYourName(): String = {
		return name;
	}
	
	def sayHello(): String = {
		return "Hello!";
	}
	
	def say(thing: String): String = {
		return thing;
	}
	
	def sayYourAge(): Int = {
		return age;
	}
}