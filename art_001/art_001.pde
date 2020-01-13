int numRects = 1;
int minWidth = 30;
int maxWidth = 200;
int minHeight = 30;
int maxHeight = 200;
int xDen = 1;
int yDen = 1;
int xScale = 0;
int yScale = 5;

int minCol = 50;
int maxCol = 200;
int minAlpha = 50;
int maxAlpha = 200;

int r = 0;
int g = 255;
int b = 90;




void setup() {
  size(800, 800);
  pixelDensity(displayDensity());
  background(0,0,0);
  
  doDraw();
}

void draw() {
 // Needs to be here in order to enable the keyPressed() events in processing 
}

void keyPressed(){
  if(key == ' ') {
    doDraw();  
  }
}



void doDraw() {
  //background(0,0,0);

  for(int cr = 0; cr < numRects; cr++) {
    int rWidth = int(random(minWidth, maxWidth));
    int rHeight = int(random(minHeight, maxHeight));
    
    float top = random(0, height - rHeight);
    float left = random(0, width - rWidth);
    
    //r = int(random(minCol, maxCol));
    g = int(random(minCol, maxCol));
    b = int(random(minCol, maxCol));
    
    xScale = int(random(2, 8));
    
    for(int y = 0; y <= rHeight; y = y + yDen) {
        for(int x = 0; x <= rWidth; x = x + xDen) {
          stroke(r, g, b, int(random(minAlpha, maxAlpha)));
          point(x + left + (cos(y) * yScale), y + top + (sin(x) * xScale));
        } 
    }
  }  
}
