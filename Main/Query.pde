class Query
{

  public void query1(ArrayList<Data> dataList)
  { 
    int congestion=0;
  float earlyCongestion=0;
  float lateCongestion=0;
  float onTimeCongestion=0;
  float earlyNoCongestion=0;
  float lateNoCongestion=0;
  float onTimeNoCongestion=0;

  for (int i=0; i<dataList.size(); i++)
  {

    Data d = dataList.get(i);
    congestion= d.congestion;
    if (congestion==1)
    {
      if (d.delay<-60)
      {

        earlyCongestion=earlyCongestion+1;
      }
      if (d.delay>60)
      {

        lateCongestion=lateCongestion+1;
      }
      if (d.delay>=-60&&d.delay<=60)
      {

        onTimeCongestion=onTimeCongestion+1;
      }
    }
    if (congestion==0)
    {
      if (d.delay<-60)
      {
        earlyNoCongestion=earlyNoCongestion+1;
      }
      if (d.delay>60)
      {
        lateNoCongestion=lateNoCongestion+1;
      }
      if (d.delay>=-120&&d.delay<=120)
      {
        onTimeNoCongestion=onTimeNoCongestion+1;
      }
    }
    if (dataList.size()==i+1)
    {
      float temp=0;
      float total1=earlyCongestion+lateCongestion+onTimeCongestion;
      float total2=earlyNoCongestion+lateNoCongestion+onTimeNoCongestion;
       results= new int[6];
      if (total1!=0)
      {
        temp=(earlyCongestion/total1)*360;
        results[0]=round(temp);
        temp=(lateCongestion/total1)*360;
        results[1]=round(temp);
        temp=(onTimeCongestion/total1)*360;
        results[2]=round(temp);
      }
      if (total2!=0)
      {
        temp=(earlyNoCongestion/total2)*360;
        results[3]=round(temp);
        temp=(lateNoCongestion/total2)*360;
        results[4]=round(temp);
        temp=(onTimeNoCongestion/total2)*360;
        results[5]=round(temp);
      }
     
    }
  }

  }
  public void renderQuery1()
  {
    int[]angles1=new int[3];
  for (int i=0; i<3; i++)
  {
    angles1[i]=results[i];
  }

  // p.draw(10, angles1);
  int[]angles2=new int[3];
  for (int i=0; i<3; i++)
  {
    angles2[i]=results[i+3];
  }
  int gap=0;
  String title1=("With Congestion");
  int x=height/2;
  int y=width/2-300;
  float diameter=100;
  PieChart p=new PieChart(diameter, x, y, title1, gap);
  p.draw(angles1);
  y=y+300;
  String title2=("Without Congestion");
  PieChart p2=new PieChart(diameter, x, y, title2, gap);
  p2.draw(angles2);
  }
  public void query2()
  {
    
  boolean alreadyInList=false;
   route = new ArrayList<Routes>();

  for (int i=0; i<dataList.size(); i++)
  {
    Data part = dataList.get(i);

    for (int j=0; j<route.size(); j++)
    {
      Routes r=route.get(j);
      if (r.route==part.line)
      {
        alreadyInList=true;
      }
    }
    if (alreadyInList==false)
    {
      Routes r=new Routes(part.line);
      route.add(r);
    }
    alreadyInList=false;
  }
  }
  public void query4(ArrayList<Data> dataList, int i)              //This function adds every instance of the route selected to a list, David
{
   
  Routes r=route.get(i);
  int route=r.route;
  DataList data=new DataList();
 indivRouteList = new ArrayList<Data>();
  for (int j=0; j<dataList.size(); j++)
  {
    Data d=dataList.get(j);
    if (d.line==route)
    {
      String ts=d.ts;
      String line=""+d.line;
      String congestion=""+d.congestion;
      String lon=""+d.lon;
      String lat=""+d.lat;
      String delay=""+d.delay;
      String vid=""+d.vid;
      String sid=""+d.stopID;
      String atshop=d.atshop;
      Data newData=new Data(ts, line, congestion, lon, lat, delay, vid, sid, atshop);     //Previous code I ahd written was incorrect, was adding the same data every time, David
      indivRouteList.add(newData);
    }
  }

}
  
 public void query5(ArrayList<Data> indivRouteList)
 {
   results=new int[3];
   float timesDelayed=0;
  float timesEarly=0;
  float timesOnTime=0;
  println("gchc");
  for (int i=0; i<indivRouteList.size(); i++)
  {

    Data d=indivRouteList.get(i);
    if (d.delay<-60)
    {

      timesEarly++;
    }
    if (d.delay>60)
    {

      timesDelayed++;
    }
    if (d.delay>=-60&&d.delay<=60)
    {

      timesOnTime++;
    }
  }

  float temp=0;
  float total=timesEarly+timesDelayed+timesOnTime;
  int[] ratios= new int[3];
  temp=(timesEarly/total)*360;
  results[0]=round(temp);
  temp=(timesDelayed/total)*360;
  results[1]=round(temp);
  temp=(timesOnTime/total)*360;
  results[2]=round(temp);
 
 }
 public void drawDelayPieChartRoute()
 {
   int[]angles1=new int[3];
  for (int i=0; i<3; i++)
  {
    angles1[i]=results[i];
  }
  int gap=0;
  String title1=("PieChart of percentage of time delayed, on time and early");
  int x=height/2;
  int y=width/2-300;
  float diameter=100;
  PieChart p=new PieChart(diameter, x, y, title1, gap);
  p.draw(angles1);
 }
 public void Query6()
 {
   //here would be a good place to set up the map, like its done in the setup , with the lon and lat positions coming from indivRouteList
 }
 public void renderQuery6()
 {
   //Here might be a good place to render the map itself, could be something like map.draw even, something small
 }
 public void query7()
 {
     boolean alreadyInList=false;
  ArrayList<Stop> stopID = new ArrayList<Stop>();
   occurrences=new ArrayList<Occurrences>();
  for (int i=0; i<indivRouteList.size(); i++)
  {
    Data part = indivRouteList.get(i);

    for (int j=0; j<stopID.size(); j++)
    {
      Stop s=stopID.get(j);
      if (s.stop==part.stopID||part.stopID==-1)
      {
        alreadyInList=true;
      }
    }
    if (alreadyInList==false)
    {

      Stop s=new Stop(part.stopID);

      stopID.add(s);
    }

    alreadyInList=false;
  }


  int occurences=0;
  for (int o=0; o<stopID.size(); o++)
  {
    Stop s=stopID.get(o);

    for (int k=0; k<indivRouteList.size(); k++)
    {
      Data part=indivRouteList.get(k);
      if (part.stopID==s.stop)
      {
        occurences++;
      }
    }

    Occurrences b=new Occurrences(s.stop, occurences);
    occurrences.add(b);
  }


 }
 public void barChartsOfBusStopsVisited()
 {
    float tempSample=occurrences.size();
  ;
  if (occurrences.size()>50)
  {
    tempSample=occurrences.size()/2;
    pages=2;
  }
  if (occurrences.size()>100)
  {
    tempSample=occurrences.size()/3;
    pages=3;
  }
  if (occurrences.size()>150)
  {
    tempSample=occurrences.size()/4;
    pages=4;
  }

  int sample=round(tempSample);
  int start=page*sample-sample;

  
  int maxAmount=0;
  int amountDone=0;
  String[] titles=new String[sample];
  float[] dataSet=new float[sample];
  for (int i=start; amountDone<sample; i++)
  {
    Occurrences part=occurrences.get(i);
    dataSet[amountDone]=part.occurrence;
    titles[amountDone]=""+part.stop;
    if (part.occurrence>=maxAmount)
    {
      maxAmount=part.occurrence;
    }
    amountDone++;
  }

  barChart.setData(dataSet);  
  // Scaling
  barChart.setMinValue(0);
  barChart.setMaxValue(maxAmount);
  // Axis appearance
  textFont(createFont("Serif", 10), 10);   
  barChart.showValueAxis(true);
  barChart.setBarLabels(titles);
  barChart.showCategoryAxis(true);
  barChart.draw(50, 0, 1150, 700);
 }
 public void query8()
 {
     boolean alreadyInList=false;
  ArrayList<Vehicle> vehicle = new ArrayList<Vehicle>();
   frequencies=new ArrayList<Frequency>();
  for (int i=0; i<indivRouteList.size(); i++)
  {
    Data part = indivRouteList.get(i);

    for (int j=0; j<vehicle.size(); j++)
    {
      Vehicle v=vehicle.get(j);
      if (v.vehicle==part.vid)
      {
        alreadyInList=true;
      }
    }
    if (alreadyInList==false)
    {

      Vehicle v=new Vehicle(part.vid);

      vehicle.add(v);
    }

    alreadyInList=false;
  }


  float occurences=0;
  for (int o=0; o<vehicle.size(); o++)
  {
    Vehicle v=vehicle.get(o);

    for (int k=0; k<indivRouteList.size(); k++)
    {
      Data part=indivRouteList.get(k);
      if (part.vid==v.vehicle)
      {
        occurences++;
      }
    }
    Frequency b=new Frequency(v.vehicle, occurences);

    frequencies.add(b);
  }
 }

 public void pieChartFrequencyVehicles()
 {
    float total1=0;
  for (int i=0; i<frequencies.size(); i++)
  {
    Frequency f=frequencies.get(i);
    total1=total1+f.occurrence;
  }

  int[] data=new int[frequencies.size()];
  for (int j=0; j<frequencies.size(); j++)
  {
    Frequency f=frequencies.get(j);
    float temp=(f.occurrence/total1)*360;
    data[j]=round(temp);
  }
  int gap=0;
  String title1=("PieChart of percentage of time delayed, on time and early");
  int x=height/2;
  int y=width/2-300;
  float diameter=100;
  PieChart2 p=new PieChart2(diameter, x, y, title1, gap, "piechart showing frequency of certain vehicles", frequencies);
  fill(0);
  p.draw(data);
 }
    
 
}