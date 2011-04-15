class Rectangle {
	int x,y,w,h;
	Rectangle(int x,int y,int w,int h) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
	}
	
	void setBottomRight(int newX, int newY) {
		this.w = newX - x;
		this.h = newY - y;
	}
	
	int left() {
		if(w < 0) return x - abs(w);
		return x;
	}
	int right() {
		if(w < 0) return x;
		return x + w;
	}
	int top() {
		if(h < 0) return y - abs(h);
		return y;
	}
	int bottom() {
		if(h < 0) return y;
		return y + h;
	}
	
	int width() {
		return abs(w);
	}
	int height() {
		return abs(h);
	}
	
	void draw(PGraphics buffer, PImage frame) {
		int tx = left(),
				ty = top(),
				tw = width(),
				th = height();
				
		print("Drawing rectangle at ");
		print("x("+tx+") ");
		println("y("+ty+") ");
				
		buffer.copy(frame,tx,ty,tw,th,0,0,tw,th);
		
		buffer.pushStyle();
		buffer.fill(0x33000000);
		buffer.rect(0,0,tw,th);
		buffer.popStyle();
		
		frame.copy(buffer,0,0,tw,th,tx,ty,tw,th);
	}
}