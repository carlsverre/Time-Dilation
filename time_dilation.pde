import processing.video.*;
Capture myCapture;

int WIDTH = 640;
int HEIGHT = 480;

FrameList frames;
Effect currentEffect = null;

int effectIndex = 0;
Effect[] effects = {
  null,
  new BasicSlitScreen(),
  new RectangleSelection(),
  new BasicAnimation()
};

void setup(){
  size(WIDTH,HEIGHT);
  myCapture = new Capture(this, WIDTH, HEIGHT);
  frames = new FrameList(); 
}

void keyPressed() {
  switch(key) {
    case ' ':
      effectIndex = (effectIndex + 1)  % effects.length;
      currentEffect = effects[effectIndex];
      if(currentEffect != null) currentEffect.start();
      break;
    case 'q':
      exit();
      break;
    case 'z':
      if(currentEffect != null) currentEffect.exportFrame();
  }
  if(currentEffect != null) currentEffect.keyPressed();
}

void mousePressed() {
  if(currentEffect != null) currentEffect.mousePressed();
}

void mouseDragged() {
  if(currentEffect != null) currentEffect.mouseDragged();
}

void mouseReleased() {
  if(currentEffect != null) currentEffect.mouseReleased();
}

void captureEvent(Capture myCapture) {
  if(!myCapture.available()) return;
  myCapture.read();
  frames.captureFrom(myCapture);
  
  PImage pi = frames.last();
  if(currentEffect != null) currentEffect.process(pi);
}

void draw() {
  background(0);
  PImage pi = frames.last();
  copy(pi,0,0,pi.width,pi.height,0,0,width,height);
  frames.keep(30);
}
