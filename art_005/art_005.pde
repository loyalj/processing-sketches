int bigCirclesCount = 5;
int smallCirclesPerBig = 5;

float minBigCircleR = 100;
float maxBigCircleR = 200;
float minSmallCircleR = 10;
float maxSmallCircleR = 20;


void setup() {
  // Setup some canvas stuff
  size(1000, 800);
  pixelDensity(displayDensity());
  smooth();
  colorMode(HSB, 360, 255, 255, 255);
  noLoop();
  
}

void draw() {
  translate(width/2, height/2);
  
  // Draw a bunch of circles
  background(195, 50, 200);
  float mx, my, mr, cx, cy, cr, theta; 
  for(int j = 0; j < bigCirclesCount; j++) {
    
    mr = random(minBigCircleR, maxBigCircleR);
    mx = random((-width/2) + mr + maxSmallCircleR, (width/2) - mr - maxSmallCircleR);
    my = random((-height/2) + mr + maxSmallCircleR, (height/2) - mr - maxSmallCircleR);
    drawCircle(mx, my, mr);
    drawCircle(mx, my, mr-2);
    drawCircle(mx, my, mr-4);
    
    for(int i = 0; i < smallCirclesPerBig; i++) {
       theta = random(0, 360);
       cx = mx+(mr * cos(theta));
       cy = my+(mr * sin(theta));
       cr = random(minSmallCircleR, maxSmallCircleR);
       
       drawCircle(cx, cy, cr);
       drawCircle(cx, cy, cr-3);
    }
  }
  
}

void keyPressed(){
 if(key == ' ') {
    bigCirclesCount = int(random(5, 20));
    smallCirclesPerBig = int(random(5, 10));
    redraw();
  }
  
  if(key == 's') {
    save("screens/art_005-"+ day() + "-" + month() + "-" + year() + "-" + hour() + "-" + minute() + "-" + second() + "-" + millis() + ".png");
  }
}