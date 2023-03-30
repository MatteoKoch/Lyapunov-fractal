float xn;
char[] reihe = {'A', 'B'};
int sizex = 800;
int sizey = 800;
int numThreads = 4;
float erg;
float xa, yb;
float col;
int iteration = 0;
float xan = 0;
float xen = 4;
float yan = 0;
float yen = 4;

void setup() {
  size(800, 800);
}

void draw() {
  background(0);
  noStroke();
  //for(int i = 0; i < numThreads; ++i) {
  //  thread("calcFractal");
  //}
  for(int x = 0; x < sizex; ++x) {
    for(int y = 0; y < sizey; ++y) {
      xa = map(x, 0, sizex, xan, xen);
      yb = map(y, 0, sizey, yen, yan);
      erg = showFunction2(xa, yb, reihe);
      //if(xa > 2 && xa < 4 && yb > 2 && yb < 4) println(erg, xa, yb);
      if(erg < 0) {
        col = -255/(erg-1);
        fill(col, col, 0);
      } else {
        col = 255/(erg+1);
        fill(0, 0, 255);
      }
      rect(x*width/sizex, y*height/sizey, width/sizex, height/sizey);
    }
  }
  println("done");
  noLoop();
}

void mousePressed() {
  println("x:", map(mouseX, 0, width, xan, xen), "y:", map(mouseY, 0, height, yen, yan));
}

void calcFractal() {
  int start = sizex*iteration/numThreads;
  ++iteration;
  int end = sizex*iteration/numThreads;
  for(int x = start; x < end; ++x) {
    for(int y = 0; y < sizey; ++y) {
      xa = map(x, 0, sizex, 0, 4);
      yb = map(y, 0, sizey, 4, 0);
      erg = showFunction2(xa, yb, reihe);
      //if(xa > 2 && xa < 4 && yb > 2 && yb < 4) println(erg, xa, yb);
      if(erg < 0) {
        col = -255/(erg-1);
        fill(col, col, 0);
      } else {
        col = 255/(erg+1);
        fill(0, 0, 255);
      }
      rect(x*width/sizex, y*height/sizey, width/sizex, height/sizey);
    }
    println(x);
  }
  println("done, Thread Nr.", iteration);
}

float showFunction2(float a, float b, char[] str) {
  xn = 0.5;
  float steps = 100;
  float sum = 0;
  for(float x = 0; x < steps; ++x) {
    for(int i = 0; i < str.length; ++i) {
      xn = iterate2(xn, str[i]=='A'?a:b);
      //xn = iterate2ddx(xn, str[i]=='A'?a:b);  
      if(x > 0) sum += log(abs(iterate2ddx(xn, str[i]=='A'?a:b)));
      if(x%str.length == 0) ++x;
    }
  }
  return sum/(steps-1);
}

float iterate2(float x, float r) {
  return r*(1-x)*x;
}

float iterate2ddx(float x, float r) {
  //println(r);
  return r*(1-(2*x));
}

void showFunction() {
  xn = 0.5;
  float xc, yc;
  float xc2, yc2;
  float steps = 50;
  stroke(255);
  strokeWeight(3);
  for(float x = 0; x < steps; ++x) {
    xc = x*width/steps;
    yc = map(xn = iterate(xn), 1, 0, 0, height);    
    xc2 = (x+1)*width/steps;
    yc2 = map(iterate(xn), 1, 0, 0, height);    
    //ellipse(xc, yc, 4, 4);
    line(xc, yc, xc2, yc2);
  }
}

float iterate(float x) {
  float r = 0.4;
  return r*(1-x)*x;
}
