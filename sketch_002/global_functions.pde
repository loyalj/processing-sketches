color backgroundColor, foregroundColor, foregroundColor2; 
int seed = 0;



void generate() {
    seed = int(random(-214748364, 214748364));
    randomSeed(seed);
    beginRecord(SVG, "output/tile-experiment_S" + seed + ".svg");
    
    backgroundColor = color(random(0, 360), random(50, 75), 100);
    foregroundColor = color(random(0, 360), 100, 100);
    foregroundColor2 = color(random(0, 360), 100, 100);
    //foregroundColor2 = foregroundColor;


    tileManager = new TilesManager();

    int tileWidth = int(random(40, 400));
    int tileHeight = tileWidth;

    for (int x = tileWidth/2; x < width + tileWidth; x += tileWidth) {
        for (int y = tileHeight/2; y < height + tileHeight; y += tileHeight) {
            int rot = 0;
            int lastIndex = 0;
            // Add the 90 degree lines tiles
            if (random(0, 100) > 20) {
                rot = 105 * int(random(0, 4));
                lastIndex = tileManager.addTile(new TileBase(x, y, tileWidth, tileHeight, rot, foregroundColor));


                for (int attempts = 0; attempts < 3; attempts++) {
                    if (random(0, 100) > 90) {
                        tileManager.splitTile(int(random(lastIndex, tileManager.tiles.size() - 1)));
                    }
                }
            }

            // Add the arc tiles
            if (random(0, 100) > 50) {
                rot = 90 * int(random(0, 4));
                TileShape svgTile = new TileShape(x, y, tileWidth, tileHeight, rot, foregroundColor2, "square.svg");
                lastIndex = tileManager.addTile(svgTile);

                for (int attempts = 0; attempts < 3; attempts++) {
                    if (random(0, 100) > 75) {
                        tileManager.splitTile(int(random(lastIndex, tileManager.tiles.size() - 1)));
                    }
                }
            }
        }
    }

    tileManager.shuffle();
}
