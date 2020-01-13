class gParticle {
 public PVector position = new PVector();
 public PVector lastPosition = new PVector();
 float sVel = 0;
 public PVector velocity = new PVector(random(-sVel,sVel), random(-sVel,sVel));
 public PVector accel = new PVector(0, 0);
 
 public float radius, mass;
 public color stroke, fill;
 
 gParticle(float x, float y, float r, float m) {
   this.position.x = x;
   this.position.y = y;
   this.radius = r;
   this.mass = m;
   
   this.fill = color(random(0, 360), random(25, 50), 100);
   this.stroke = color((hue(this.fill) + (36*2)) % 360, saturation(this.fill) + 50, 50, 10 + this.velocity.mag());
 }
 
 public void draw() {
   this.draw(0,0);
 }
 
 public void draw(int xOff, int yOff) {
     pushStyle();
       //fill(this.fill);
       noFill();
       stroke(this.stroke);
       strokeWeight(1);
       //if((second() % 5 >= 1) && (second() % 5 <= 3)) {
         //strokeWeight(6 * abs(sin(millis())));
       //}
       line(this.lastPosition.x + xOff, this.lastPosition.y + yOff, this.position.x + xOff, this.position.y + yOff);
     popStyle();
 }
 
 public void update(float delta) {
   this.velocity.add(this.accel);
   this.lastPosition = this.position.copy();
   this.position.add(PVector.mult(this.velocity, delta)); 
   this.accel = new PVector(0,0);
 }
  
}