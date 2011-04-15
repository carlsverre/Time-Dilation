class BasicAnimation extends Effect {
  FrameList frames;
  boolean recording;
  boolean display;
  int spread;
  int index;
  
  Rectangle progress;
  
  int[] frameIndices;
  
  String getName() {
    return "Basic Animation Processor";
  }
  
  void start() {
    super.start();
    
    frames = new FrameList();
    frameIndices = new int[width];
    spread = 1;
    progress = new Rectangle(10,height-10-30,1,30);
    
    for(int i = 0; i < height; i++) {
      PImage frame = createImage(width,height,RGB);
      frames.add(frame);
      frameIndices[i] = 0;
    }
    
    recording = false;
    display = false;
  }
  
  void exportFrame() {
    if(!recording && frames != null && frames.size() > 0) {
      println("Exporting animation to movie");
      MovieMaker mm = new MovieMaker(APP,width,height,"animation_"+floor(random(100))+".mov");
      for(int i = 0; i < frames.size(); i++) {
        PImage f = frames.get(i);
        image(f,0,0);
        //graphicsBuffer.copy(f,0,0,width,height,0,0,width,height);
        mm.addFrame();
      }
      mm.finish();
    }
  }
  
  void keyPressed() {
    switch(key) {
      case 'r':
        if(!display) recording = true;
        break;
      case 'd':
        if(!recording && !display) {
          display = true;
          index = 0;
        } else if(display && !recording) {
          display = false;
        }
        break;
    }
  }
  
  void process(PImage frame) {
    super.process(frame); // initialize frame
    
    if(recording) {
      for(int i = 0; i < frame.height; i++) {
        PImage f = frames.get(i);
        int index = frameIndices[i];
        f.copy(frame,0,i,width,spread,0,index,width,spread);
        
        frameIndices[i]++;
      }
      
      index++;
      if(index >= height) {
        recording = false;
      }
      
      progress.incrWidth(1);
      progress.draw(graphicsBuffer,frame, 0xff000000);
    } else if(display) {
      PImage f = frames.get(index);
      index = (index + 1) % height;
      frame.copy(f,0,0,width,height,0,0,width,height);
    }
  }
}