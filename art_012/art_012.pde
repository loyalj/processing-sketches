int drawWidth;
int drawHeight;
int xDrawOffset;
int yDrawOffset;
int xRes;
int yRes;

float xNoiseOffset, xNoiseDimension;
float yNoiseOffset, yNoiseDimension;

void setup() {
 
  size(1280, 720);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 1, 1, 1);
  
  loadConfig();
  
  rectMode(CENTER);
  render();
}

void loadConfig() {
  noiseSeed(0);
  
  drawWidth = width;
  drawHeight = height;
  
  xRes = 10;
  yRes = 10;
  
  xDrawOffset = xRes/2;
  yDrawOffset = yRes/2;
  
  xNoiseDimension = 0.05;
  yNoiseDimension = 0.05;
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
  background(0);
  
  noStroke();
  yNoiseOffset = 0.0;
  for(int y = 0; y <= drawHeight; y += yRes) {
    xNoiseOffset = 0.0;
    for(int x = 0; x <= drawWidth; x += xRes) {
      
      float shade = noise(xNoiseOffset, yNoiseOffset);
      int tileId = int(map(shade, 0.0, 1, 0.0, 10.0));
      
      // Colour them in
      if(tileId <= 3) {
        fill(180, 1, 0.45 + shade);
      }
      else if(tileId  <= 4) {
        fill(90, shade, 1);  
      }
      else if(tileId  <= 6) {
        fill(120, shade, 1);  
      }
      else if(tileId  <= 8) {
        fill(120, shade, 0.8);  
      }
      
      
      rect(x + xDrawOffset, y + yDrawOffset, xRes, yRes);
      
      xNoiseOffset += xNoiseDimension;
    }
    yNoiseOffset += yNoiseDimension;
  }
}
