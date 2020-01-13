PVector p1, p2, c, i1, i2;
boolean intersect = false;
float minRadius = 100;
float maxRadius = 200;


void setup() {
  size(1280, 720);
  pixelDensity(displayDensity());
  smooth();
  colorMode(HSB, 360, 255, 255, 255);
  noLoop();
  ellipseMode(RADIUS);

}

void draw() {
  background(0);
  
  initGeometry();
  intersect = doMathStuff();
  
  translate(width/2, height/2);
  drawGeometry();
}

void keyPressed(){
 if(key == ' ') {
    redraw();
  }
  
  /*if(key == 's') {
    save("screens/screen-"+ day() + "-" + month() + "-" + year() + "-" + hour() + "-" + minute() + "-" + second() + "-" + millis() + ".png");
  }*/
}

void initGeometry() {
  p1 = new PVector(-width/2, random(-height/2, height/2));
  p2 = new PVector(width/2, random(-height/2, height/2));
  float cr = random(minRadius, maxRadius);
  c = new PVector(random((-width/2)+cr+5, (width/2)-cr-5), random((-height/2)+cr+5, (height/2)-cr-5), cr);
}

void drawGeometry() {
  //Draw the line
  stroke(0, 0, 255, 100);
  line(p1.x, p1.y, p2.x, p2.y);
  
  stroke(0,0, 255);
  fill(0, 50, 255, 125);
  ellipse(c.x,c.y, c.z, c.z);
  
  
  
  

  if(intersect) {
    
    noFill();
    ellipse(i1.x, i1.y, 2, 2); 
    ellipse(i2.x, i2.y, 2, 2); 
    ellipse(i1.x, i1.y, 4, 4); 
    ellipse(i2.x, i2.y, 4, 4); 
    
    fill(135, 50, 200, 125);
    if(atan2(i1.y - c.y, i1.x - c.x) < atan2(i2.y - c.y, i2.x - c.x)) {
      arc(c.x, c.y, c.z, c.z, atan2(i1.y - c.y, i1.x - c.x), atan2(i2.y - c.y, i2.x - c.x), CHORD);
    }
    else {
      arc(c.x, c.y, c.z, c.z, atan2(i2.y - c.y, i2.x - c.x), atan2(i1.y - c.y, i1.x - c.x), CHORD);
    }
  }
}


boolean doMathStuff() {

  float dx = p2.x - p1.x;
  float dy = p2.y - p1.y;

  float A = dx * dx + dy * dy;
  float B = 2 * (dx * (p1.x - c.x) + dy * (p1.y - c.y));
  float C = (p1.x - c.x) * (p1.x - c.x) + (p1.y - c.y) * (p1.y - c.y) - c.z * c.z;
  
  float det = B * B - 4 * A * C;

  if ((A <= 0.0000001) || (det < 0))
  {
    println("no intersection");
    return false;
  }
  else if(det == 0) {
    println("tangent");  
    return false;
  }
  else {
    float t = (-B + sqrt(det)) / (2 * A);
    i1 = new PVector(p1.x + t * dx, p1.y + t * dy);
    
    t = (-B - sqrt(det)) / (2 * A);
    i2 = new PVector(p1.x + t * dx, p1.y + t * dy);
    return true;
  }
    
}
