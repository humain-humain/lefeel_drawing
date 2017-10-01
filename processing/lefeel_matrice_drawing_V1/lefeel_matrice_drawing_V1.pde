/* ----------------------------------------------------------------------------------------------------
 * Le Feel (drawing version), 2017
 * Update: 16/08/17
 *
 * More Soon
 * 
 * V0
 * Written by Bastien DIDIER
 * more info : http://humain-humain.fr
 *
 * ----------------------------------------------------------------------------------------------------
 */

import processing.serial.*;
Serial myPort;

int rectSize = 30;
int row = 12;
int cols = 12;

int addRow = 0;
int addCols = 0;

int mapWidth = rectSize*row;
int mapHeight = rectSize*cols;

int maxNumberOfSensors = row*cols;     
float[] sensorValue = new float[maxNumberOfSensors];    // global variable for storing mapped sensor values
//float[] previousValue = new float[maxNumberOfSensors];  // array of previous values

/******/

float barycentreX, barycentreY,last_barycentreX,last_barycentreY;
float xc1, xc2, yc1, yc2;
float last_xc1, last_xc2, last_yc1, last_yc2;
float mid_x, mid_y, last_mid_x,last_mid_y;

int ellipsCount = 0;

float r = random(255);
float v = random(255);
float b = random(255);

boolean first_line = true;

/*****/

void setup () { 
  size(600, 600);
  
  String portName = "/dev/cu.usbmodem1421";
  try{
    myPort = new Serial(this, portName, 115200);
    myPort.clear();
    myPort.bufferUntil('\n');  // don't generate a serialEvent() until you get a newline (\n) byte
  } catch (Exception e){}
  
  //TODO
  //lefeel = new lefeel(arduino);
  //lefeel.begin(this,"/dev/cu.usbmodem1421");
  
  background(255);
  smooth();
  
  grid();
}

void draw () {
  
  for(int i=0; i<=maxNumberOfSensors-1; i++){
    if(i % cols == 0 && i != 0){
      addCols++;
      addRow = 0;
    }
    
    //fill(sensorValue[i]);
    //rect((width/2-mapWidth/2)+addRow*rectSize, (height/2-mapHeight/2)+addCols*rectSize, rectSize,rectSize);
    
    if(sensorValue[i] > 150){
      barycentreX += ((width/2-mapWidth/2)+addRow*rectSize)+rectSize/2;
      barycentreY +=((height/2-mapHeight/2)+addCols*rectSize)+rectSize/2;
      ellipsCount++;
    }
    addRow++;
  }
  
  barycentreX = barycentreX/ellipsCount;
  barycentreY = barycentreY/ellipsCount;
  println("x : "+barycentreX+" y : "+barycentreY);
  
  //fill(0,255,0);
  //ellipse(barycentreX,barycentreY,rectSize,rectSize);
   
  if(barycentreX != last_barycentreX || barycentreY != last_barycentreY){
    if(Float.isNaN(barycentreX)){
      r = random(255);
      v = random(255);
      b = random(255);
    }
    Line l1 = new Line(barycentreX, barycentreY);
    l1.create();
  }
  
  addRow = 0;
  addCols = 0;
  ellipsCount = 0;
  last_barycentreX = barycentreX;
  last_barycentreY = barycentreY;
  barycentreX = 0;
  barycentreY = 0;
}

void grid(){
  for(int i=0; i<=maxNumberOfSensors-1; i++){
    if(i % cols == 0 && i != 0){
      addCols++;
      addRow = 0;
    }
    
    noFill();
    stroke(200);
    rect((width/2-mapWidth/2)+addRow*rectSize, (height/2-mapHeight/2)+addCols*rectSize, rectSize,rectSize);

    addRow++;
  }
  addRow = 0;
  addCols = 0;
}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');  // get the ASCII string
  if (inString != null) {  // if it's not empty   
    inString = trim(inString);  // trim off any whitespace
    try{
      int incomingValues[] = int(split(inString, ","));  // convert to an array of ints
      for (int i = 0; i < incomingValues.length; i++) {
        sensorValue[i] = map(incomingValues[i], 0, 20, 0, 255);
      }
    } catch(Exception e){
      //e.printStackTrace();
    }
  }
}