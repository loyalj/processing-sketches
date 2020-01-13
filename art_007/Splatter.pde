class Splatter {
  PVector position;
  public float radius;
  public int segments = 128;
  public int radialJitter = 0;
  public int gridJitter = 0; 
  public ColorFactory cf;
  
  Splatter() {
    this(0.0, 0.0, 10.0);
  }
  
  Splatter(float x, float y, float r) {
    this.position = new PVector(x, y);
    radius = r;
    
    cf = new ColorFactory();
  }
  
  void moveTo(float x, float y) {
    this.position.x = x;
    this.position.y = y;
  }
  
  
  
  void draw(PGraphics surface, int xOff, int yOff) {
    this.radialJitter = int(this.radius / 50.0);
    this.gridJitter = int(this.radius / 10.0);
    
    surface.beginDraw();
    surface.pushStyle();
    surface.pushMatrix();
      
      surface.colorMode(HSB, 360, 100, 100, 1);
      //surface.ellipseMode(RADIUS);
      surface.noStroke();
      surface.strokeWeight(0);
      surface.fill(this.cf.getCurrentColor());
      surface.translate(this.position.x + xOff, this.position.y + yOff);
      surface.rotate(radians(this.cf.currentHue));
      
      
      surface.beginShape();
        float vx, vy, cj;
        for(int i = 0; i <= 360; i = i + (360/segments)) {
          cj = random(this.radialJitter, this.radialJitter * random(2, 5));
          vx = (cos(radians(i)) * (this.radius + cj)) + random(-this.gridJitter, this.gridJitter);
          vy = (sin(radians(i)) * (this.radius + cj)) + random(-this.gridJitter, this.gridJitter);
          
          surface.vertex(vx, vy);
        }
      surface.endShape(CLOSE);
    
    surface.popMatrix();
    surface.popStyle();
    surface.endDraw();
  }
  
  
}