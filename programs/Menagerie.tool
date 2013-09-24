/*
	Implementation of some animal's behaviours to
	test inheritance and polymorphism
	author: Andy Roulin
*/

object Menagerie {
	def main ( ) : Unit = {
		 if(new House().test()) {
		 	println("Ok");
		 }
		 else {
		 	println("Error");
		 }
	} 
}

class House {
	def test(): Bool = {
		var dummy: Bool;
		var animal: Animal;
		println("");
		println("Animal    : Animal's sound");
		dummy = new Animal().withName("Unknown   ").talk();
		dummy = new Cat().withName("Cat       ").talk();
		dummy = new Dog().withName("Dog       ").talk();
		animal = new Human().withName("John      ");
		dummy = animal.talk();
		return true;
	}
}

class Animal {
	var name: String;
	
	def withName(s: String): Animal = {
		name = s;
		return this;
	}
	
	def talk(): Bool = {
		println(name + ": Unknown type of animal does not know how to talk");
		return true;
	}
	
	def getName(): String = {
		return name;
	}
}

class Cat extends Animal {
	def talk(): Bool = {
		println(this.getName() + ": Meow!");
		return true;
	}
}

class Dog extends Animal {
	def talk(): Bool = {
		println(this.getName() + ": Woof!");
		return true;
	}
}

class Human extends Animal {
	def talk(): Bool = {
		println(this.getName() + ": Hello!");
		return true;
	}
}