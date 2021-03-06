<<<<<<< HEAD
object Primes {
    def main(): Unit = {
        if(new Computer().run()) {
            println("INFO: Done");
        }
    }
}

class Computer {
    def run(): Bool = {
        var n: Int;
        var primes: Int[];
        var i: Int;
        
        println("INFO: Running...");
        
        n = 20;
        
        primes = this.findAll(n);
        
        i = 0;
        
        while(i < primes.length) {
            println(primes[i]);
            i = i+1;
        }
        
        return true;
    }
    
    def findAll(n: Int): Int[] = {
        var primes: Int[];
        var found: Int;
        var test: Int;
        var lastTest: Int;
        
        primes = new Int[n];
        
        if(1<n) {
            primes[0] = 2;
            primes[1] = 3;
            found = 2;
            test = 5;
            lastTest = 3;
            
            while(found < n) {
                if(this.isPrime(test, primes, found)) {
                    primes[found] = test;
                    found = found + 1;
                }
                
                lastTest = test;
                test = test+2;
            }
        }
        else {
            println("ERROR: 'n' must be greater than 1");
        }
        
        return primes;
    }
    
    def isPrime(n: Int, found: Int[], numFound: Int): Bool = {
        var i: Int;
        var prime: Bool;
        var break: Bool;
        
        i = 0;
        prime = true;
        
        break = false;
        
        while(!break && !(n < found[i]*found[i]) && i<numFound) {
            if(this.mod(n, found[i]) == 0) {
                prime = false;
                break = true;
            }
            
            i = i+1;
        }
        
        return prime;
    }
    
    def mod(a: Int, b: Int): Int = {
        return a-(a/b)*b;
    }
}
