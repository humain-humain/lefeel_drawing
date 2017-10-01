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

lefeel lefeel;
Serial arduino;

String val;
String[] pos;
//String device_port = "/dev/cu.usbmodem1421";

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
  
  lefeel = new lefeel(arduino);
  lefeel.begin(this,"/dev/cu.usbmodem1421");
}

void draw() {  
  if(!mouseController){
    lefeel.map_serial();
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
  //if(mousePressed == true){
    if(touch_X != previous_touchX || touch_Y != previous_touchY){
      //TODO add line class w/ attr
      Line l1 = new Line(touch_X, touch_Y);
      l1.create();
    }
  //}
}

void mouseReleased(){
  r = random(255);
  v = random(255);
  b = random(255);
  
  first_line = true;
}