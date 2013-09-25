object Primes {
    def main(): Unit = {
        if(new Computer().run()) {
            println("Done");
        }
    }
}

class Computer {
    def run(): Bool = {
        var n: Int;
        var primes: Int[];
        var i: Int;
        
        println("Running...");
        
        n = 10;
        
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
        
        if(0<n) {
            primes[0] = 2;
            primes[1] = 3;
            found = 2;
            lastTest = 3;
            
            while(found < n) {
                if(this.isPrime(test, primes)) {
                    primes[found] = test;
                    found = found + 1;
                }
                
                lastTest = test;
                test = test+2;
            }
        }
        else {
            println("Error: 'n' must be > 0");
        }
        
        return primes;
    }
    
    def isPrime(n: Int, found: Int[]): Bool = {
        /*var i: Int;
        var prime: Bool;
        var break: Bool;
        
        i = 0;
        prime = true;
        
        break = false;
        
        while(i<found.length || found[i]*found[i] < n || break) {
            if(this.mod(n, found[i]) == 0) {
                prime = false;
                break = true;
            }
            
            i = i+1;
        }
        
        return prime;*/
        return true;
    }
    
    def mod(a: Int, b: Int): Int = {
        return a-(a/b)*b;
    }
}