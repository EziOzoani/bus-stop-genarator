class WidgetButton{
  int x, y, width, height,t1,tr,br,b1;
  String label;
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  
 WidgetButton(int x, int y, int width, int height, String label, color widgetColor, color labelColor,
          PFont widgetFont, int event){
            this.x = x;
            this.y = y;
            this.width = width;
            this.height = height;
            
            this.label =label;
            this.event = event;
            this.widgetColor = widgetColor;
            this.widgetFont = widgetFont;
            this.labelColor = labelColor;
 }
  
 void draw(){
   fill(widgetColor);
   if(mouse == true) stroke(255);
   else //strokeWeight(4) ; // controls how Thick the stroke is
   //stroke(160-32-240); // controls stroke colour 
    //line(20, 20, 20, 40);
    stroke(255);                   
   rect(x, y, width+15, height,12,26,3,15);
   fill(labelColor);
   text(label, x+15, y+height-5);
 }
 
 int getEvent(int mX, int mY){
   if((mX > x)&&(mX < x+width)&&(mY > y)&&(mY < y+height))
   {
     return event;
   }
   return EVENT_NULL;
 }
}