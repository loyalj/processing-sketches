WalkerFarm farm;

void setup() {

    size(1280, 720);
    pixelDensity(displayDensity());
    colorMode(HSB, 360, 100, 100, 100);

    farm = new WalkerFarm(0, 0, width, height);

    background(0);
}


void draw() {
    farm.draw();
}
