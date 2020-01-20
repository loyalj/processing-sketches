/***************
 
/***************/
class Tile {
    IntVector position;
    IntVector dimensions;

    color fillColor, strokeColor;

    PImage tileImage;
    boolean hasImage;

    /***************
     
    /***************/
    Tile() {
        position = new IntVector(0, 0);
        dimensions = new IntVector(100, 100);
        fillColor = color(120, 100, 50);
        strokeColor = color(0, 0, 100, 10);
        tileImage = createImage(1, 1, HSB);
        hasImage = false;
    }

    /***************
     
    /***************/
    Tile(int _x, int _y) {
        this();
        setDimensions(100, 100);
        setPosition(_x, _y);
    }

    /***************
     
    /***************/
    Tile(int _x, int _y, int _w, int _h) {
        this();
        setDimensions(_w, _h);
        setPosition(_x, _y);
    }

    /***************
     
    /***************/
    public void setDimensions(int _x, int _y) {
        dimensions.x = _x;
        dimensions.y = _y;
    }

    /***************
     
    /***************/
    public void setPosition(int _x, int _y) {
        position.x = _x;
        position.y = _y;
    }

    /***************
     
    /***************/
    public void setFillColor(color _c) {
        fillColor = _c;
    }

    /***************
     
    /***************/
    public void setTileImage(PImage _tileImage) {
        tileImage = _tileImage;
        hasImage = true;
    }

    /***************
     
    /***************/
    public void draw() {

        push(); 
        {
            translate(position.x, position.y);

            if (hasImage) {
                image(tileImage, 0, 0);
            } else {
                fill(fillColor);
                stroke(strokeColor);
                noStroke();

                rect(0, 0, dimensions.x, dimensions.y);
            }
        } 
        pop();
    }
}
