int xDrawRes = 10;
int lineHeight = 400;
float xOff, curNoise, xRes;

void setup() {
  size(1280, 720);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 1, 1, 1);
  
  xRes = 0.1;
  
  render();
}


void draw() {
}

void keyPressed() {
  if(key == ' ') {
    noiseSeed(int(random(0,99999)));
    render(); 
  }
}

void render() {
 beginShape();
 vertex(0,height);
 
 xOff = 0;
 for(int x = 0; x <= width; x += xDrawRes) {
   xOff += xRes;
   curNoise = noise(xOff) * 100;
   
   println(curNoise);
   println(xOff);
   println(xRes);
   
   vertex(x, lineHeight + curNoise);
   
   
 }
 
 vertex(width, height);
 endShape(); 
}
