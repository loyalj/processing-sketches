gLine[] lines = new gLine[5];
gCircle[] circles = new gCircle[5];


// Circle control properties
boolean drawCircles = true;
float minRadius = 100;
float maxRadius = 200;
float cr;


// Should we draw the lines we use to divide cirlces?
boolean drawLines = false;


// Should we draw the "paper" texture
boolean drawTexture = true;
int texRes = 3;







void setup() {
  size(1280, 720);
  pixelDensity(displayDensity());
  smooth();
  colorMode(HSB, 360, 255, 255, 255);
  noLoop();
  ellipseMode(RADIUS);
}

void draw() {
  //Clear the background to black
  background(random(0,360), 50, 100);
  
  //Generate random lines
  for(int i = 0; i < lines.length; i++) {
    if(boolean(i % 2)) {
      lines[i] = new gLine(-width/2, random(-height/2, height/2), width/2, random(-height/2, height/2));
    }
    else {
      lines[i] = new gLine(random(-width/2, width/2), -height/2, random(-width/2, width/2), height/2);
    }
  }
  
  //Generate random circles
  for(int i = 0; i < circles.length; i++) {
    cr = random(minRadius, maxRadius);
    circles[i] = new gCircle(random((-width/2)+cr+5, (width/2)-cr-5), random((-height/2)+cr+5, (height/2)-cr-5), cr); 
  }
  
  // translate the canvas so 0,0 is the center of the screen
  translate(width/2, height/2);
 
  //Draw the lines
  if(drawLines) {
    stroke(0, 0, 255, 100);
    for(int i = 0; i < lines.length; i++) {
      lines[i].draw();
    }
  }
  
  // draw the circles  
  if(drawCircles) {
    for(int i = 0; i < circles.length; i++) {
      circles[i].backColor = color(random(0,360), random(50, 150), 200, 125);
      circles[i].foreColor = color(random(0,360), 50, 200, 125);
      circles[i].strokeColor = color(0,0, 255);
      circles[i].draw(lines);
    }
  }
  
  //noiseFill(-width/2, -height/2, width/2, height/2);
  if(drawTexture) {
    noiseFill(-width/2, -height/2, width/2, height/2);
  }
}

void keyPressed(){
 if(key == ' ') {
    redraw();
  }
  
  if(key == 's') {
    save("screens/art_006-"+ day() + "-" + month() + "-" + year() + "-" + hour() + "-" + minute() + "-" + second() + "-" + millis() + ".png");
  }
}
