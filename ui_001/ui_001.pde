PImage backgroundImage;

guiPane mainPane;
gSystem grav;
gBody sun;
int currentMillis, lastMillis = 0;
float delta;
ArrayList<gParticle> particles = new ArrayList<gParticle>();


void setup() {
  size(1280, 720);
  pixelDensity(displayDensity());
  smooth();
  colorMode(HSB, 360, 100, 100, 100);
  
  //backgroundImage = loadImage("images/background.jpg");
  
  // Setup the gui stuff
  mainPane = new guiPane(0, 0, width, 100);
  
  
  
  // Setup the gravity system
  grav = new gSystem();
  float margin = 200;
  for(int i = 0; i <= 1; i++) {
    grav.gBodies.add(new gBody(random((-width/2) + margin, (width/2) - margin), random((-height/2) + margin, (height/2) - margin), 50, random(200,750)));
  }
  
  for(int i = 0; i <= 500; i++) {
    grav.gParticles.add(new gParticle(-width/2, random(-height/2, height/2), 1, 100));
    grav.gParticles.add(new gParticle(width/2, random(-height/2, height/2), 1, 100));
    grav.gParticles.add(new gParticle(random(-width/2, width/2), -height/2, 1, 100));
    grav.gParticles.add(new gParticle(random(-width/2, width/2), height/2, 1, 100));
  }
    
  background(255, 0, 100);
  //image(backgroundImage, 0, 0);
}

void draw() { 
  currentMillis = millis() - lastMillis;
  delta = currentMillis/100.0;
  
  grav.update(delta);
  
  // Clear the screen
  //background(0);
 
  //Draw the gravity system
    pushMatrix();
    //Re-center the coordinates so 0,0 is in the middle
    translate(width/2, height/2);
    // Draw our gravity system
    grav.draw();
  popMatrix();
 
  //Draw the GUI
  //mainPane.draw();
 
  //delta = 0;
  lastMillis = millis();
}

void keyPressed(){
  
  if(key == 's') {
    save("screens/grav_007-"+ day() + "-" + month() + "-" + year() + "-" + hour() + "-" + minute() + "-" + second() + "-" + millis() + ".png");
  }
}
