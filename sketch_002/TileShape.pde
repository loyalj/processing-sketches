class TileShape extends TileBase {
    public String tileFile;
    public PShape tileShape;

    TileShape(float x, float y, String _filename) {
        super(x, y);

        this.loadTile(_filename);
    }

    TileShape (float x, float y, float _rotation, String _filename) {
        super(x, y, _rotation);

        this.loadTile(_filename);
    }

    TileShape (float x, float y, float w, float h, String _filename) {
        super(x, y, w, h, 0);

        this.loadTile(_filename);
    }

    TileShape (float x, float y, float w, float h, float _rotation, String _filename) {
        super(x, y, h, w, _rotation);

        this.loadTile(_filename);
    }

    TileShape (float x, float y, float w, float h, float _rotation, color _fillColor, String _filename) {
        super(x, y, w, h, _rotation, _fillColor);

        this.loadTile(_filename);
    }



    public TileShape copy() {
        return new TileShape(position.x, position.y, dimensions.x, dimensions.y, rotation, fillColor, tileFile);
    }



    public void draw() {
        push(); 
        {
            fill(fillColor);
            noStroke();

            translate(position.x, position.y);
            rotate(radians(rotation));
            scale(scale, scale);
            
            rectMode(CENTER);

            tileShape.disableStyle();
            shapeMode(CENTER);
            shape(tileShape, 0, 0, dimensions.x, dimensions.y);


            if (debug) {
                noFill();
                stroke(0, 100, 100);
                rect(0, 0, dimensions.x, dimensions.y);
            }
        } 
        pop();
    }



    public void loadTile(String _filename) {
        tileShape = loadShape(_filename);
        tileFile = _filename;
    }
}
