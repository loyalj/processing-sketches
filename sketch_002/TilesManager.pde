import java.util.Collections;

class TilesManager {
    public ArrayList<TileBase> tiles = new ArrayList<TileBase>();

    public int addTile(TileBase _tile) {
        tiles.add(_tile);
        return tiles.size() - 1;
    }
    
    public void shuffle() {
         Collections.shuffle(tiles);   
    }

    public void draw() {
        for (TileBase tile : tiles) {
            tile.draw();
        }
    }

    public void splitTile(int index) {
        TileBase originalTile = tiles.get(index);
        TileBase newTile;

        // Top Left Tile
        newTile = originalTile.copy();
        newTile.position.x -= (originalTile.dimensions.x/4) * originalTile.scale;
        newTile.position.y -= (originalTile.dimensions.y/4) * originalTile.scale;
        newTile.rotation = 90.0 * int(random(0, 4));
        newTile.scale = originalTile.scale * 0.5;

        tiles.add(index + 1, newTile);

        // Top Right Tile
        newTile = originalTile.copy();

        newTile.position.x += (originalTile.dimensions.x/4) * originalTile.scale;
        newTile.position.y -= (originalTile.dimensions.y/4) * originalTile.scale;
        newTile.rotation = 90.0 * int(random(0, 4));
        newTile.scale = originalTile.scale * 0.5;

        tiles.add(index + 1, newTile);


        // Bottom Left Tile
        newTile = originalTile.copy();

        newTile.position.x -= (originalTile.dimensions.x/4) * originalTile.scale;
        newTile.position.y += (originalTile.dimensions.y/4) * originalTile.scale;
        newTile.rotation = 90.0 * int(random(0, 4));
        newTile.scale = originalTile.scale * 0.5;

        tiles.add(index + 1, newTile);

        // Bottom Right Tile
        newTile = originalTile.copy();

        newTile.position.x += (originalTile.dimensions.x/4) * originalTile.scale;
        newTile.position.y += (originalTile.dimensions.y/4) * originalTile.scale;
        newTile.rotation = 90.0 * int(random(0, 4));
        newTile.scale = originalTile.scale * 0.5;

        tiles.add(index + 1, newTile);


        // Remove the parent tile now that children have taken its place
        tiles.remove(index);
    }
}
