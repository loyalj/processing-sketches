class AgentSystem {
  public ArrayList<Agent> agents = new ArrayList<Agent>(); 
  public ArrayList<Plant> plants = new ArrayList<Plant>();
  public PGraphics surface;

  AgentSystem() {
    // Setup the draw layers
    surface = createGraphics(width, height);

    // Setup the agents
    for (int i = 0; i <= 0; i++) {
      agents.add(new Agent(random(-2000, 2000), random(-1000, 1000), 60)); 
    }
    
    // Setup the plants
    for (int i = 0; i <= 4; i++) {
      plants.add(new Plant(random(-2000, 2000), random(-1000, 1000), random(10, 50)));
    }
  }



  /**************|| Main Update Event ||**************************************
   *| - 
   ***************************************************************************/
  public void update(float delta) {
    // Update the agents
    for (int i = 0; i < agents.size(); i++) {
      Agent crAgent = agents.get(i);
      crAgent.update(delta, this);
    }

    // Check for collisions with plants and agents
    for (int i = 0; i < agents.size(); i++) {
      Agent crAgent = agents.get(i);
      
      for (int j = 0; j < plants.size(); j++) {
        Plant crPlant = plants.get(j);
        
        if (crAgent.position.dist(crPlant.position) < (crAgent.radius + crPlant.radius)) {
          crAgent.atePlant(crPlant.energy);
          plants.remove(j);
        }
      }
    }
  }



  /**************|| Main Draw Event ||****************************************
   *| - 
   ***************************************************************************/
  public void draw(Viewport vp) {
    // Clear the agent drawing layer
    surface.beginDraw();
    surface.clear();
    surface.endDraw();

    //Draw all the plants
    for (int i = 0; i < plants.size(); i++) {
      Plant crP = plants.get(i);
      crP.draw(surface, vp);
    }

    // Draw all the agents
    for (int i = 0; i < agents.size(); i++) {
      Agent crAgent = agents.get(i);
      crAgent.draw(surface, vp.x, vp.y, vp.zoom);
    }

    image(surface, 0, 0);
  }


  /**************|| Mouse Move Event ||************************************
   *| - 
   ***************************************************************************/
  public void mouseMove(float x, float y, Viewport vp) {
    for (int i = 0; i < agents.size(); i++) {
      Agent crAgent = agents.get(i);
      crAgent.mouseMove(x, y, vp.zoom);
    }
  }
}