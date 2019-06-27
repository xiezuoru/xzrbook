import processing.serial.*;
Serial myPort;  
int val; 
PImage z;
float x, y, a, b;
float angle1 = 0;
float angle2 = 0;
float segLength = 100;

void setup() {
  size(640, 360);
  z = loadImage("robot.gif");
  myPort = new Serial(this, "COM3", 9600);
  strokeWeight(30);
  stroke(160, 200);
  x = width * 0.3;
  y = height * 0.5;
}
void draw() {
  background(0, 145, 125);
  image(z, 5, -10);
  if ( myPort.available() > 0) {
    val = myPort.read();
  }
  //println(val);
  if (val<128) {
    a=val*5;
  }
  else {
    b=(val-127)*5;
  }
  angle1 = (a/float(width) - 0.5) * -PI;
  angle2 = (b/float(height) - 0.5) * PI;
  segment(x, y, angle1); 
  segment(segLength, 2, angle2);
}
void segment(float x, float y, float a) {
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
}

