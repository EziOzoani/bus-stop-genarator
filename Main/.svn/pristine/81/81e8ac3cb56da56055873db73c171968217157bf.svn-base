class Screen4{
  int x, y;
  public Screen buildScreen(int i)                            //Building Screen with variable widgets, David
{
  int event=500;
  this.x=50;
  this.y=50;
  Routes r=route.get(i);
  screen4=new Screen(color(255),""+r.route);
  screen4.add(backWidget);
  
  
  for (i=0; i<5; i++)
  {
    switch(i)
    {
    case 0:
      widget=new WidgetButton(x, y, 150, 50,"delay", color(0), color(255), routeFont, event);
      screen4.add(widget);
      break;
    case 1:
  
      widget=new WidgetButton(x, y, 150, 50, "position", color(0), color(255), routeFont, event);
      screen4.add(widget);
      break;
    case 2:
      
      widget=new WidgetButton(x, y, 150, 50, "stop data", color(0), color(255), routeFont, event);
      screen4.add(widget);
      break;
    case 3:
     
      widget=new WidgetButton(x, y, 150, 50, "vehicle data", color(0), color(255), routeFont, event);
      screen4.add(widget);
      break;
    case 4:
      widget=new WidgetButton(x,y,150,50,"Stops on route", color(0), color(255), routeFont, event);
      screen4.add(widget);
      break;
    }
    event=event+1;
  y=y+75;

  }
  return screen4;
}
}