class Screen7{

 public Screen buildScreen7(ArrayList<Data> indivRouteList)
 {int x1=100;
  int y1=100;
   screen7=new Screen(color(140, 234, 249), "Stops Screen");
   int event=700;
   boolean alreadyInList=false;
  
  Stop stop=new Stop(0);
  routeStopList=stop.buildStopList(indivRouteList);
   
  String stopName;
  stopFont=loadFont("ArialMT-8.vlw");
  screen7.add(backWidget);

  for (int i=0; i<routeStopList.size(); i++)
  {

    Stop s=routeStopList.get(i);
   stopName=""+s.stop;
    widget=new WidgetButton(x1, y1, 60, 30, stopName, color(0), color(255), routeFont, event);
    screen7.add(widget);
   
    event=event+1;
    y1=y1+40;
    if (y1+150>height)
    {
      y1=100;
      x1=x1+80;
    }
  }
  return screen7;
  
 }
}