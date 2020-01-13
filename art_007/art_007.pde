PGraphics buffer;  // The back buffer surface we'll use for drawing
color backgroundColor = color(0);  // Canvas background color

Splatter s1; // A class that draws n-gon shapes
float radius = 200;

void setup() {
  size(1280, 720);
  pixelDensity(displayDensity());
  smooth(2);
  colorMode(HSB, 360, 100, 100, 1);
  //ellipseMode(RADIUS);
  background(240, 3, 100);
  
  buffer = createGraphics(width, height);
  
  
  // Setup the splatter object with some parameters
  s1 = new Splatter(0, 0, radius);
  s1.cf.currentHue = random(0, 360);
  s1.cf.cycleDistance = (360/2);
  s1.cf.setColorMode(ColorMode.CYCLE);
  
  noLoop();
}

void draw() {
  buffer.beginDraw();
    //buffer.background(backgroundColor);
    buffer.clear();
  buffer.endDraw();
  
  for(int x = 0; x <= width + int((radius)); x = x + int((radius))) {
    for(int y = 0; y <= height + int((radius)); y = y + int((radius))) {
      for(int r = int(radius); r >= 50; r = r - 20) {
          s1.moveTo(x, y);
          s1.cf.nextColor();
          s1.draw(buffer, 0, 0);
          s1.radius = r;
      }
    }
  }
  
  //s1.cf.currentHue = random(0, 360);
  colorMode(HSB, 360, 100, 100, 100);
  s1.cf.currentColor = color(180, 100, 100, 1);
  //s1.moveTo(width/2, height/2);
  s1.moveTo(random(-width/2, width/2), random(-height/2, height/2));
  //s1.cf.nextColor();
  s1.draw(buffer, width/2, height/2);

  
  image(buffer, 0, 0);
}


void keyPressed(){
 if(key == ' ') {
    redraw();
  }
  
  if(key == 's') {
    save("screens/art_007-"+ day() + "-" + month() + "-" + year() + "-" + hour() + "-" + minute() + "-" + second() + "-" + millis() + ".png");
  }
}
