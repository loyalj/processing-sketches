import processing.svg.*;

TilesManager tileManager;
boolean imageUpdate = true;


void setup() {
    size(1280, 720);
    pixelDensity(displayDensity());
    colorMode(HSB, 360, 100, 100, 100);

    generate();
    //noLoop();
}

void draw() {
    if (imageUpdate) {
        background(backgroundColor);
        tileManager.draw();
        imageUpdate = false;
        endRecord();
    }
}

void keyReleased() {
    generate();
    imageUpdate = true;
}
