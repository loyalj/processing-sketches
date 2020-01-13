ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(1280, 720);
  pixelDensity(displayDensity());
  ellipseMode(CENTER);
  colorMode(HSB, 360, 1, 1, 1);
  noLoop();
}

void draw() {
 background(0, 0, 0.1);
 
 
 for(int i = 0; i <= 299; i++) {
   
   fill(random(90, 180), random(0.8, 1.0), random(0.8, 1.0), .01);
   stroke(random(90, 180), 1, 1, .01);
    beginShape();
      vertex(random(400, width-400), random(0, height));
      vertex(random(0, width),0);
      bezierVertex(0, height - random(0, height), width, random(0, height), width - random(0, width), height);
      vertex(random(0, width), height);
    endShape(CLOSE);
 }
}

void keyPressed(){
  if(key == ' ') {
    redraw();
  }
  
  if(key == 's') {
    save("screens/curve_002-"+ day() + "-" + month() + "-" + year() + "-" + hour() + "-" + minute() + "-" + second() + "-" + millis() + ".png");
  }
}
