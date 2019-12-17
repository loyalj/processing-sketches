int horizontalGridRes = 20;
int verticalGridRes = 20;

float theta = 0.0;

color bgColor;

Entity test;

void setup() {
    size(1280, 720);
    pixelDensity(displayDensity());

    surface.setTitle("Sketch 001 - Entity Position and Display Viewport");

    colorMode(HSB, 360, 100, 100, 100);

    bgColor = color(0, 0, 0);

    test = new Entity();
    
    test.position.x = 100;
    test.position.y = 0;
    test.heading = random(0, 360);
}

void draw() {
    push();
    // Reset 0,0 to the middle of the screen, and make Y point up
    translate(width/2, height/2);
    scale(1, -1);
    
    // Simulate the viewport
    //translate(0, 0);
    scale(0.98, 0.98);
    
    drawBackground();
    
    // Draw the entity
    test.draw();
    test.position.x = abs(sin(theta) * 300);
    test.position.y = sin(theta) * 200;
    test.heading = sin(theta) * 360;
    theta += 0.005;
    pop();

}


void drawBackground() {
    // Fill the frame with black, and draw a grid on it with an outline of the screen space.
    
    background(bgColor);

    push(); 
    
    stroke(40);
    // Draw vertical grid)
    for (int x = -(width/2); x < width/2; x += verticalGridRes) {
        line(x, -(height/2), x, (height/2));
    }

    // Draw horizontal grid)
    for (int y = -(height/2); y < height/2; y += horizontalGridRes) {
        line(-(width/2), y, (width/2), y);
    }

    stroke(100);

    // Vertical centerline
    line(0, -(height/2), 0, (height/2));

    // Horizontal centerline
    line(-(width/2), 0, (width/2), 0);
    
    stroke(color(230, 100, 100));
    noFill();
    rect(-(width/2), -(height/2), width, height);

    pop();
}

void keyPressed() {
    if(key == 's' || key == 'S') {
        test.heading += 10;
    }
}
