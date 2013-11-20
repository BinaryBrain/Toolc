object Primes {
    def main(): Unit = {
        if(new Computer().run( (5+6)*2, new Computer().getMe(1, new Computer()), !(true && false))) {
            println("INFO: Done");
        }
    }
}

class Computer {
	def run(n:Int, c:Computer, b:Bool): Bool = {
		return true;
	}
	
	def getMe(, c:Computer): Computer = {
		return !(this && false);
	}
}

