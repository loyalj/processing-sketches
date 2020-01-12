class TileBase {
    public PVector position = new PVector();
    public PVector dimensions = new PVector(10, 10);
    public Float rotation = 0.0;
    public float left, top, bottom, right = 0;
    public float scale = 1.0;

    public color fillColor;

    public boolean debug = false;

    TileBase(float x, float y) {
        position = new PVector(x, y);
        dimensions = new PVector(10, 10);
        fillColor = color(0, 0, 0);
    }

    TileBase (float x, float y, float _rotation) {
        this(x, y);

        rotation = _rotation;
    }

    TileBase (float x, float y, float w, float h) {
        this(x, y, w, h, 0);
    }

    TileBase (float x, float y, float w, float h, float _rotation) {
        this(x, y, _rotation);

        dimensions = new PVector(w, h);

        right = dimensions.x/2;
        left = -right;
        bottom = dimensions.y/2;
        top = -bottom;
    }

    TileBase (float x, float y, float w, float h, float _rotation, color _fillColor) {
        this(x, y, w, h, _rotation);

        fillColor = _fillColor;
    }
    
    public TileBase copy() {
        return new TileBase(position.x, position.y, dimensions.x, dimensions.y, rotation, fillColor);
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

            beginShape(); 
            {
                vertex(left, -5 * scale);
                vertex(left, 5 * scale);
                vertex(5 * scale, 5 * scale);
                vertex(5 * scale, -5 * scale);
                vertex(5 * scale, top);
                vertex(-5 * scale, top);
                vertex(-5 * scale, -5 * scale);
            } 
            endShape(CLOSE);


            if (debug) {
                noFill();
                stroke(180, 100, 100);
                rect(0, 0, dimensions.x, dimensions.y);
            }
        } 
        pop();
    }
}
