class barChart
{

BarChart barChart;
void setup()
{
  size(500,500);
  
  //barChart = new BarChart(this);
  barChart.setData(new float[] {0.76, 0.24, 0.39, 0.18, 0.20});
     
  // Scaling
  barChart.setMinValue(0);
  barChart.setMaxValue(1);
   
  // Axis appearance
  textFont(createFont("Serif",10),10);
   
  barChart.showValueAxis(true);
  barChart.setValueFormat("#%");
  barChart.setBarLabels(new String[] {"Cynthia","Daniel","Eli",
                                       "Fasil","Gertrude"});
  barChart.showCategoryAxis(true);
}
// Draws the chart in the sketch
void draw()
{
  background(255);
  barChart.draw(15,15,width-50,height-20); 
}
}