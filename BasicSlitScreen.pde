static int BSS_DIRECTION_VERTICAL 		= 1;
static int BSS_DIRECTION_HORIZONTAL 	= 2;

static int BSS_MODE_COPYMIDDLE				= 1;
static int BSS_MODE_COPYSCAN					= 2;

class BasicSlitScreen extends Effect {
	int copySpread = 1;
	int scanDirection = BSS_DIRECTION_VERTICAL;
	int copyMode = BSS_MODE_COPYSCAN;
	
	int scanLineIndex = 0;
	
	boolean saveNextFrame = false;
	
	String getName() {
		return "Basic Slit Screen Effect";
	}
	
	void start() {
		super.start();
		scanLineIndex = 0;
		saveNextFrame = false;
	}
	
	void exportFrame() {
		saveNextFrame = true;
	}
	
	void keyPressed() {
		switch(key) {
			case 'c':
				copyMode = (copyMode == BSS_MODE_COPYSCAN) ?
					BSS_MODE_COPYMIDDLE : BSS_MODE_COPYSCAN;
				break;
			case 's':
				scanDirection = (scanDirection == BSS_DIRECTION_VERTICAL) ?
					BSS_DIRECTION_HORIZONTAL : BSS_DIRECTION_VERTICAL;
				break;
		}
	}
	
	void process(PImage frame) {
		int x = 0, y = 0, scanX = 0, scanY = 0, spreadX = width, spreadY = height;
		boolean saveTest = false;
		
		super.process(frame);	// set up the internalBuffer
		
		if(scanDirection == BSS_DIRECTION_VERTICAL) {
			y = scanLineIndex % height;
			if(y == height - 1) saveTest = true;
			spreadY = copySpread;
			if(copyMode == BSS_MODE_COPYSCAN) {
				scanY = y;
			} else {
				scanY = height / 2;
			}
		} else {
			x = scanLineIndex % width;
			if(x == width - 1) saveTest = true;
			spreadX = copySpread;
			if(copyMode == BSS_MODE_COPYSCAN) {
				scanX = x;
			} else {
				scanX = width / 2;
			}
		}
		
		internalBuffer.copy(frame,scanX,scanY,spreadX,spreadY,x,y,spreadX,spreadY);
		frame.copy(internalBuffer, 0,0,width,height,0,0,width,height);
		
		if(saveNextFrame && saveTest) {
			super.exportFrame();
		}
		
		scanLineIndex++;
	}
}