//TODO

//line
float smooth = 0.5; //[0,1]

//Point
int      x = 0;
int      y = 1;
int last_x = 2;
int last_y = 3;

//TODO
float[] barycentre = new float[4]; //[ x, y, last_x, last_y ]
float[] middle_point = new float[4]; //[ x, y, last_x, last_y ]

class Line { 
  
  Line (float x, float y) {  
    barycentreX = x;
    barycentreY = y;
  }
  
  void create() {
    if(!first_line){ 
      stroke(r,v,b);
      fill(r,v,b);
  
      float line_lenght = sqrt(pow(barycentreX-last_barycentreX,2)+pow(barycentreY-last_barycentreY,2));
    
      //Middle Point
      mid_x = (barycentreX + last_barycentreX)/2;
      mid_y = (barycentreY + last_barycentreY)/2;      
  
      float mid_line_height = 400;
  
      xc1 = mid_x + (line_lenght/2)/(mid_line_height/2) * (barycentreY-mid_y);
      yc1 = mid_y + (line_lenght/2)/(mid_line_height/2) * (mid_x-barycentreX);
    
      xc2 = mid_x - (line_lenght/2)/(mid_line_height/2) * (barycentreY-mid_y);
      yc2 = mid_y - (line_lenght/2)/(mid_line_height/2) * (mid_x-barycentreX);
      
      //3 modes… line / bezier / vertex
      //and a debug mode if a boolean parameter set to true is added at the end > line_mode("bezier",true);
      line_mode("bezier");
     
      last_mid_x = mid_x;
      last_mid_y = mid_y;
      
      last_xc1 = xc1;
      last_xc2 = xc2;
      last_yc1 = yc1;
      last_yc2 = yc2;
      
      last_barycentreX = barycentreX;
      last_barycentreY = barycentreY;
  
    } else {
      last_xc1 = xc1;
      last_xc2 = xc2;
      last_yc1 = yc1;
      last_yc2 = yc2;
      
      last_barycentreX = barycentreX;
      last_barycentreY = barycentreY;
      first_line = false;
    }
  }

  void line_mode(String mode, boolean... debug){
    switch(mode) {
      case "line": 
        strokeWeight(2);
        line(barycentreX, barycentreY, last_barycentreX, last_barycentreY);
        break;
      case "bezier": 
        noFill();
        strokeWeight(2);
        
        /*float controle_point_1_X = smooth * last_mid_x-last_barycentreX;
        float controle_point_1_Y = smooth * last_mid_y-last_barycentreY;
        
        float controle_point_2_X = smooth * mid_x-last_barycentreX;
        float controle_point_2_Y = smooth * mid_y-last_barycentreY;*/
        
        bezier(last_mid_x, last_mid_y, last_barycentreX, last_barycentreY, last_barycentreX, last_barycentreY, mid_x, mid_y);
        break;
      case "vertex": 
        beginShape();
          vertex(last_xc1, last_yc1);
          vertex(xc1, yc1);
          vertex(xc2, yc2);
          vertex(last_xc2, last_yc2);
        endShape(CLOSE);
        break;
      default:
        //ADD default mode
      break;
    }
    
    boolean enable_debug = (debug.length >= 1) ? debug[0] : false;
    if(enable_debug == true){
      strokeWeight(0.5);
      line(xc1, yc1, xc2, yc2);
      line(barycentreX, barycentreY, last_barycentreX, last_barycentreY);
    }
  }
  
  //TODO
  /*float controle_point(float smooth, float point1, float point2){
    float point = 0;
    
    if(smooth == 0){
      point = point1;
    } else if(smooth == 1){
      point = 0;
    } else {
      point = point1 - point2;
    }
    
    return point;
  }*/
}