void setup() {
    size(1000, 800);
    pixelDensity(displayDensity());
    colorMode(HSB, 1.0);

    background(0.5);

    for(int x = -(width/2); x < (width/2); x += 200) {
        for(int y = -(height/2); y < (height/2); y += 200) {
            drawLeaf(x + 100, y + 50, 0);
        }
    }
}


void drawLeaf(int x, int y, float angle) {
    int baseWidth = int(random(5, 20));
    int topWidth = int(random(15, 50));
    int leafLength = int(random(50, 100));

    pushMatrix();
    translate(width/2, height/2);
    rotate(angle);

    //noFill();
    fill(0.4, 0.5, 1.0);
    stroke(0.0, 0.0, 1.0);

    beginShape();
    vertex(x, y);
    bezierVertex(x + baseWidth, y, x + topWidth, y + leafLength, x, y + leafLength);
    bezierVertex(x - topWidth, y + leafLength, x - baseWidth, y, x, y);

    endShape();
    popMatrix();
}
