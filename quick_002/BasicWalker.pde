class BasicWalker extends Walker {
    
    color strokeColor;

    BasicWalker() {
        super();
    }

    BasicWalker(int _x, int _y) {
        this();

        position.x = _x;
        position.y = _y;
    }
    
    BasicWalker(int _x, int _y, color _strokeColor) {
        this();

        position.x = _x;
        position.y = _y;
        
        strokeColor = _strokeColor;
    }

    public void update() {
        int xAdj = irandom(-2, 2);
        int yAdj = irandom(-2, 2);
        
        position.x += xAdj;
        position.y += yAdj;
    }

    public void draw() {
        push(); 
        {
            translate(position.x, position.y);
            stroke(strokeColor);
            point(0, 0);
        } pop();
    }
}
