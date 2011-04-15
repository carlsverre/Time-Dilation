class FrameList {
  ArrayList frames;
  
  FrameList() {
    frames = new ArrayList();
  }
  
  int size() {
    return frames.size();
  }
  
  PImage get(int i) {
    if(i < 0 || i >= frames.size()) exit();
    return (PImage) frames.get(i);
  }
  
  PImage last() {
    if(frames.size() == 0) exit();
    return (PImage) frames.get(frames.size()-1);
  }
  
  void add(PImage frame) {
    frames.add(frame);
  }
  
  void captureFrom(Capture camera) {
    PImage pi = createImage(camera.width,camera.height,ARGB);
    pi.copy(camera, 0,0,camera.width,camera.height, 0,0,pi.width,pi.height);
    frames.add(pi);
  }
  
  void keep(int n) {
    n = frames.size() - n;
    if (n <= 0) return;
    while(n > 0) {
      frames.remove(0);
      n--;
    }
  }
}