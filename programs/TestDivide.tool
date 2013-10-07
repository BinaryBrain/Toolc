object TestDivide {
    def main() : Unit = {
        println(new Divide().start());      // we give here the number's size to be test   
    }
}

class Divide{

	def start() : Int = {
	
	println("10 / 2 : " + 10 / 2);
	println("10 / 5 : " + 10 / 5);
	println("10 / 0 : " + 10 / 0);


	return 0;
	
	}




}
