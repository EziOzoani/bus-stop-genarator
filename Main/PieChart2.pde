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

  void draw(int[]data)
  {
       legendFont=loadFont("ArialMT-12.vlw"); 
  textFont(legendFont);

  text("Pie Chart showing frequency of certain buses on this route", 400, 100);
    float lastAngle = 0;
  int x2=800;
  int y2=200;
    for (int i = 0; i < data.length; i++) 
    {
  Frequency f=frequency.get(i);
     
    float gray = map(i, 0, data.length, 0, 255);
    fill(gray);
    rect(x2,y2, 50, 20);
    text(""+f.vid, x2+100, y2);
    y2=y2+50;
      arc(x, y, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
      lastAngle += radians(data[i]);
      gap=gap+20;
    }
  }
}