/* ----------------------------------------------------------------------------------------------------
 * LeFeel (drawing version), 2017
 * Update: 08/08/17
 * 
 * V0
 * Written by Bastien DIDIER
 * more info : https://github.com/humain-humain/lefeel
 *
 * ----------------------------------------------------------------------------------------------------
 */ 

import processing.serial.*; //Import the library

lefeel Lefeel;
Serial arduino;
String val;
String[] pos;
String device_port = "/dev/cu.usbmodem1421";

boolean mouseController = false;

float touch, touch_X, touch_Y;
boolean statut_touch;
int textil_layer; //0 ROW //1 COL

float previous_touchX = 0;
float previous_touchY = 0;

float xc1, xc2, yc1, yc2;
float last_xc1, last_xc2, last_yc1, last_yc2;

float r = random(255);
float v = random(255);
float b = random(255);

boolean first_line = true;

void setup() {
  size(500, 500);
  background(100);
  smooth();
  try{
    arduino = new Serial(this, device_port, 115200);
    arduino.clear();
    
    //lefeel.begin();
    
  } catch (Exception e) {
    println("Device not connected");
    mouseController = true;
  }
}

void draw() {  
  if(!mouseController){
    map_serial(arduino);
    touch_X = map(touch_X, 0,11, 0,width);
    touch_Y = map(touch_Y, 0,11, 0,height);
  } else {
    //if leFeel is not connected
    touch_X = mouseX;
    touch_Y = mouseY; 
  }
  
  //println(touch_X +" : "+ touch_Y);
  //if (leFeelPressed == true || mousePressed == true) { //TODO
  //if(statut_touch == true){
  if(mousePressed == true){
    if(touch_X != previous_touchX || touch_Y != previous_touchY){
      //TODO add line class w/ attr
      Line l1 = new Line(touch_X, touch_Y);
      l1.create();
    }
  }
}

//GET DATA FROM LEFEEL
// TODO Put it in a class
void map_serial(Serial serial){
  if(serial.available() > 0){
    val = serial.readStringUntil('\n');
    pos = split(val, '-');  
  }
  
  try {
    
    //pos[0] 0 / 1 / 2 / 3 / 4 / 5 / 6 / 7 / 8 / 9 / 10 / 11
    //pos[1] TCH / RLD
    //pos[2] ROW / COL
    
    touch = int(pos[0]);
   
    if(pos[1].equals("tch")){
      statut_touch = true;
    } else if (pos[1].equals("rld")){
      statut_touch = false;
    }
    
    if(pos[2].equals("row")){
      textil_layer = 0;
      touch_X = touch;
    } else if (pos[2].equals("col")){
      textil_layer = 1;
      touch_Y = touch;
    }
  }
  catch (Exception e) {
   println("Setup data incoming : Ignoring…");
  }
}

void mouseReleased(){
  r = random(255);
  v = random(255);
  b = random(255);
  
  first_line = true;
}