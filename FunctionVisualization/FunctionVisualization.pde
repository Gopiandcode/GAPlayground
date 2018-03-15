color pink = color(255, 102, 204);

void setup() {
  size(1280, 720);
  background(255);
  visualization =  new Visualization(new SimpleFunction());
}





Visualization visualization;


void mouseWheel(MouseEvent event) {
    visualization.onMouseEvent(event);
}
void draw() {
  background(255);
  visualization.draw();
  visualization.update();
}
