class TileMapViewport {
    public IntVector position, dimensions, gridPosition;
    int moveSpeed = 5;

    TileMapViewport() {
        position = new IntVector(128, 128);
        dimensions = new IntVector(1280, 720);
        gridPosition = new IntVector(0, 0);
    }
    
    public void move(float _x, float _y) {
         position.x += int(moveSpeed * _x);
         position.y += int(moveSpeed * _y);
         
         gridPosition.x = position.x / 128;
         gridPosition.y = position.y / 128;
    }

    void draw() {

        push(); 
        {
            translate(position.x, position.y);
            noFill();
            strokeWeight(5);
            stroke(0, 100, 100);
            rect(0, 0, dimensions.x, dimensions.y);
        }
        pop();
    }
}
