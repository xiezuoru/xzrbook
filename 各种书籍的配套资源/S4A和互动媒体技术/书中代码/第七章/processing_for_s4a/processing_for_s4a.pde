/**
 *   色彩捕捉，2.0版，根据书中范例修改，点击鼠标选取某一色彩
 *在win7,64位上测试通过。
 *运行后，发送远程传感器信息给s4a，发送内容为获取色彩的坐标。
 *远程传感器名称为：sensorX和sensorY，每次取一个最接近的值。
 *逐次发送x、y的坐标，避免数据发送过快。
 *开始识别发送广播startfind，停止识别发送stopfind。
 *int absright=1;//等于-1，则x坐标水平翻转，和画面相反。（其实我可以让画面和现实一致，翻转显示，但是可能速度会太慢。）
 */

import processing.video.*;
Capture video;
color findColor;
int mydiff;
//web部分
import processing.net.*;
Client c;
String data;
int count=0;
int status=0;//当前状态
int absright=1;//等于-1，则x坐标水平翻转，和画面相反。（其实我可以让画面和现实一致）
String ip="127.0.0.1";
//web结束
void setup() {
  size(640, 480); // Change size to 320 x 240 if too slow at 640 x 480
  video = new Capture(this, 640, 480);
  video.start();
  smooth();
  findColor=color(255, 0, 0);//定义颜色
  mydiff=15;//允许的最小容差
  frameRate(4);//帧速，每秒4帧
  c = new Client(this, ip, 42001); // Connect to s4a
}

void draw() {
  if (video.available()) {
    video.read();
  }
  video.loadPixels();
  image(video, 0, 0, width, height);
  float difference=300;//初识色彩容差
  float min_d=300;//记录最小的容差数
  int miniX=0;//找到差异最小的色彩坐标
  int miniY=0;
  for (int x=0;x<width;x++) {
    for (int y=0;y<height;y++) {
      int loc=x+y*video.width;
      color  c=video.pixels[loc];
      float r1=red(c);
      float g1=green(c);
      float b1=blue(c);    
      float r2=red(findColor);
      float g2=green(findColor);
      float b2=blue(findColor);  
      float d=dist(r1, g1, b1, r2, g2, b2);//计算差异度
      if (d<difference) {
        difference=d;
      }
      if (min_d>difference) {
        min_d=difference;
        miniX=x;
        miniY=y;
      }
    }
  }
  //println(difference);println(x);println(y);
  if (difference < mydiff) {
    fill(findColor);
    stroke(255);
    rect(miniX, miniY, 20, 20);
    //开始发送web信息给s4a
    miniX=((miniX*48/64)-240)*absright;
    miniY=((miniY*36/48)-180)*-1;
    if (count==0) {
      gets4a_xy(miniX, 0);
      count=1;
    }
    else {
      gets4a_xy(miniY, 1);
      count=0;
    }
  }
  else {
    if (status!=0) {
      gets4a_b("stopfind");
      status=1;
    }
  }
}
void mousePressed() {
  int loc=mouseX+mouseY*video.width;//鼠标确定某一像素
  findColor=video.pixels[loc];
  status=1;
}
void gets4a_xy(int xy, int t) {
  if (status==1) {
    gets4a_b("startfind");
    status=2;
  }
  else {
    if (t==0) {
      c.write("GET /?sensor-update=sensorX="+ xy +" HTTP/1.1\r\n"); // 发送x
    }
    else
    {
      c.write("GET /?sensor-update=sensorY="+ xy +" HTTP/1.1\r\n"); //发送y
    }
    c.write("\r\n");
    if (c.available() > 0) { // If there's incoming data from the client...
      data = c.readString(); // ...then grab it and print it
      println(data);
    }
  }
}

void gets4a_b(String b) {
  c.write("GET /?broadcast="+ b +" HTTP/1.1\r\n"); // 发送广播
  c.write("\r\n");
  if (c.available() > 0) { // If there's incoming data from the client...
    data = c.readString(); // ...then grab it and print it
    println(data);
  }
}

