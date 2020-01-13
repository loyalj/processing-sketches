//int texRes = 50;

void noiseFill(int x1, int y1, int x2, int y2) {
  pushStyle();
  noStroke();
  for(int x = x1; x < x2; x = x + texRes) {
    for(int y = y1; y < y2; y= y + texRes) {
      fill(0, 0, random(50, 205), 10);
      rect(x, y, texRes, texRes);
    }
  }
  popStyle();
}