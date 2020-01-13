class ColorFactory {
  color currentColor, lastColor;
  float currentHue, cycleDistance;
  ColorMode currentMode;
  
  
 ColorFactory() {
     this.currentColor = color(0);
     this.lastColor = color(0);
     this.currentMode = ColorMode.CYCLE;
     this.cycleDistance = 36;
     this.currentHue = 0;
 }
 
 color getCurrentColor() {
   return this.currentColor;
 }
 
 void setColorMode(ColorMode cm) {
   this.currentMode = cm; 
 }
 
 color nextColor() {
   switch(this.currentMode) {
     case CYCLE:
       this.nextCycleColor();
     break;
     
     default:
     case RANDOM:
     case RANDOM_NOREPEAT:
       this.nextRandomColor();
     break;
   }
   
   return this.currentColor;
 }
 
 void nextCycleColor() {
   this.lastColor = this.currentColor;
   this.currentHue = (this.currentHue + this.cycleDistance) % 360;
   this.currentColor = color(this.currentHue, 100, 100, 50);
 }
 
 void nextRandomColor() {
   this.lastColor = this.currentColor;
   this.currentColor = color(random(0, 360), 100, 100, 50);
   
   if(this.currentMode == ColorMode.RANDOM_NOREPEAT) {
     while(this.lastColor == this.currentColor) {
         this.currentColor = color(random(0, 360), 100, 100, 50);
     }
   }
   
   this.currentHue = hue(this.currentColor);
 }
}