object OO {
	def main ( ) : Unit = {
		 println(new Person().init("John", new Animal().init("minou", 13)).sayHello());
	} 
}

class Person {
	var name: String;
	var animal: Animal;
	
	def init(n: String, a: Animal): Person = {
		name = n;
		animal = a;
		return this;
	}
	
	def sayHello(): String = {
		return "Hi I'm " + name + " and my cat is " + animal.sayYourName() + " (he's " + animal.sayYourAge() + ")";
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