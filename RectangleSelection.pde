int RS_MODE_DRAWRECTS     = 1;
int RS_MODE_TIMELAPSE     = 2;

class RectangleSelection extends Effect {
  ArrayList rectangles;
  Rectangle currentRectangle;
  
  int rectangleRenderNum;
  int[] renderIndices;
  
  int spread = 1;
  int mode;
  
  String getName() {
    return "Rectangle Selection Effect";
  }
  
  void start() {
    super.start();
    rectangles = new ArrayList();
    goModeDrawRects();
  }
  
  void goModeDrawRects() {
    mode = RS_MODE_DRAWRECTS;
    currentRectangle = null;
    justStarted = true;
  }
  
  void goModeTimelapse() {
    renderIndices = new int[rectangles.size()];
    for(int i = 0; i < renderIndices.length; i++) {
      renderIndices[i] = 0;
    }
    mode = RS_MODE_TIMELAPSE;
    rectangleRenderNum = 1;
    justStarted = true;
  }
  
  void keyPressed() {
    switch(key) {
      case 's':
        if(mode != RS_MODE_TIMELAPSE) goModeTimelapse();
        break;
      case 'd':
        if(mode != RS_MODE_DRAWRECTS) goModeDrawRects();
        break;
      case 'a':
        if(rectangleRenderNum < rectangles.size()) rectangleRenderNum++;
        break;
      case 'r':
        if(rectangles.size() > 0)
          rectangles.remove(rectangles.size() - 1); 
        break;
    }
  }
  
  void mousePressed() {
    if(mode == RS_MODE_DRAWRECTS && currentRectangle == null) {
      currentRectangle = new Rectangle(mouseX, mouseY, 1, 1);
    }
  }
  
  void mouseDragged() {
    if(mode == RS_MODE_DRAWRECTS && currentRectangle != null) {
      currentRectangle.setBottomRight(mouseX, mouseY);
    }
  }
  
  void mouseReleased() {
    if(mode == RS_MODE_DRAWRECTS && currentRectangle != null) {
      rectangles.add(currentRectangle);
      currentRectangle = null;
    }
  }
  
  void process(PImage frame) {
    int i;
    
    super.process(frame); // set up the internalBuffer
    
    if(mode == RS_MODE_DRAWRECTS) {
      internalBuffer.copy(frame,0,0,width,height,0,0,width,height);
      
      if(currentRectangle != null) {
        currentRectangle.draw(graphicsBuffer, internalBuffer);
      }
      
      for(i = 0; i < rectangles.size(); i++) {
        ((Rectangle)rectangles.get(i)).draw(graphicsBuffer, internalBuffer);
      }
    } else {
      for(i = 0; i < rectangleRenderNum; i++) {
        Rectangle r = ((Rectangle)rectangles.get(i));
        int index = renderIndices[i];
        
        if(index >= r.h) {
          continue;
        }
        
        internalBuffer.copy(frame,r.left(),r.top()+index,r.w,spread,r.left(),r.top()+index,r.w,spread);
        
        renderIndices[i]++;
      }
    }
    
    frame.copy(internalBuffer,0,0,width,height,0,0,width,height);
  }
}
















