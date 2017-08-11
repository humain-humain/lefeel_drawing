//import processing.core.*;

class lefeel { 
  
  Serial _serial;
  PApplet parent; 
  int baudRate = 115200;
  String device_port = "/dev/cu.usbmodem1421";
  boolean isConnected = false;
  
  lefeel (Serial serial, PApplet parent) {  
    _serial = serial;
    this.parent = parent;
  } 

  void begin() {  
    _serial = new Serial(parent, device_port, baudRate);
    _serial.clear();
  }
  
  void get_data(){
  
  }
} 



/*

try {
    if(isConnected == true){ // if serial port is already open
      println("Closing port…" + port);
      Arduino.stop();
    }
    println("Attempting to open serial/COM port for data output = " + port);
    Arduino = new Serial(this, port, BaudRate); //open the port
    Arduino.clear(); // clear anything in the port's buffer
    println("Serial/COM port is open on " + port);
    isConnected = true;
  }
  catch (RuntimeException e) {
    println("Could not open " + port);
    isConnected = false;
  }
  
*/