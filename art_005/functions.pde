void mainDraw() {
  
}


void drawCircle(float x, float y, float radius) {
  pushMatrix();
  pushStyle();
  blendMode(DIFFERENCE);
  stroke(0, 0, 255, 80);
  fill(random(0, 360), 255, 255, 25);
  //noFill();
  ellipseMode(RADIUS);
  ellipse(x, y, radius, radius);
  
  popMatrix();
  popStyle();
}