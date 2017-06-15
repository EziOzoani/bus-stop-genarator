//This code was taken from the lecture notes, David
class  Screen  {  
    ArrayList  screenWidgets;  
    color  screenColor; 
    String title;
    Screen(color  in_color, String title){ 
      this.title=title;
        screenWidgets=new  ArrayList();  
        screenColor=in_color;  
    }  
    void  add(WidgetButton  w){  
        screenWidgets.add(w);  
    }
    void remove(WidgetButton w)
    {
      screenWidgets.remove(w);
    }
    void  draw(){  
        background(screenColor);  
        text(title, 400, 30);
        for(int  i  =  0;  i<screenWidgets.size();  i++){  
            WidgetButton  aWidget  =  (WidgetButton)screenWidgets.get(i);  
            aWidget.draw();  
        }  
  }  
  int  getEvent(int  mx,  int  my){  
      for(int  i  =  0;  i<screenWidgets.size();  i++){  
           WidgetButton  aWidget  =  (WidgetButton)  screenWidgets.get(i);  
            int  event  =  aWidget.getEvent(mouseX,mouseY);  
            if(event  !=  EVENT_NULL){  
                return  event;  
            }  
      }  
      return  EVENT_NULL;  
  }  
  int size()
  {
    return screenWidgets.size();
  }
}