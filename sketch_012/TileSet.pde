/***************
 
/***************/
class TileSet {
    JSONObject jsonData;

    PImage tileSheet;
    String tileSheetFilepath;

    IntVector sheetDimensions;
    public IntVector tileDimensions;

    ArrayList<Tile> tiles;

    /***************
     
    /***************/
    TileSet() {
        clearTileSet();
    }

    /***************
     
    /***************/
    public void clearTileSet() {
        jsonData = new JSONObject();
        tileSheet = createImage(1, 1, HSB);
        tileSheetFilepath = "";
        sheetDimensions = new IntVector(0, 0);
        tileDimensions = new IntVector(0, 0);
        tiles = new ArrayList<Tile>();
    }

    /***************
     
    /***************/
    public void loadTileSet(String filename) {
        jsonData = loadJSONObject(filename);

        loadProperties();

        tileSheet = loadImage(tileSheetFilepath);

        JSONArray tileData = jsonData.getJSONArray("tiles");

        for (int i = 0; i < tileData.size(); i++) {        
            Tile newTile = new Tile(0, 0, tileDimensions.x, tileDimensions.y);

            // Get the portion of the tilesheet for this tile and trim it out to a new image
            PImage tileImage = createImage(tileDimensions.x, tileDimensions.y, HSB);

            int iY = (i / (sheetDimensions.x/tileDimensions.x));
            int iX = (i % (sheetDimensions.x/tileDimensions.x));

            tileImage.copy(tileSheet, iX * tileDimensions.x, iY * tileDimensions.y, tileDimensions.x, tileDimensions.y, 0, 0, tileDimensions.x, tileDimensions.y);
            newTile.setTileImage(tileImage);

            tiles.add(newTile);
        }
    }



    void loadProperties() {
        tileDimensions.x = jsonData.getInt("tilewidth");
        tileDimensions.y = jsonData.getInt("tileheight");

        sheetDimensions.x = jsonData.getInt("imagewidth");
        sheetDimensions.y = jsonData.getInt("imageheight");

        JSONArray properties = jsonData.getJSONArray("properties");

        for (int i = 0; i < properties.size(); i++) {
            JSONObject prop = properties.getJSONObject(i);

            if (prop.getString("name").equals("filepath")) {
                tileSheetFilepath = prop.getString("value");
            }
        }
    }

    public int size() {
        return tiles.size();
    }

    /***************
     
    /***************/
    public void draw() {
        push(); 
        {
            image(tileSheet, 0, 0);
        } 
        pop();
    }

    /***************
     
    /***************/
    public void drawTile(int _x, int _y, int _tileIndex) {
        push(); 
        {
            translate(_x, _y);
            tiles.get(_tileIndex).draw();
        } 
        pop();
    }
}
