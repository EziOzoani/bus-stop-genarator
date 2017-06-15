class Screen2
{
  
  
  public Screen buildScreen2()
  {
    int x1=50;
    int y1=200;
    current_query=noQuery;
    int event=10;
    String title;
 screen2=new Screen(color(140, 234, 249), "General Data selections");
    screen2.add(backWidget);
    for(int i=0;i<2;i++)
    {
      if(i==0)
      {
        title="pieChart";
      }
      else title="scatterPlot";
      WidgetButton widget=new  WidgetButton(x1, y1, 180, 90, title, color(0), color(255), kFont, event); 
      event++;
      screen2.add(widget);
    y1=y1+100;
    }
    return screen2;
  }
}