class HSBColor {
  public float h, s, b, a;
  
  HSBColor() {
    this(0, 1.0, 1.0, 1.0);  
  }
  
  HSBColor(float h, float s, float b) {
    this(h, s, b, 1.0);  
  }
  
  HSBColor(float h, float s, float b, float a) {
    this.h = h;
    this.b = b;
    this.s = s;
    this.a = a;
  }
}