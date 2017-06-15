class Query
{
  

  public void query1()
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
        if (d.delay<-30)
        {

          earlyCongestion=earlyCongestion+1;
        }
        if (d.delay>30)
        {

          lateCongestion=lateCongestion+1;
        }
        if (d.delay>=-30&&d.delay<=30)
        {

          onTimeCongestion=onTimeCongestion+1;
        }
      }
      if (congestion==0)
      {
        if (d.delay<-30)
        {
          earlyNoCongestion=earlyNoCongestion+1;
        }
        if (d.delay>30)
        {
          lateNoCongestion=lateNoCongestion+1;
        }
        if (d.delay>=-30&&d.delay<=30)
        {
          onTimeNoCongestion=onTimeNoCongestion+1;
        }
      }
     
        float temp=0;
        float total1=earlyCongestion+lateCongestion+onTimeCongestion;
        float total2=earlyNoCongestion+lateNoCongestion+onTimeNoCongestion;
        results= new float[6];
        if (total1!=0)
        {
          temp=(earlyCongestion/total1)*360;
          results[0]=temp;
          temp=(lateCongestion/total1)*360;
          results[1]=temp;
          temp=(onTimeCongestion/total1)*360;
          results[2]=temp;
        }
        if (total2!=0)
        {
          temp=(earlyNoCongestion/total2)*360;
          results[3]=temp;
          temp=(lateNoCongestion/total2)*360;
          results[4]=temp;
          temp=(onTimeNoCongestion/total2)*360;
          results[5]=temp;
        }
      
    }
  }
  public void renderQuery1()
  {
    String header=("Effects of Congestion on Delay");
    float[]angles1=new float[3];
    for (int i=0; i<3; i++)
    {
      angles1[i]=results[i];
    }

   
    float[]angles2=new float[3];
    for (int i=0; i<3; i++)
    {
      angles2[i]=results[i+3];
    }
    int gap=0;
    String title1=("With Congestion");
    int x=width/2-350;
    int y=height/2;
    float diameter=300;
    PieChart p=new PieChart(diameter, x, y, title1, gap, header);
    p.draw(angles1);
    stroke(0);
    strokeWeight(1);
    line(x+320, 50, x+320,height);
    stroke(255);
    x=x+550;
    String title2=("Without Congestion");
    PieChart p2=new PieChart(diameter, x, y, title2, gap, header);
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
        String ts=""+d.ts;
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
    results=new float[3];
    float timesDelayed=0;
    float timesEarly=0;
    float timesOnTime=0;

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
    float[] ratios= new float[3];
    temp=(timesEarly/total)*360;
    results[0]=temp;
    temp=(timesDelayed/total)*360;
    results[1]=temp;
    temp=(timesOnTime/total)*360;
    results[2]=temp;
  }
  public void drawDelayPieChartRoute()
  {
    float[]angles1=new float[3];
    for (int i=0; i<3; i++)
    {
      angles1[i]=results[i];
    }
    int gap=0;
    Data part=indivRouteList.get(1);
    String header=("PieChart of percentage of time delayed for the "+ part.line);
    int x=width/2;
    int y=height/2;
    float diameter=400;
    PieChart p=new PieChart(diameter, x, y, "", gap, header);
    p.draw2(angles1);
  }
  public void Query6()
  {
    map m=new map();
     m.Map();//here would be a good place to set up the map, like its done in the setup , with the lon and lat positions coming from indivRouteList
  }
  public void renderQuery6()
  {
    map.draw();//Here might be a good place to render the map itself, could be something like map.draw even, something small
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
        if (s.stop==part.stopID)
        {
          alreadyInList=true;
        }
      }
      if (alreadyInList==false&&part.stopID!=-1)
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
    if(occurrences.size()<=49)
    {
      blankScreen2.remove(nextPage);
    }
  }
  public void barChartsOfBusStopsVisited()
  {
    float tempSample=occurrences.size();
    
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
       if (occurrences.size()>200)
    {
      tempSample=occurrences.size()/5;
      pages=5;
    }
       if (occurrences.size()>250)
    {
      tempSample=occurrences.size()/6;
      pages=6;
    }
       if (occurrences.size()>300)
    {
      tempSample=occurrences.size()/7;
      pages=7;
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
     Data part=indivRouteList.get(1);
    // Axis appearance
      textFont(stdFont);
    text("Bar Chart of amount of times the "+ part.line+" visits certain stops",width/2-500, 20 );
    textFont(createFont("Serif", 10), 10);  
  
    barChart.showValueAxis(true);
    barChart.setBarLabels(titles);
    barChart.showCategoryAxis(true);
    barChart.draw(50, 0, 1150, 700);
    text("Stops Visited", width/2-100, height-20);
  
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

    float[] data=new float[frequencies.size()];
    for (int j=0; j<frequencies.size(); j++)
    {
      Frequency f=frequencies.get(j);
      float temp=(f.occurrence/total1)*360;
      data[j]=temp;
    }
    int gap=0;
    Data part=indivRouteList.get(1);
    String title1=("PieChart of percentage of time delayed, on time and early, for route "+part.line);
    int x=height/2;
    int y=width/2-300;
    float diameter=400;
    PieChart2 p=new PieChart2(diameter, x, y, title1, gap, "piechart showing frequency of certain vehicles", frequencies);
    fill(0);
    p.draw(data);
  }
  public void query9()
  {

    routeData=new ArrayList();
    float [] delay=new float[indivRouteList.size()];
    float [] distance=new float[indivRouteList.size()];
    for (int i=0; i<indivRouteList.size(); i++)
    {
      Data part=indivRouteList.get(i);
      delay[i]=part.delay;
      float lon1= part.lon*(PI/180);
      float lat1=part.lat*(PI/180);
      float dlon = centreLongitude -lon1;                                           //Gets distance between two co ordinates
      float dlat = centreLatitude - lat1;

      float a=sin(dlat/2)*sin(dlat/2)+cos(lat1)*cos(centreLatitude)*sin(dlon/2)*sin(dlon/2);
      float c = 2 * atan2( sqrt(a), sqrt(1-a) ) ;
      float  d =  6373* c ;
      distance[i]=d;
    }
      scatterplot.setData(delay, distance);

    // Axis formatting and labels.
    scatterplot.showXAxis(true); 
    scatterplot.showYAxis(true); 
    scatterplot.setYFormat("##km");
    scatterplot.setXFormat("###s");
    scatterplot.setXAxisLabel("Delay in Seconds");
    scatterplot.setYAxisLabel("Distance from City Centre in Kilometers");

    // Symbol styles
    scatterplot.setPointColour(color(180, 50, 50, 100));
    scatterplot.setPointSize(5);
    
  }
  public void query10()
  {
    float thisDelay=0;
    float distance=0;
    int instances=0;
    query2();
    routeData=new ArrayList();
    for (int i=0; i<route.size(); i++)
    {
      Routes r=route.get(i);
      for (int j=0; j<dataList.size(); j++)
      {
        Data part=dataList.get(j);
        if (part.line==r.route)
        {
          thisDelay=thisDelay+part.delay;                                                //formulae taken from http://andrew.hedges.name/experiments/haversine/                                                                                     
          float lon1= part.lon*(PI/180);
          float lat1=part.lat*(PI/180);
          float dlon = centreLongitude -lon1;                                           //Gets distance between two co ordinates
          float dlat = centreLatitude - lat1;

          float a=sin(dlat/2)*sin(dlat/2)+cos(lat1)*cos(centreLatitude)*sin(dlon/2)*sin(dlon/2);
          float c = 2 * atan2( sqrt(a), sqrt(1-a) ) ;
          float  d =  6373* c ;
          distance=d+distance;
          instances++;
        }
      }
      distance=distance/instances;
      thisDelay=thisDelay/instances;
      SpecialRouteData d=new SpecialRouteData(thisDelay, distance, r.route);
      routeData.add(d);
      instances=0;
      thisDelay=0;
      distance=0;
    }
    float[] delay=new float[routeData.size()];
    float []distanceArray=new float[routeData.size()];
    for (int j=0; j<routeData.size(); j++)
    {
      SpecialRouteData r=routeData.get(j);
      delay[j]=r.delay;
      distanceArray[j]=r.distanceFromCityCentre;
    }
    scatterplot.setData(delay, distanceArray);

    // Axis formatting and labels.
    scatterplot.showXAxis(true); 
    scatterplot.showYAxis(true); 
    scatterplot.setYFormat("##km");
    scatterplot.setXFormat("###s");
    scatterplot.setXAxisLabel("Delay in seconds");
    scatterplot.setYAxisLabel("Distance from City Centre in kilometers");

    // Symbol styles
    scatterplot.setPointColour(color(180, 50, 50, 100));
    scatterplot.setPointSize(5);
  }
  public void scatterPlot()
  {
   
    fill(255, 0, 0);
    text("Scatter plot of how distance from City Centre effects Delay",width/2-300, 30);
    scatterPlotFont= loadFont("Constantia-10.vlw");
    textFont(scatterPlotFont);
    scatterplot.draw(60, 60, 800, 600);
     textFont(stdFont);
  }
  public void query11()
  {
    
     float tempSample=indivStopList.size();
 
    int x1=100;
    int y1=50;
    int lineCount=0;
    fill(0);
    timeTableFont=loadFont("Constantia-12.vlw");
    textFont(timeTableFont);
    if(indivStopList.size()>78)
    {
       pages=2;
       
         
         
       
      
    }
    if(indivStopList.size()>156)
       {
         pages=3;
       }
       if(indivStopList.size()>234)
         {
           pages=4;
         }
             if(indivStopList.size()>312)
         {
           pages=5;
         }
             if(indivStopList.size()>390)
         {
           pages=6;
         }
           if(indivStopList.size()>468)
         {
           pages=7;
         }
          tempSample=indivStopList.size()/pages;
    int sample=round(tempSample);
       int start=page*sample-sample;
       int amountDone=0;
    for(int i=start;amountDone<sample;i++)
    {
      Data part=indivStopList.get(i);
      long time=part.ts;
      time=time/1000000;
      int delayPositive=abs(part.delay);
      String date = new java.text.SimpleDateFormat("dd.MM.yyy 'at' HH:mm:ss z").format(new java.util.Date (time*1000l));
      text(("At "+date+" bus "+part.line+" came "+ delayPositive+ ((part.delay  <0 ) ? "seconds late" : "seconds early")), x1, y1);
      y1=y1+25;
      stroke(0);
      strokeWeight(1);
      line(x1, y1-15 , width, y1-15 );
      if(y1+100>=800)
      {
        y1=50;
        x1=x1+350;
        lineCount++; 
      }
      if(lineCount>0)
      {
        
        int tempX=x1;
        while(tempX-350>=100)
        {
          line(tempX-25, 0, tempX-25, height);
          tempX=tempX-350;         
        }        
      }
      amountDone++;
    }
  }
  public void query12()
  {
    boolean alreadyInList=false;
 
     routesGoHere=new ArrayList();
   Data s=indivStopList.get(0);
   int stop=s.stopID;
  
      for (int i=0; i<dataList.size(); i++)
    {
      Data part = dataList.get(i);

      if(part.stopID==stop)
      {
        alreadyInList=false;
         
        for(int j=0;j<routesGoHere.size();j++)
        {
          RoutesStops r=routesGoHere.get(j);
          if(r.route==part.line)
          {
           
            alreadyInList=true;
          }
        }
        if(alreadyInList==false)
        {
           RoutesStops r=new RoutesStops(part.line);
           routesGoHere.add(r);
        }
      }
    }
    int count=0;
    data=new int[routesGoHere.size()];
    
   

   
  }
  public void displayRoutes()
  {
      int x2=400;
    int y2=50;
    fill(0);
     timeTableFont=loadFont("Constantia-18.vlw");
    stroke(0);
      strokeWeight(1);
     textFont(timeTableFont);
     Data s=indivStopList.get(1);
    text("The following routes go to stop " +s.stopID, x2, y2);
    x2=60;
    y2=100;
 
    for (int i=0;i<routesGoHere.size();i++)
    {
       RoutesStops r=routesGoHere.get(i);
   
      text(r.route, x2, y2);
      y2=y2+25;
    }
    float[] dataSet=new float[routesGoHere.size()];
    boolean alreadyInList=false;
    int count=0;
    int maxValue=0;
    Data partw= indivStopList.get(0);
    int stop =partw.stopID;
    String[] titles=new String[routesGoHere.size()];
  for(int o=0;o<routesGoHere.size();o++)
    {
     
      RoutesStops r=routesGoHere.get(o);
    for(int j=0;j<dataList.size();j++)
    {
     Data part=dataList.get(j);
      if(r.route==part.line&&part.stopID==stop)
      {
        alreadyInList=false;
        count ++;
      }
      else alreadyInList=true;
    }
     if(alreadyInList==false)
        {
          
           data[o]=count;
        }
        dataSet[o]=count;
        dataSet[o]=r.route;
        if(count>=maxValue)
        {
          maxValue=count;
        }
        count=0;
        titles[o]=""+r.route;
    }
    
     barChart.setData(dataSet);  
    // Scaling
    barChart.setMinValue(0);
    barChart.setMaxValue(maxValue);
  
     Data part=indivRouteList.get(0);
     println(dataSet.length);
    // Axis appearance
      textFont(stdFont);
   
    textFont(createFont("Serif", 10), 10);  
  
    barChart.showValueAxis(true);
    barChart.setBarLabels(titles);
    barChart.showCategoryAxis(true);
    barChart.draw(100, 100, 1100, 600);
    text("Stops Visited", width/2-100, height-20);
    
  }
   public void scatterPlot2()
  {
   
    fill(255, 0, 0);
    Data part=indivRouteList.get(1);
    fill(255);
    text("Scatter plot of how distance from City Centre effects Delay for the "+part.line,width/2-300, 30);
    scatterPlotFont= loadFont("Constantia-10.vlw");
    textFont(scatterPlotFont);
    scatterplot.draw(60, 60, 800, 600);
     textFont(stdFont);
  }
  public void query13()
  {
  }
}