class gSystem {
  public ArrayList<gBody> gBodies = new ArrayList<gBody>();
  public ArrayList<gParticle> gParticles = new ArrayList<gParticle>();
  float maxSpeed = 120;
  
  PGraphics particleSurface;
  
  float G = 6.67408e-11;
  
  
  gSystem () {
    this.particleSurface = createGraphics(width, height);
  }
  
  void update(float delta) {
    PVector dxy, gForce, gAccel;
    float distance, d3;
    int onScreen = 0;
    gForce = new PVector(0,0);
    gAccel = new PVector(0,0);
    
    for (int i = gParticles.size()-1; i >= 0; i--) {
       gParticle cp = gParticles.get(i);
       
       // Figure Gravity for all bodies
       for (int j = 0; j < gBodies.size(); j++) {
         gBody cb = gBodies.get(j);
         
         dxy = new PVector(cb.position.x - cp.position.x, cb.position.y - cp.position.y);
         distance = cp.position.dist(cb.position);
         d3 = distance * distance * distance;
         cp.accel.add(new PVector(cb.mass * dxy.x / d3, cb.mass * dxy.y / d3));
         
       }
         
       cp.update(delta);
       if(abs(cp.velocity.x) >= maxSpeed || abs(cp.velocity.y) >= maxSpeed) {
         gParticles.remove(i);
       }
       
       if((cp.position.x > -width/2) && (cp.position.x < width/2) && (cp.position.y > -height/2) && (cp.position.y < height/2)) {
         onScreen++;
       }
     }  
     
     println(onScreen + "/" + gParticles.size());
  }
  
  void draw() {
    this.draw(0,0);
  }
  
  void draw(int xOff, int yOff) {
    pushMatrix();
    pushStyle();
       ellipseMode(RADIUS);
    
       
       
       for (int i = 0; i < gParticles.size(); i++) {
         gParticle cp = gParticles.get(i);
         cp.draw(xOff, yOff);
       }
       
       // Draw the bodies
       for (int i = 0; i < gBodies.size(); i++) {
         gBody cb = gBodies.get(i);
         //cb.draw(xOff, yOff);
       }
     popStyle();
     popMatrix();
  }
}