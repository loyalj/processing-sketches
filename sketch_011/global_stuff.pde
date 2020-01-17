int xRes = 42, yRes = 30, zRes = 20;
PImage img;

void loadSketch() {
    img = loadImage("show.jpg");
}

void drawSketch() {
    background(0);
    stroke(100);
    push(); 
    {
        drawImage();
        fill(130, 50, 50, 100);
        rect(0, 0, width, height);
        drawLines();
    } 
    pop();
}

void drawImage() {

    image(img, 0, 0);
}


void drawLines() {

    int lastX, lastY;

    push(); 
    {
        stroke(0, 0, 100, 100);
        for (int x = 0; x <= img.width; x += xRes) {

            lastY = 0;
            lastX = x;

            for (int y = 0; y <= img.height; y += yRes) {
                color c = img.get(x, y);
                float b = brightness(c)/100;
                float h = hue(c)/360;

                //int adjX = x + int(random(0, zRes));
                int adjX = x + int(zRes * b);

                
                strokeWeight(2);
                line(lastX, lastY, adjX, y);
                
                strokeWeight(1);
                line(lastX, lastY, x, y);


                lastX = adjX; 
                lastY = y;
            }
        }
    } 
    pop();
}
