// Two surfaces to draw and mask with
PGraphics mixSurface;
PGraphics maskSurface;
PGraphics bufferSurface;

// Mix surface config
int numRectsMx = 2;
int numRectPassesMx = 1;
int rectMinWidthMx = 200;
int rectMaxWidthMx = 300;
int rectMinHeightMx = 200;
int rectMaxHeightMx = 300;
int rectMinRotMx = 0;
int rectMaxRotMx = 360;
int rectSpacingX = 100;
int rectSpacingY = 100;

int numCircsMx = 3;
int circMinRadius = 200;
int circMaxRadius = 600;
int[] circBlendModes = { EXCLUSION, SCREEN, DIFFERENCE };

color strokeColorMx = color(180, 255, 255, 125);
color fillColorMx = color(240, 255, 255, 50); 
 
void setup() {
    size(1000, 800);
    pixelDensity(displayDensity());
    smooth();
   
    colorMode(HSB, 360, 255, 255, 255);

    mixSurface = createGraphics(width, height);
    mixSurface.rectMode(CENTER);
    maskSurface = createGraphics(width, height);
    bufferSurface = createGraphics(width, height);
    
    background(0);
    for(int i = 0; i< 10; i++) {
      
    renderFrame();
    }
}
 
void draw() {
    
}

void keyPressed(){
  if(key == ' ') {
    renderFrame();
  }
  
  if(key =='m') {
   for(int i = 0; i< 10; i++) {
      
    renderFrame();
    } 
  }
  
  if(key == 's') {
    saveFrame("art_004-#####.png");
  }
}

void renderFrame() {
    
    for(int i = 0; i < numRectPassesMx; i++) {
      fillMixSurface(mixSurface);
    }
    fillMaskSurface(maskSurface);
    
    bufferSurface.beginDraw();
    bufferSurface.image(mixSurface, 0, 0);
    bufferSurface.blendMode(MULTIPLY);
    bufferSurface.image(maskSurface, 0, 0);
    bufferSurface.blendMode(BLEND);
    bufferSurface.endDraw();
    
    
    int bm = circBlendModes[int(random(0,circBlendModes.length))];
    println(bm);
    blendMode(bm);
    image(bufferSurface, 0, 0);
    blendMode(BLEND); 
}
 
 
void fillMixSurface(PGraphics surface) {
  int cw, ch, crot;
  
  surface.beginDraw();
    surface.clear();
  surface.endDraw();

  for(int gx = (-width/2) + 0; gx < (width/2) + 100; gx = gx + rectSpacingX) {
    for(int gy = (-height/2) - 200; gy < (height/2) + 100; gy = gy + rectSpacingY) {
      for(int i = 0; i < numRectsMx; i++) {
        strokeColorMx = color(random(200, 360), 255, 255, 125);
        fillColorMx = color(random(340, 360), 255, 255, random(50, 125));
        
          cw = int(random(rectMinWidthMx, rectMaxWidthMx));
          ch = int(random(rectMinHeightMx, rectMaxHeightMx));
          crot = int(random(rectMinRotMx, rectMaxRotMx));
          
          surface.beginDraw();
            surface.stroke(strokeColorMx);
            surface.fill(fillColorMx);
            surface.rectMode(CENTER);
            surface.blendMode(LIGHTEST);
            
            surface.pushMatrix();
            surface.translate((width/2) + gx, (height/2) + gy);
            surface.rotate(crot);
            surface.rect(0,0,cw,ch);
            surface.popMatrix();
          surface.endDraw();
      }
    }
  }
}


void fillMaskSurface(PGraphics surface) {
  float cr;
  
  cr = random(circMinRadius, circMaxRadius);
  
  strokeColorMx = color(320, 0, 255, 255);
  fillColorMx = color(0, 0, 125, 255);
        
        
  surface.beginDraw();
    surface.background(0);
    surface.stroke(strokeColorMx);
    surface.fill(fillColorMx);
    surface.translate(width/2, height/2);
    surface.rotate(random(0,360));
    surface.ellipse(random(-width/2, width/2),random(-height/2, height/2), cr, cr);
  surface.endDraw();
}
 
 