class PieChart                    
{
  float diameter;
 
    public PieChart(float diameter) 
   {
      this.diameter=diameter;
    }
  
  void draw(int[]data,int x, float w)
  
  {
    loop();
     float lastAngle = w;
      for (int i = 0; i < data.length; i++) 
      {
        float gray = map(i, 0, data.length, 0, 255);
        fill(gray);
        arc(x/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
        lastAngle += radians(data[i]);
      }
  }
}