
class PieChart
{
  float diameter;
  int x, y, gap;
  String text;
  color colour;

  String legend1=("Early");
  String legend2=("Late");
  String legend3=("On time");
  public PieChart(float diameter, int x, int y, String title, int gap) 
  {
    this.diameter=diameter;
    this.x=x;
    this.y=y;
    this.text=title;
    this.gap=gap;
  }

  void draw(int[]data)
  {
    fill(255, 0, 0);
    float lastAngle = 0;
    text(text, x-100, y-65);
    for (int i = 0; i < data.length; i++) 
    {

      fill(0, 80, 50);
      if (i==0) {
        text(legend1, x+100, y+gap-10);
        color colour=color(0, 0, 255);
        fill(colour);
      }
      if (i==1) {
        text(legend2, x+100, y+gap-10);
        color colour=color(0, 255, 0);
        fill(colour);
      }
      if (i==2) {
        text(legend3, x+100, y+gap-10);
        color colour=color(255, 0, 0);
        fill(colour);
      }
      rect(x+60, y+gap-24, 15, 15);
      arc(x, y, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
      lastAngle += radians(data[i]);
      gap=gap+20;
    }
  }
}