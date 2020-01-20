TileMap worldMap;

void setup() {
    size(1280, 720);
    pixelDensity(displayDensity());
    colorMode(HSB, 360, 100, 100, 100);

    worldMap = new TileMap("data/maps/map_001.json");
}

void draw() {
    push(); 
    {
        //translate(width/2, height/2);
        //scale(0.25, 0.25);
        background(0, 0, 10);
        worldMap.draw();
        
    } 
    pop();
    
    worldMap.viewport.move(0.2, 0.2);
}
