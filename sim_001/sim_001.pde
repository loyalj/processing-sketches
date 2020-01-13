AgentSystem aSys;
Viewport vp;
DeltaTimer dt;

/**************|| Main Setup Event ||***************************************
*| - Does some processing stuff to create the canvas,
*|     Canvas size, pixel settings, and a cursor
*| - Create the DeltaTimer object
*| - Sets up a viewport and an agent system
***************************************************************************/
void setup() {
  // Setup the app environment
  size(1000, 800, P2D);
  pixelDensity(displayDensity());
  smooth(2);
  cursor(HAND);
  
  // Create deltatimer
  dt = new DeltaTimer();
  
  // Create the viewport object
  // X, Y, Left Bound, Right Bound, Top Bound, Bottom Bound, Zoom, minZoom, MaxZoom, zoomSpeed
  vp = new Viewport((width/2), (height/2), -2500, 2500, -2500, 2500, 1.0, 0.125, 4, 0.01, 50);
  
  // Create an agent System
  aSys = new AgentSystem();
}


/**************|| Main Draw Event ||***************************************
*| - Updates the delta timer
*| - Updates the agent system
*| - Fills the canvas with the background colour
*| - Draws the viewport grid
*| - Draws the agent system
***************************************************************************/
void draw() {
  dt.update();
  aSys.update(dt.delta);
  
  background(0);
  vp.draw();
  aSys.draw(vp);
}


/**************|| Mouse Move Event ||**************************************
*| - Inform the Agent system that the mouse moved by passing in the x,y, & zoom info
***************************************************************************/
void mouseMoved() {
  aSys.mouseMove(mouseX - vp.x * vp.zoom, mouseY - vp.y * vp.zoom, vp);
}


/**************|| Mouse Drag Event ||**************************************
*| - Calc how far the mouse has moved in screen pixels,
*|     translate viewport center x,y by that distance, taking zoom into account
***************************************************************************/
void mouseDragged() {
    vp.x = vp.x + (mouseX - pmouseX) * (1 / vp.zoom);
    vp.y = vp.y + (mouseY - pmouseY) * (1 / vp.zoom); 
    
    vp.x = constrain(vp.x, -vp.r + width / vp.zoom - 15 / vp.zoom, -vp.l + 15 / vp.zoom);
    vp.y = constrain(vp.y, -vp.b + height / vp.zoom - 15 / vp.zoom, -vp.t + 15 / vp.zoom);
}


/**************|| Mouse Wheel Event ||**************************************
*| - e is some value usually somewhere between -8 and +8 that represents,
*|     how fast the mousewheel is moving, and in which direction
*| - Viewport zoom is updated when the mouse wheel moves,
*}     the speed is controlled by zoomSpeed to compensate for changing pixel size
*|     the zoom value is constrained by the min and max zoom range
***************************************************************************/
void mouseWheel(MouseEvent event) {
  float e = event.getCount(); 
  
  vp.zoom = vp.zoom + vp.zoomSpeed * e;
  vp.zoom = constrain(vp.zoom, vp.minZoom, vp.maxZoom);
}