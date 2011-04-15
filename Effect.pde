class Effect {
  PImage internalBuffer;
  PGraphics graphicsBuffer;
  boolean justStarted;
  
  Effect() {
    
  }
  
  String getName() {
    return "Unnamed Effect";
  }
  
  void start() {
    println("Starting effect named: " + getName());
    internalBuffer = createImage(width, height, RGB);
    graphicsBuffer = createGraphics(width, height, P2D);
    justStarted = true;
  }
  
  void mousePressed() {
    
  }
  
  void mouseDragged() {
    
  }
  
  void mouseReleased() {
    
  }
  
  void keyPressed() {
    
  }
  
  void exportFrame() {
    saveFrame("frames/frame-####.png");
  }
  
  void process(PImage frame) {
    if(justStarted) {
      internalBuffer.copy(frame,0,0,width,height,0,0,width,height);
      justStarted = false;
    }
  }
}