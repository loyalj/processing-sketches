class NeonRender {

    private PApplet parent;
    private PGraphics canvas;

    public float lineWeight;
    public color lineColor, fillColor;

    NeonRender(PApplet _parent) {
        parent = _parent;
        canvas = createGraphics(parent.width, parent.height);

        lineWeight = 2;
        lineColor = color(333, 99, 79);
        fillColor = color(333, 99, 79, 80);
    }

    public void line(float _startX, float _startY, float _endX, float _endY) {

        canvas.beginDraw(); 
        {
            canvas.background(0);
            canvas.stroke(lineColor);
            //canvas.blendMode(SCREEN);

            canvas.translate(_startX, _startY);

            for (int i = 1; i < 3; i++) {
                canvas.strokeWeight(lineWeight * i);
                canvas.line(0, 0, _endX - _startX, _endY - _startY);
                canvas.filter(BLUR, 2);
            }
            canvas.strokeWeight(lineWeight);            
            canvas.line(0, 0, _endX - _startX, _endY - _startY);
        } 
        canvas.endDraw();

        parent.push(); 
        {
            parent.blendMode(SCREEN);
            parent.image(canvas, 0, 0);
        } 
        parent.pop();
    }

    public void line(float _startX, float _startY, float _startZ, float _endX, float _endY, float _endZ) {
        println("Neon Render has not been implemented in 3D");
    }

    public void rect(float _x, float _y, float _w, float _h) {
        canvas.beginDraw(); 
        {
            canvas.background(0);
            canvas.stroke(lineColor);
            canvas.fill(fillColor);
            canvas.blendMode(SCREEN);

            canvas.translate(_x, _y);

            for (int i = 1; i < 3; i++) {
                canvas.strokeWeight(lineWeight * i);
                canvas.rect(0, 0, _w, _h);
                canvas.filter(BLUR, 2);
            }
            
            canvas.strokeWeight(lineWeight);            
            canvas.rect(0, 0, _w, _h);
        } 
        canvas.endDraw();

        parent.push(); 
        {
            parent.blendMode(ADD);
            parent.image(canvas, 0, 0);
        } 
        parent.pop();
        
    }
}
