PGraphics mask, dColor;
float cTheta = -90;

void setup() {
  size(320, 320);
  pixelDensity(displayDensity());
  smooth();
  colorMode(HSB, 360, 255, 255, 255);
  ellipseMode(RADIUS);
  
  //noLoop();
  
  mask = createGraphics(width, height);
  dColor = createGraphics(width, height);
}


void draw() {
  translate(width/2, height/2);
  
  background(0);
  
  // Mask
  pushMatrix();
      mask.beginDraw();
      mask.noStroke();
      mask.colorMode(HSB, 360, 255, 255, 255);
      mask.translate(width/2, height/2);
      
      mask.fill(0, 0, 255);
      mask.ellipse(0,0,120,120);
      mask.fill(0, 0, 0);
      mask.ellipse(0,0, 105, 105);
      
      
      mask.fill(0, 0, 255);
      mask.ellipse(0,0,100,100);
      mask.fill(0, 0, 0);
      mask.ellipse(0,0, 80, 80);
    mask.endDraw();
  popMatrix();
  
  
  // Filler
  pushMatrix();
    
    dColor.beginDraw();
      dColor.noStroke();
      dColor.colorMode(HSB, 360, 255, 255, 255);
      
      // Move to the center of the screen
      dColor.translate(width/2, height/2);
      
      // Rotate so 0 is top of the compass 
      dColor.rotate(radians(cTheta));
      
      // arcs
      for(int i = 0; i <= 360; i += 20){
        //println(i);
        dColor.fill(i, 255, 255);
        dColor.arc(0, 0, 300, 300, radians(i), radians(i+20), PIE);
      }
    dColor.endDraw();
  popMatrix();
  
  dColor.mask(mask);
  image(dColor, -width/2, -height/2);
  
  if(cTheta <= -360) {
    cTheta = 0;
  }
}
