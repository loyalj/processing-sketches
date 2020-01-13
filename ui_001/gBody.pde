class gBody {
 public PVector position = new PVector();
 public float radius, mass;
 public color stroke, fill;
 
 gBody(float x, float y, float r, float m) {
   this.position.x = x;
   this.position.y = y;
   this.radius = r;
   this.mass = m;
   
   this.fill = color(random(0, 360), random(25, 50), 100, 50);
   this.stroke = color((hue(this.fill) + (36*3)) % 360, saturation(this.fill) + 50, 100, 50);
 }
 
 public void draw() {
   this.draw(0,0);
 }
 
 public void draw(int xOff, int yOff) {
   // println("draw grav");
     pushStyle();
       fill(this.fill);
       stroke(this.stroke);
       strokeWeight(4);
       ellipse(this.position.x + xOff, this.position.y + yOff, this.radius, this.radius);
     popStyle();
 }
  
}