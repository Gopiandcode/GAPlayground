class Visualization {
  int posX, posY;
  int visualizationWidth, visualizationHeight;
  double startX, startY;
  double scale;
  TupleFunction fxy;
  color from = color(253, 252, 255);
  color to = color(255, 71, 61);
  color markColor = color(0, 162,0);
ArrayList<PVector> points = new ArrayList<PVector>();

  Visualization(TupleFunction fxy) {
    visualizationHeight = 600;
    visualizationWidth = 600;
    posX = width/2-(visualizationWidth/2);
    posY = height/2-(visualizationHeight/2);
    scale =2.0/visualizationWidth;
    startX = (double) -1 * visualizationWidth * (double) scale/2.0;
    startY = (double)-1 * visualizationHeight * (double) scale/2.0;
    this.fxy = fxy;
  }

  void draw() {
    double[] values = new double[visualizationWidth * visualizationHeight];
  double min = 0;
  double max = 0;

    for (int j = 0; j < visualizationHeight; j++) { 
      for (int i = 0; i < visualizationWidth; i++) {
        double valX = startX + (double)i * scale;
        double valY = startY + (double)j * scale;
        double scalarValue = fxy.exec(valX, valY);
        if (scalarValue > max) {
          max = scalarValue;
        }
        if (scalarValue < min) {
          min = scalarValue;
        }

        values[(j * visualizationWidth) + i] = scalarValue;
      }
    }
    loadPixels();
    for (int j = 0; j < visualizationHeight; j++) { 
      for (int i = 0; i < visualizationWidth; i++) {
        float computedValue = (float)((values[(j * visualizationWidth) + i] - min)/(max-min));
        int index =((posY + j) * width) + i + posX;
        pixels[index] = lerpColor(from, to, computedValue);
      }
    }  
    updatePixels();

    for (int i = posX; i <= posX + visualizationWidth; i+= visualizationWidth / 10) {
      double valX = startX + i * scale;
      line(i, posY + visualizationHeight, i, posY + visualizationHeight + 20);
      String text = String.format("%.1f", valX);
      print(text, "\n");
      fill(0);
      text(text, i - textWidth(text)/2, posY + visualizationHeight + 35);
    }

    for (int i = posY; i <= posY + visualizationHeight; i+= visualizationHeight / 10) {

      double valY = startY + i * scale;
      line(posX, i, posX - 20, i);
      String text = String.format("%.1f", valY);
      fill(0);
      text(text, posX - 30  - textWidth(text), i+5);
    }
    
    
  }
  
  ArrayList<PVector> getInitalPopulation() {
     ArrayList<PVector> points;
     
     return points;
  }

  TupleFunction getFunction() {
    return fxy;
  }

  void plot(ArrayList<PVector> points) {
     for(PVector point : points) {
        float pointX = (float) (posX + (point.x - startX)/scale); 
        float pointY = (float) (posY + (point.y - startY)/scale);
        
            if (

      (pointX > posX && pointX < posX + visualizationWidth)

      &&
      (pointY > posY && pointY < posY + visualizationHeight)
      ) {
        
        fill(markColor);
        line(pointX - 5, pointY, pointX + 5, pointY);
        line(pointX, pointY - 5, pointX, pointY + 5);
        point(pointX, pointY);
      }
     }
  }

  void onMouseEvent(MouseEvent event) {
    if (

      (mouseX > posX && mouseX < posX + visualizationWidth)

      &&
      (mouseY > posY && mouseY < posY + visualizationHeight)
      ) {

      double direction = event.getCount();
      double oldScale = scale;
      scale += direction * scale/ 10.0;
      if (scale <= 0) {
        scale =2.0/visualizationWidth;
        startX = (double) -1 * visualizationWidth * (double) scale/2.0;
        startY = (double)-1 * visualizationHeight * (double) scale/2.0;
      } else {
        startX += (mouseX - posX) * (oldScale - scale);
        startY += (mouseY - posY) * (oldScale - scale);
      }
    }

  }

  void update() {
    fxy.update();
   
  }
}
