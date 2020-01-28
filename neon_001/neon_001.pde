NeonRender neon;

void setup() {

    size(1280, 720);
    pixelDensity(displayDensity());
    colorMode(HSB, 360, 100, 100, 100);

    neon = new NeonRender(this);

    renderScene();
}

void draw() {
}

void keyPressed() {

    if (key == ' ') {
        renderScene();
    }
}


void renderScene() {

    background(0, 0, 0);

    stroke(0, 0, 100);
    strokeWeight(5);

     for (int lines = 0; lines < 20; lines++) {
        float sx = random(10, width - 10);
        float sy =  random(10, height - 10);
        float ex = random(10, width - 10);
        float ey =  random(10, height - 10);

        float hue = random(0, 360);

        neon.lineColor = color(hue, 99, 79);
        neon.fillColor = color(hue, 99, 79, 90);
        neon.line(sx, sy, ex, ey);
    }
    
    for (int rects = 0; rects < 10; rects++) {
        float sx = random(10, width - 10);
        float sy =  random(10, height - 10);
        float w = random(50, 300);
        float h =  random(50, 300);

        float hue = random(0, 360);

        neon.lineColor = color(hue, 99, 79);
        neon.fillColor = color(hue, 99, 79, 90);
        neon.rect(sx, sy, w, h);
    }
}
