## lefeel Drawing
**Textile device used to create drawings**

###### lefeel_drawing_V0

First simple version

```
line(touch_X, touch_Y, previous_touchX, previous_touchY);
  
previous_touchX = touch_X;
previous_touchY = touch_Y;
```

###### lefeel_drawing

Second version with a line class

```
if(mousePressed == true){
	if(touch_X != previous_touchX || touch_Y != previous_touchY){
		Line l1 = new Line(touch_X, touch_Y);
		l1.create(); 
	}
}
```