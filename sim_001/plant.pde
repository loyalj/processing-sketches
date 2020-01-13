class Plant {
  public PVector position;
  public float radius, energy;
  HSBColor bodyFill, bodyStroke;
  float bodyStrokeWt;
  ArrayList<PVector> points = new ArrayList<PVector>();

  Plant(float x, float y, float r) {
    this.position = new PVector(x, y);
    this.radius = r;
    this.energy = random(200, 1000);

    this.bodyFill = new HSBColor(90, 0.5, 1.0);
    this.bodyStroke = new HSBColor(90, 1.0, 1.0);
    this.bodyStrokeWt = 2;
  }

  void draw(PGraphics surface, Viewport vp) {
    if (((this.position.x + this.radius + vp.x) * vp.zoom > 0 && (this.position.x - this.radius + vp.x) * vp.zoom < surface.width) && ((this.position.y + this.radius + vp.y) * vp.zoom > 0 && (this.position.y - this.radius + vp.y) * vp.zoom < surface.height)) {
      surface.beginDraw();
      surface.ellipseMode(RADIUS);
      surface.colorMode(HSB, 360, 1.0, 1.0, 1.0);

      surface.fill(this.bodyFill.h, this.bodyFill.s, this.bodyFill.b, this.bodyFill.a);
      surface.noStroke();

      surface.translate((this.position.x + vp.x) * vp.zoom, (this.position.y + vp.y) * vp.zoom);
      surface.ellipse(0, 0, this.radius * vp.zoom, this.radius * vp.zoom);
      surface.endDraw();
    }
  }
}