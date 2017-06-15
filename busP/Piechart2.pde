class PieChart2
{
  PFont  legendFont;
  float diameter;
  int x, y, gap;
  String text, text2;
  color colour;
ArrayList<Frequency> frequency;

  public PieChart2(float diameter, int x, int y, String title, int gap, String mainTitle2, ArrayList<Frequency> frequency) 
  {
    this.diameter=diameter;
    this.x=x;
    this.y=y;
    this.text=title;
    this.gap=gap;
    this.text=mainTitle2;
    this.frequency=frequency;
  
  }

  void draw(float[]data)
  {
       legendFont=loadFont("ArialMT-12.vlw"); 
  

    float lastAngle = 0;
  int x2=800;
  int y2=200;
  int r=255;
  int g=0;
  int b=50;
  color color1=color(r, g, b);
 Data part=indivRouteList.get(1);
 textFont(stdFont);
 fill(255);
  text(("PieChart showing frequency of vehicles that go on the "+part.line), width/2-200, 30);
  textFont(legendFont);
    for (int i = 0; i < data.length; i++) 
    {
  Frequency f=frequency.get(i);
     
   fill(r,g,b);
   rect(x+280, y+gap-24, 15, 15);
    text(""+f.vid, x+300, y+gap-10);
    y2=y2+50;
      arc(x, y, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
      lastAngle += radians(data[i]);
      gap=gap+20;
       r=r-20;
       g=g+50;
       b=b+25;
    }
  }
}