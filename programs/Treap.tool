object Treap {
   def main() : Unit = {
      if(this == this && new Runner().run()) {}
   }
}

class Runner {
   def run() : Bool = {
      var prng : PseudoRandomNumberGenerator;
      var tree : Node;
      prng = new PseudoRandomNumberGenerator().init();
      tree = new Leaf().setPrng(prng).insert(5).insert(4).insert(3).insert(2).insert(1);
      return tree.print();
   }
}

class Node {
   var prng : PseudoRandomNumberGenerator;
   def setPrng(aPrng : PseudoRandomNumberGenerator) : Node = {prng = aPrng; return this;}
   def insert(v : Int) : Node = {return this;}
   def getPriority() : Int = {return 0;}
   def setLeft(n : Node) : Bool = {return false;}
   def setRight(n : Node) : Bool = {return false;}
   def getRight() : Node = {return this;}
   def getLeft() : Node = {return this;}
   def rotateLeft() : Node = {return this;}
   def rotateRight() : Node = {return this;}
   def print() : Bool = {return true;}
}
class Leaf extends Node {
   def insert(val : Int) : Node = {
      return new InternalNode().init(val, prng);
   }
}

class InternalNode extends Node {
   var value : Int;
   var priority : Int;
   var left : Node;
   var right : Node;
   
   def init(v : Int, prng : PseudoRandomNumberGenerator) : Node = {
      value = v;
      priority = prng.getInt(0, 100);
      left = new Leaf().setPrng(prng);
      right = new Leaf().setPrng(prng);
      return this;
   }
   def print() : Bool = {
      if(left.print()) {}
      println(value + ", " + priority);
      if(right.print()) {}
      return true;
   }
   def getPriority() : Int = {return priority;}
   def getRight() : Node = {
      return right;
   }
   def getLeft() : Node = {
      return left;
   }
   def setRight(n : Node) : Bool = {
      right = n;
      return true;
   }
   def setLeft(n : Node) : Bool = {
      left = n;
      return true;
   }
   def rotateLeft() : Node = {
      var r : Node;
      var sl : Node;
      r = right;
      sl = right.getLeft();
      right = sl;
      if(r.setLeft(this)) {}
      return r;
   }

   def rotateRight() : Node = {
      var l : Node;
      var sr : Node;
      l = left;
      sr = left.getRight();
      left = sr;
      if(l.setRight(this)) {}
      return l;
   }

   def insert(v : Int) : Node = {
      var ret : Node;
      ret = this;
      if(v < value) {
         left = left.insert(v);
         if(priority < left.getPriority()) {
            ret = this.rotateRight();
         }
      } else {
         right = right.insert(v);
         if(priority < right.getPriority()) {
            ret = this.rotateLeft();
         }
      }
      return ret;
   }
}

class PseudoRandomNumberGenerator {
  var a : Int;
  var b : Int;

  def init() : PseudoRandomNumberGenerator = {
    a = 12345; // put whatever you like in here
    b = 67890; 
    return this;
  }

  def getInt(min : Int, max : Int) : Int = {
    var posInt : Int;

    posInt = this.nextInt();
    if(posInt < 0)
      posInt = 0 - posInt;

    return min + (this.mod(posInt, max - min));
  }

  def mod(i : Int, j : Int) : Int = { return i - (i / j * j); }

  def nextInt() : Int = {
    b = 36969 * ((b * 65536) / 65536) + (b / 65536);
    a = 18000 * ((a * 65536) / 65536) + (a / 65536);
    return (b * 65536) + a;
  }
}
