interface TupleFunction {
  double exec(double x, double y);
  void update();
}

class SimpleFunction implements TupleFunction {
  int i = 1;
   double exec(double x, double y) {
     return x*x + y * y - 0.1 * x * x * x * x - 0.1 * y * y * y * y;
   }
   
   void update() {
   }
}
