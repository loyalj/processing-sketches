class TileMap {
    IntVector dimensions;
    IntVector tileDimensions;
    ArrayList<IntVector> tiles;
    TileSet tileSet;
    TileMapViewport viewport;


    /***************
     
    /***************/
    TileMap() {
        dimensions = new IntVector(1, 1);
        tileDimensions = new IntVector(100, 100);

        clearTiles();
        tileSet = new TileSet();  

        viewport = new TileMapViewport();
    }

    /***************
     
    /***************/
    TileMap(String _filename) {
        this();
        loadTilemap(_filename);
    }

    /***************
     
    /***************/
    TileMap(int _x) {
        this();
        dimensions = new IntVector(_x, 1);
    }

    /***************
     
    /***************/
    TileMap(int _x, int _y) {
        this();
        dimensions = new IntVector(_x, _y);
    }

    /***************
     
    /***************/
    public void loadTileSet(String _filename) {
        tileSet.loadTileSet(_filename);
        setTileDimensions(tileSet.tileDimensions.x, tileSet.tileDimensions.y);
    }

    /***************
     
    /***************/
    void clearTiles() {
        tiles = new ArrayList<IntVector>();
    }

    /***************
     
    /***************/
    public void setSize(int _x, int _y) {
        dimensions.x = _x;
        dimensions.y = _y;
    }


    /***************
     
    /***************/
    public void setTileDimensions(int _x, int _y) {
        tileDimensions.x = _x;
        tileDimensions.y = _y;
    }

    /***************
     
    /***************/
    public IntVector getTile(int _x, int _y) {
        // The grid and tile array all start at 0, as computers do.
        // But, humans tend to start at 1. So this lets humans use 1,1 on a 10x10 grid
        // as the start tile, with 10, 1 being the 10th tile in a 10 wide grid.
        // Instead of 0,0 and 9,0 as the last tile in a row that is 10 wide.
        _x--;
        _y--;

        // Convert the two coordinates into an array list index
        // This implies that the tiles have to be put into the grid in a specific order
        int tileIndex = _x + (_y * dimensions.x);

        // Check the tile index and the individual coordinates
        // This ensures that tilse can't have two addresses.
        // Based on the tile index formula: 10, 0 is the same as 0, 1
        // By checking if x > 9, we prevent this kind of overflow
        boolean checkOutMapBounds = 
            (tileIndex < 0) || 
            (tileIndex >= tiles.size()) ||
            (_x < 0) ||
            (_y < 0) ||
            (_x > dimensions.x - 1) || 
            (_y > dimensions.y - 1);

        // Check if the indexes being passed in are valid, if not return a dummy tile
        if (checkOutMapBounds) {
            return new IntVector(0, 0);
        }

        // Return reference to the requested tile
        return tiles.get(tileIndex);
    }

    /***************
     
    /***************/
    public void draw() {
        push(); 
        {
            translate(-viewport.position.x, -viewport.position.y);

            //for (IntVector t : tiles) {
                // The tiles all know their own position, so all we need to do 
                // Is loop through every tile and tell them to draw themselves
                //tileSet.drawTile(t.x, t.y, t.z);
            //}

            for (int y = viewport.gridPosition.y; y <= viewport.gridPosition.y + 6; y++) {
                for (int x = viewport.gridPosition.x; x <= viewport.gridPosition.x + 10; x++) {
                    int tileIndex = x + (y * dimensions.x);
                    IntVector t = tiles.get(tileIndex);
                    tileSet.drawTile(t.x, t.y, t.z);
                }
            }

            //viewport.draw();
        }
        pop();
    }


    /***************
     
    /***************/
    public void loadTilemap(String _filename) {


        JSONObject mapJSON = loadJSONObject(_filename);
        JSONArray tileIDs = mapJSON.getJSONArray("layers").getJSONObject(0).getJSONArray("data");

        clearTiles();
        setSize(mapJSON.getInt("width"), mapJSON.getInt("height"));
        loadTileSet(mapJSON.getJSONArray("properties").getJSONObject(0).getString("value"));

        for (int y = 0; y <= dimensions.y - 1; y++) {
            for (int x = 0; x <= dimensions.x - 1; x++) {
                IntVector newTile = new IntVector(x * tileDimensions.x, y * tileDimensions.y, tileIDs.getInt(x + y * dimensions.x) - 1);
                tiles.add(newTile);
            }
        }
    }
}
