class gLine {
 public PVector start, end;
 
 gLine(float x1, float y1, float x2, float y2) {
   this.start = new PVector(x1, y1);
   this.end = new PVector(x2, y2);
 } 
 
 void draw() {
   line(start.x, start.y, end.x, end.y);  
 }
}



class gCircle {
  public PVector origin;
  public float radius;
  public color foreColor;
  public color backColor;
  public color strokeColor;
  
  gCircle(float x, float y, float radius) {
    this.origin = new PVector(x, y);
    this.radius = radius;
  }
  
  void draw() {
    stroke(strokeColor);
    fill(backColor);
    ellipse(this.origin.x, this.origin.y, this.radius, this.radius);
  }
  
  void draw(gLine[] lines) {
    noStroke();
    //stroke(strokeColor);
    fill(backColor);
    ellipse(this.origin.x, this.origin.y, this.radius, this.radius);
    
    fill(foreColor);
    for(gLine l : lines) {
      float dx = l.end.x - l.start.x;
      float dy = l.end.y - l.start.y;
    
      float A = dx * dx + dy * dy;
      float B = 2 * (dx * (l.start.x - this.origin.x) + dy * (l.start.y - this.origin.y));
      float C = (l.start.x - this.origin.x) * (l.start.x - this.origin.x) + (l.start.y - this.origin.y) * (l.start.y - this.origin.y) - this.radius * this.radius;
      
      float det = B * B - 4 * A * C;
    
      if (!((A <= 0.0000001) || (det < 0) || (det == 0)))
      {
        float t = (-B + sqrt(det)) / (2 * A);
        PVector i1 = new PVector(l.start.x + t * dx, l.start.y + t * dy);
        
        t = (-B - sqrt(det)) / (2 * A);
        PVector i2 = new PVector(l.start.x + t * dx, l.start.y + t * dy);
        
        noStroke();
        //stroke(0, 0, 255, 80);
        if(atan2(i1.y - this.origin.y, i1.x - this.origin.x) < atan2(i2.y - this.origin.y, i2.x - this.origin.x)) {
          arc(this.origin.x, this.origin.y, this.radius, this.radius, atan2(i1.y - this.origin.y, i1.x - this.origin.x), atan2(i2.y - this.origin.y, i2.x - this.origin.x), CHORD);
        }
        else {
          arc(this.origin.x, this.origin.y, this.radius, this.radius, atan2(i2.y - this.origin.y, i2.x - this.origin.x), atan2(i1.y - this.origin.y, i1.x - this.origin.x), CHORD);
        }
      }  
    }
    
  }
  
}