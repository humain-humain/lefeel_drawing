//TODO
class Line { 
  
  Line (float x, float y) {  
    touch_X = x;
    touch_Y = y;
  }
  
  void create() {
    if(!first_line){ 
      stroke(r,v,b);
      fill(r,v,b);
  
      float line_lenght = sqrt(pow(touch_X-previous_touchX,2)+pow(touch_Y-previous_touchY,2));
    
      //Middle Point
      float mid_x = (touch_X + previous_touchX)/2;
      float mid_y = (touch_Y + previous_touchY)/2;      
  
      float mid_line_height = 400;
  
      xc1 = mid_x + (line_lenght/2)/(mid_line_height/2) * (touch_Y-mid_y);
      yc1 = mid_y + (line_lenght/2)/(mid_line_height/2) * (mid_x-touch_X);
    
      xc2 = mid_x - (line_lenght/2)/(mid_line_height/2) * (touch_Y-mid_y);
      yc2 = mid_y - (line_lenght/2)/(mid_line_height/2) * (mid_x-touch_X);
    
      line(xc1, yc1, xc2, yc2);
      line(touch_X, touch_Y, previous_touchX, previous_touchY);
      
      /*beginShape();
        vertex(last_xc1, last_yc1);
        vertex(xc1, yc1);
        vertex(xc2, yc2);
        vertex(last_xc2, last_yc2);
      endShape(CLOSE);*/
  
      last_xc1 = xc1;
      last_xc2 = xc2;
      last_yc1 = yc1;
      last_yc2 = yc2;
      
      previous_touchX = touch_X;
      previous_touchY = touch_Y;
  
    } else {
      last_xc1 = xc1;
      last_xc2 = xc2;
      last_yc1 = yc1;
      last_yc2 = yc2;
      
      previous_touchX = touch_X;
      previous_touchY = touch_Y;
      first_line = false;
    }
  } 
} 