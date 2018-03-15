abstract class GA {
    ArrayList<PVector> population;
    TupleFunction fxy;
    Visualization visualizer;
    
    GA(Visualization visualization) {
      population = visualizer.getInitalPopulation();  
      fxy = visualizer.getFunction();
    }
    
    abstract ArrayList<PVector> selectPopulation(ArrayList<PVector> population);
   
   
   void draw() {
     
   }
  
}
