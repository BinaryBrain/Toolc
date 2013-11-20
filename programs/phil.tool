object Example {
 def main() : Unit = {
   println(new B().foo());
 }
}

class B extends A {
 def foo(value:Bool) : Int = {
   value = 42;
   return value;
 }
}

class A {
 var value : Int;
 def foo(value:Int) : Int = {
   value = false;
   return 41;
 }
}

class C extends B {
 def foo(value: Int) : Int = {
   value = false;
   return 41;
 }
}