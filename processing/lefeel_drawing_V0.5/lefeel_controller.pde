//import processing.core.*;
//import processing.core.PApplet;

class lefeel { 
  
  Serial _serial; 
  int baudRate = 115200;
  boolean isConnected = false;
  
  lefeel (Serial serial) {  
    _serial = serial;
  } 

  void begin(PApplet parent, String lefeel_port){
    try {
      if(isConnected == true){ // if serial port is already open
        println("Serial port already open at : " + lefeel_port);
        return;
      }
      println("Attempting to open serial/COM port for data input : " + lefeel_port);
      _serial = new Serial(parent, lefeel_port, baudRate); //open the port
      _serial.clear(); // clear anything in the port's buffer
      _serial.bufferUntil('\n'); // don't generate a serialEvent() until you get a newline (\n) byte
      println("Serial/COM port is open on : " + lefeel_port);
      isConnected = true;
    }
    catch (RuntimeException e) {
      println("Could not open : " + lefeel_port);
      println("MouseController starting…");
      mouseController = true;
      isConnected = false;
    }
  }
  
  void map_serial(){
  if(_serial.available() > 0){
    val = _serial.readStringUntil('\n');
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
} 



/*

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');  // get the ASCII string

  if (inString != null) {  // if it's not empty
    
    inString = trim(inString);  // trim off any whitespace
    try{
      int incomingValues[] = int(split(inString, ","));
      for (int i = 0; i < incomingValues.length; i++) {
        
        if(incomingValues[i] > 10 && incomingValues[i] < 20){
          sensorValue[i] = map(incomingValues[i], 10, 20, 0, 255);
        } else {
          sensorValue[i] = 0;
        }
      }
    } catch(Exception e){
      //e.printStackTrace();
    }
  }
}

*/