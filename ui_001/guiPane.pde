class guiPane {
  int top, left, width, height;
  color stroke, fill;
  
  //PVector screenDimensions;
  //PVector location, dimensions;
  
  guiPane(int top, int left, int width, int height) {
    this.top = top;
    this.left = left;
    this.width = width;
    this.height = height;
    
    this.fill = color(0,0,125);
    this.stroke = color(0,0,255, 125);
  }
  
  public void draw() {
    this.draw(0,0);
  }
  
  public void draw(int xOff, int yOff) {
    
    pushStyle();
      fill(this.fill);
      stroke(this.stroke);
      rect(this.left + xOff, this.top + yOff, this.width, this.height); 
    popStyle();
  }
}