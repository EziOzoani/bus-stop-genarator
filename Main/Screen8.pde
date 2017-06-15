
class Screen8{
  int x,y;
  public Screen buildScreen8(int i)
 {int event=1200;
  this.x=50;
  this.y=50;

 Stop s=routeStopList.get(i);
  screen8=new Screen(color(255),""+s.stop);
  screen8.add(backWidget);
  

  for (int j=0; j<3; j++)
  {
    switch(j)
    {
    case 0:
      widget=new WidgetButton(x, y, 150, 50,"TimeTable", color(0), color(255), routeFont, event);
      screen8.add(widget);
      break;
    case 1:
  
      widget=new WidgetButton(x, y, 150, 50, "All routes that go here", color(0), color(255), routeFont, event);
      screen8.add(widget);
      break;
    
    }
    event=event+1;
  y=y+75;

  }
  return screen8;
 }
}