class Entity {
    public PVector position;
    public float heading;
    
    Entity() {
        position = new PVector();
        heading = 0;
    }
    
    public void draw() {
        push();
            fill(color(0, 100, 100, 50));
            stroke(color(0, 0, 100));
            
            translate(this.position.x, this.position.y);
            rotate(radians(this.heading));
            
            rectMode(CENTER);
            square(0, 0, 50);
        pop();
    }
}
