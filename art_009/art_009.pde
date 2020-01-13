// Perlin Noise Experiments

int gridX = 25;
int gridY = 25;
float xOff = 0;
float yOff = 0;
float increment = 0.02;

void setup() {
  size(1280, 720);
  pixelDensity(displayDensity());
  smooth(2);
  ellipseMode(CORNER);
  colorMode(HSB, 360, 1, 1, 1);
  //noiseSeed(0);
  background(0);
}


void draw() {
  background(0);
  //noStroke();
  noiseDetail(6, 0.5);
  xOff = 0;
  for(int x = 0; x <= width; x = x + gridX) {
    xOff += increment;
    yOff = 0;
    for(int y = 0; y <= height; y = y + gridY) {
      yOff += increment;
      fill(100, 0.5, noise(xOff, yOff));
      rect(x, y, gridX, gridY);
    }
  }
}
