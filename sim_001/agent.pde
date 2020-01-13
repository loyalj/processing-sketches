class Agent {
  PVector velocity, position, lookAtPos;
  float radius, heading, targetHeading, turnSpeed, energy, energyBurn, minEnergy, maxEnergy, scanDist, moveTimer, scanInterval;
  int turnDirection;
  HSBColor bodyFill, bodyStroke, eyeFill, eyeStroke, pupilFill, pupilStroke;
  float bodyStrokeWt, eyeStrokeWt, pupilStrokeWt, eyeRightAngle, eyeLeftAngle;
  boolean hasTarget;
  AgentState currentState;

  Agent() {
    this(0, 0, 10);
  }

  Agent(float x, float y, float r) {
    this.position = new PVector(x, y);
    this.radius = r;
    this.heading = 180;
    this.targetHeading = random(0, 360);
    this.hasTarget = false;
    this.turnSpeed = 30.0/360.0;
    this.turnDirection = 1;
    this.velocity = PVector.fromAngle(radians(this.heading)).mult(5);
    this.energy = 10000;
    this.minEnergy = 1000;
    this.maxEnergy = 20000;
    this.energyBurn = 10;
    this.scanDist = 5000;
    this.moveTimer = 0;
    this.scanInterval = 2;

    this.eyeRightAngle = 0;
    this.eyeLeftAngle = 0;
    this.lookAtPos = new PVector(0, 0);
    this.lookAt(this.lookAtPos.x, this.lookAtPos.y, 1.0);

    this.bodyFill = new HSBColor(0, 0.5, 1.0);
    this.bodyStroke = new HSBColor(0, 1.0, 1.0);
    this.bodyStrokeWt = 5;

    this.eyeFill = new HSBColor(0, 0, 1.0);
    this.eyeStroke = new HSBColor(0, 0, 0, 0.5);
    this.eyeStrokeWt = 1;

    this.pupilFill = new HSBColor(0, 0, 0);
    this.pupilStroke = new HSBColor(180, 1.0, 1.0);
    this.pupilStrokeWt = this.radius/12;

    this.currentState = AgentState.SCANNING;
  }



  /**************|| Mouse Move Event ||**************************************
   *| - Inform the Agent system that the mouse moved by passing in the x,y, & zoom info
   *| - This needs to be updated to make the caller pre-cal the zoom, so it doesn't 
   *|     need to be passed into this method
   ***************************************************************************/
  public void mouseMove(float x, float y, float zoom) {
    //this.lookAt(x, y, zoom);
  }



  /**************|| Look at w/zoom ||**************************************
   *| - This will figure out the eye angle to set so that the agent is looking at
   *|      the specified x, y
   *| - It takes the zoom factor because the x y it gets are a screen x y 
   *| - This should be changed so that look at uses only local x y, not screen
   *| - At that point, this method can be removed
   ***************************************************************************/
  void lookAt(float x, float y, float zoom) {
    this.lookAtPos.x = x;
    this.lookAtPos.y = y;

    this.eyeLeftAngle = atan2(y - this.position.y * zoom, x - this.position.x * zoom);
    this.eyeRightAngle = this.eyeLeftAngle;
  }



  /**************|| Look at w/zoom ||**************************************
   *| - This will figure out the eye angle to set so that the agent is looking at
   *|      the specified x, y
   *| - It takes the zoom factor because the x y it gets are a screen x y 
   *| - This should be changed so that look at uses only local x y, not screen
   *| - At that point, this method can be removed
   ***************************************************************************/
  void lookAt(float x, float y) {
    this.lookAtPos.x = x;
    this.lookAtPos.y = y;

    this.eyeLeftAngle = atan2(y - this.position.y, x - this.position.x);
    this.eyeRightAngle = this.eyeLeftAngle;
  }



  /**************|| Plant Eat Event ||**************************************
   *| - 
   ***************************************************************************/
  public void atePlant(float plantEnergy) {
    this.energy = this.energy + plantEnergy;
    this.energy = constrain(this.energy, 0, this.maxEnergy);
    this.hasTarget = false;
    this.currentState = AgentState.IDLE;
  }



  /**************|| Energy Burn Calculator ||********************************
   *| - 
   ***************************************************************************/
  void burnEnergy(float burnMultiplier, float delta) {
    this.energy = this.energy - (this.energyBurn * burnMultiplier * delta);
    //println(this.energy);
  }



  /**************|| Main Update Event ||*************************************
   *| - 
   ***************************************************************************/
  void update(float delta, AgentSystem _as) {

    switch(this.currentState) {
    case IDLE:          
      if (this.hasTarget) {
        this.currentState = AgentState.TURNING;
      } else {
        this.currentState = AgentState.SCANNING;
      }
      this.burnEnergy(1, delta);
      break;

    case MOVING:
      this.velocity = PVector.fromAngle(radians(this.heading)).mult(80);
      this.position.x = this.position.x + this.velocity.x * delta;
      this.position.y = this.position.y + this.velocity.y * delta;
      this.burnEnergy(10, delta);
      this.moveTimer += delta;
      
      // If the agent has been moving for awhile
      // It will stop and scan it's surroundings 
      if(this.moveTimer > this.scanInterval) {
        this.moveTimer = 0;
        this.currentState = AgentState.SCANNING;
      }
      break;

    case TURNING:
      this.burnEnergy(1.25, delta);
      this.turn(); 

      break;

    case SCANNING:
      this.burnEnergy(2, delta);
      this.scan(_as);
      break;
    }
  }



  /**************|| Turning State Logic ||*************************************
   *| - 
   ***************************************************************************/
  void turn() {
    if (this.heading != this.targetHeading) {
      this.heading = lerp(this.heading, this.targetHeading, this.turnSpeed); 
      if (abs(this.heading - this.targetHeading) < 1.0) {
        this.moveTimer = 0;
        this.currentState = AgentState.MOVING;
      }
    }
  }



  /**************|| Scanning State Logic ||**********************************
   *| - 
   ***************************************************************************/
  void scan(AgentSystem _as) {
    // Look for plants
    this.hasTarget = false;
    float currentDist = this.scanDist;
    int currentPlant = -1;

    for (int i = 0; i < _as.plants.size(); i++) {
      Plant p = _as.plants.get(i);
      float td = this.position.dist(p.position);

      if (td < currentDist) {
        this.hasTarget = true;
        currentPlant = i;
        currentDist = td;
      }
    }

    if (this.hasTarget) {
      PVector pPos = _as.plants.get(currentPlant).position;
      this.lookAt(pPos.x, pPos.y);
      this.targetHeading = degrees(atan2(pPos.y - this.position.y, pPos.x - this.position.x));
    }
    this.currentState = AgentState.TURNING;
  }


  /**************|| Main Draw Event ||***************************************
   *| - 
   ***************************************************************************/
  void draw(PGraphics surface, float xOff, float yOff, float zoom) {
    if (((this.position.x + this.radius + xOff) * zoom > 0 && (this.position.x - this.radius + xOff) * zoom < surface.width) && ((this.position.y + this.radius + yOff) * zoom > 0 && (this.position.y - this.radius + yOff) * zoom < surface.height)) {
      surface.beginDraw(); 
      {
        surface.ellipseMode(RADIUS);
        surface.colorMode(HSB, 360, 1.0, 1.0, 1.0);

        // Draw Target Heading
        surface.pushMatrix(); 
        {
          surface.stroke(255);
          surface.strokeWeight(2);
          surface.translate((this.position.x + xOff) * zoom, (this.position.y + yOff) * zoom);
          surface.rotate(radians(this.targetHeading));
          surface.line(0, 0, this.radius*3*zoom, 0);
        }
        surface.popMatrix();

        // Draw Body
        surface.pushMatrix(); 
        {
          surface.fill(this.bodyFill.h, this.bodyFill.s, this.bodyFill.b, this.bodyFill.a);
          surface.stroke(this.bodyStroke.h, this.bodyStroke.s, this.bodyStroke.b, this.bodyStroke.a);
          surface.strokeWeight(this.bodyStrokeWt * zoom);

          surface.translate((this.position.x + xOff) * zoom, (this.position.y + yOff) * zoom);
          surface.rotate(radians(this.heading));
          surface.ellipse(0, 0, this.radius * zoom, this.radius * zoom);

          // Draw Right Eye
          surface.pushMatrix(); 
          {
            surface.translate(((this.radius/2)*zoom)*cos(radians(45)), ((this.radius/2)*zoom)*sin(radians(45)));
            this.drawEye(surface, this.eyeRightAngle, zoom);
          } 
          surface.popMatrix();

          // Draw Left Eye
          surface.pushMatrix(); 
          {
            surface.translate( ((this.radius/2)*zoom)*cos(radians(-45)), ((this.radius/2)*zoom)*sin(radians(-45))); 
            this.drawEye(surface, this.eyeLeftAngle, zoom);
          } 
          surface.popMatrix();
        } 
        surface.popMatrix();
      } 
      surface.endDraw();
    }
  }


  /**************|| Draw the Eye Balls ||************************************
   *| - 
   ***************************************************************************/
  void drawEye(PGraphics surface, float angle, float zoom) {
    // Outer
    surface.fill(this.eyeFill.h, this.eyeFill.s, this.eyeFill.b, this.eyeFill.a);
    surface.stroke(this.eyeStroke.h, this.eyeStroke.s, this.eyeStroke.b, this.eyeStroke.a);
    surface.strokeWeight(this.eyeStrokeWt * zoom);
    surface.ellipse(0, 0, (this.radius/3) * zoom, (this.radius/3) * zoom);

    // Inner
    surface.translate(((this.radius/8)* zoom)*cos(angle - radians(this.heading)), ((this.radius/8)* zoom)*sin(angle - radians(this.heading)));
    surface.fill(this.pupilFill.h, this.pupilFill.s, this.pupilFill.b, this.pupilFill.a);
    surface.stroke(this.pupilStroke.h, this.pupilStroke.s, this.pupilStroke.b, this.pupilStroke.a);
    surface.strokeWeight(this.pupilStrokeWt * zoom);
    surface.ellipse(0, 0, (this.radius/6)* zoom, (this.radius/6) * zoom);
  }
}