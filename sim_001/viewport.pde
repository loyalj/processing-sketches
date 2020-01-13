class Viewport {
 public int l, r, t, b, gridResolution;
 public float x, y, zoom, minZoom, maxZoom, zoomSpeed;
 public PGraphics surface;
 
 Viewport(float x, float y, int l, int r, int t, int b, float z, float mnz, float mxz, float zs, int gr) {
   this.x = x * z;
   this.y = y * z;
   
   this.zoom = z;
   this.minZoom = mnz;
   this.maxZoom = mxz;
   this.zoomSpeed = zs;
   
   this.gridResolution = gr;
   
   this.l = l;
   this.r = r;
   this.t = t;
   this.b = b;
   
   this.surface = createGraphics(width, height);
 }
 
 
 
 void draw() {
   this.surface.beginDraw();
      this.surface.clear();
      this.surface.stroke(255, 125);
      
      // Vertical (horizon) grid lines
      for(int gX = this.l; gX <= this.r; gX = gX + this.gridResolution) {
        if((this.x + gX) * this.zoom > 0 && (this.x + gX) * this.zoom < surface.width) {
          // Draw a grid line
          this.surface.line((this.x + gX) * this.zoom, (this.y + this.b) * this.zoom, (this.x + gX) * this.zoom, (this.y + this.t) * this.zoom);
         
          // Draw center line
          if(this.x + gX == this.x) {
            this.surface.strokeWeight(10);
            this.surface.line(this.x * this.zoom, (this.y + this.b) * this.zoom, this.x * this.zoom, (this.y + this.t) * this.zoom);
            this.surface.strokeWeight(1);
          }
        }
      }
      
      // Horizontal grid lines
      for(int gY = this.t; gY <= this.b; gY = gY + this.gridResolution) {
        if((this.y + gY) * this.zoom > 0 && (this.y + gY) * this.zoom < surface.height) {
          // Draw a grid line
          this.surface.line((this.x + this.l) * this.zoom, (this.y + gY) * this.zoom, (this.x + this.r) * this.zoom, (this.y + gY) * this.zoom);
          
          // Draw center line
          if(this.y + gY == this.y) {
            this.surface.strokeWeight(10);
            this.surface.line((this.x + this.l) * this.zoom, this.y * this.zoom, (this.x + this.r) * this.zoom, this.y * this.zoom); 
            this.surface.strokeWeight(1);
          }
        }
      }
      
      this.surface.noFill();
      this.surface.stroke(0,255,0);
      this.surface.rect((this.x + this.l) * this.zoom, (this.y + this.t) * this.zoom, (this.r - this.l) * this.zoom, (this.b - this.t) * this.zoom);
    this.surface.endDraw();
    image(surface, 0, 0);
 }
}