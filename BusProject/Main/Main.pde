import org.gicentre.utils.spatial.*;
import org.gicentre.utils.network.*;
import org.gicentre.utils.network.traer.physics.*;
import org.gicentre.utils.geom.*;
import org.gicentre.utils.move.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.gui.*;
import org.gicentre.utils.colour.*;
import org.gicentre.utils.text.*;
import org.gicentre.utils.*;
import org.gicentre.utils.network.traer.animation.*;
import org.gicentre.utils.io.*;

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

UnfoldingMap map;
AbstractMapProvider provider1;
AbstractMapProvider provider2;

PFont  stdFont, routeFont, positionFont, stopFont, kFont, barChartFont, chartFont;
BarChart barChart;
Data d;
PieChart p;
Minim minim, minim2;
AudioSnippet yay;     // sound of when you click "hop on bored " ,Ezi
AudioSnippet ohh;    // sound is played when you click on the pie chart,Ezi 


PImage busStops, mainPageImg, background4Home, pie, busRoute, back,cloud,mapImage;
Data myDataPoints;
String output[], lines[], resultString[];
int x=0;
int y=0;
ArrayList<Data> dataList, indivRouteList, indivStopList;
ArrayList<Occurrences> occurrences;
ArrayList<Routes> route;
ArrayList<Stop> stopList;
ArrayList<Stop> stops;
ArrayList <Frequency> frequencies;
int current_query, result;
int[]results;
ArrayList WidgetList;
int page=1;
int pages=1;
final int EVENT_NULL = 0; 
final int EVENT_1 = 1;                //
final int EVENT_2 = 2;
final int EVENT_3 = 3;
final int EVENT_4=4;
final int EVENT_5=5;
final int EVENT_BACK=15;            //back button event David
final int EVENT_NEXT_PAGE=300;            //back button event David
final int EVENT_PREVIOUS_PAGE=301;            //back button event David
final int EVENT_ENTER =14;
final int EVENT_6=6;                 //Maps to Bus stops, Thomas and David
final int EVENT_7=7;               //Maps to screen with delay, time etc widgets for one stop, by Thomas and David
final int EVENT_8=8;    
final int EVENT_MAP=13;
final int query5=5;
final int query6=6;
final int query7=7;
final int query8=8;
final int query9=9;
final int queryH=-1;
final int queryNull=-2;
final int query10=10;
final int mainQuery=0;
final int BUS_QUERY=2;
final int homeScreen=1;
final int query1=2;
final int busRoutes=3;
final int pieChart2=4;
final int query3=5;

boolean mainScreenOn =false;
boolean mouse = false;
boolean ismousePressed = false;
WidgetButton widget, widget4;
Screen screen1, screen2, currentScreen, screen3, screen4, blankScreen, screen5, screen6, screenH, screenMap, blankScreen2;
WidgetButton HomeScreenWidget, nextWidget, backWidget, stopWidget, EnterWidget, MapWidget, nextPage, previousPage;
void  setup() { 
  size(1000, 1000,P3D);
  provider1 = new Google.GoogleMapProvider();
   provider2 = new Microsoft.AerialProvider();
   
   
   map = new UnfoldingMap(this, provider1);
   MapUtils.createDefaultEventDispatcher(this, map);
   
   Location dublinLocation = new Location(53.35, -6.26);                  // {these lines
   map.zoomAndPanTo(dublinLocation, 10);                                  // set the center of the map to be dublin
   float maxPanningDistance = 30; // in km                                // if deleted then, the full map of the globe can be seen (note : full map is in half english , half german 
   map.setPanningRestriction(dublinLocation, maxPanningDistance);         // } Note: + "zooms in , or double click on the mouse ", 'up and down keys' - to move up and down or drag map with mouse 
   
   SimplePointMarker dublinMarker = new SimplePointMarker(dublinLocation);
   
   // Add markers to the map
   map.addMarkers(dublinMarker);
   
    /*for(int j =0; j<dataList.size();j++)
   {
     Location stops = new Location(dataList.get(j).lat, dataList.get(j).lon);  //list = list of data
     println(stops);
     SimplePointMarker stopMarker = new SimplePointMarker(stops); 
     stopMarker.setColor(color(100,100,200,50));//color, try to reduce to 3 values
     map.addMarkers(stopMarker);
     
   }
 
    */
   
   
  back= loadImage("back.png");// back button image - from - <div>Icons made by <a href="http://www.flaticon.com/authors/linh-pham" title="Linh Pham">Linh Pham</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
  busStops= loadImage("bus_loading.gif");
  background4Home=loadImage("BD.jpg");
  busRoute = loadImage("busStop.png");
   mapImage= loadImage("map.png");
    cloud= loadImage("fluffy_clou.jpeg");
  mainPageImg = loadImage("template_internal2.jpg");
  pie= loadImage("apple_pie03.jpg");   //pie chart button image - http://www.allthingsclipart.com/apple.pie.clipart.htm
  minim = new Minim(this);
  minim2 = new Minim(this); 
  yay= minim.loadSnippet("yay.wav");
  ohh =  minim.loadSnippet("ohh.wav");
  //


  stdFont=loadFont("ArialMT-24.vlw"); 
  kFont=loadFont("ComicSansMS-BoldItalic-34.vlw");
  textFont(kFont);




  //300,700,158,50,3,6,1,18
  MapWidget= new WidgetButton(160,350,100,90,"Map",color(255),color(255),kFont,EVENT_MAP); 
  EnterWidget = new WidgetButton(300, 300, 158, 50, "Hop on Board", color(204, 229, 255), color(51, 51, 255), kFont, EVENT_ENTER);
  textFont(stdFont);
  HomeScreenWidget = new WidgetButton(490, 100, 110, 100, "pieChart", color(255), color(255), stdFont, EVENT_1);
  WidgetList = new ArrayList();
  nextWidget=new WidgetButton(450, 600, 100, 90, "routeData", color(255), color(255), stdFont, EVENT_2);
  backWidget=new WidgetButton(25, 600, 40, 40, "back", color(255), color(255), stdFont, EVENT_BACK);
  stopWidget=new WidgetButton(720, 370, 100, 90, "bus stops", color(255), color(255), stdFont, EVENT_6);
  screenH= new Screen(color(255), "");
  screenMap=new Screen(color(255), "");
  screen1 = new Screen(color(255), "" );
  screen2 = new Screen(color(255), "Effects of Congestion on Delay");
  screen3 = new Screen(color(255), "Pick a route to see its data");
  screen5=new Screen(color(255), "Pick a stop to see its data");
  screen6=new Screen(color(255), "Fix in post");
  screen2=new Screen(color(255),"");
    blankScreen=new Screen(color(255), "");
  blankScreen2=new Screen(color(255), "");
  WidgetList.add(HomeScreenWidget);
  blankScreen.add(backWidget);
  WidgetList.add(nextWidget);
  WidgetList.add(MapWidget);
  screenH.add(EnterWidget);
  screen1.add(HomeScreenWidget);
  screen1.add(MapWidget);
  screen1.add(nextWidget);
  screen1.add(stopWidget);
  screen2.add(backWidget);
 nextPage=new WidgetButton(850, 700, 100, 25, "nextPage", color(255), color(255), stdFont, EVENT_NEXT_PAGE);
 previousPage=new WidgetButton(650, 700, 100, 25, "lastPage", color(255), color(255), stdFont, EVENT_PREVIOUS_PAGE);
 blankScreen2.add(nextPage);

  //currentScreen=screen1;
  currentScreen= screenH;
  current_query = queryH;
}

void draw()                             
{

   background(255);

  currentScreen.draw();
  if(currentScreen==screen1)
  {
     image(cloud,400,40,310,200);            //{                                * {
    image(pie,490, 100, 110, 100);         // widgets are in                           please do not
    image(cloud,350,530,310,200);          //cloud images                              move these 2 
    image(busRoute,450, 600, 100, 90);    //if it needs to be changed                  if statements around 
    image(cloud,620,305,310,200);        // change the (x,y,width,hight)               leave in this order ,unless
    image(busStops,720, 370, 100, 90);   // of the widgets in setup                    map starts to glitch 
    image(cloud,60,280,310,200);         // Ezi
    image(mapImage,160,350,100,90);       //}
  }
                                                                                    //form my experience anyway 
  if(currentScreen==screenMap)
   {
     map.draw();
   }                                                                            //  ,ezi *}
   
  if (currentScreen!=screenH&&currentScreen!=screen1)
  {
    image(back, 25, 600, 40, 40);
  }

  switch(current_query)
  {

  case queryH:
  if(currentScreen!=screenMap)
  {
    image(background4Home, 0, 750);
  }
  if(currentScreen==screenH)
  {
    image(cloud,90,90,200,100);
    image(cloud,700,90,200,100);
    image(cloud,700,400,200,100);
    image(cloud,90,400,200,100);
    image(cloud,400,550,200,100);
  }
    break;
  case mainQuery:
    
    break;
  case query1:
    if (currentScreen==screen2)
    {
      renderQuery1(results);                //render pie charts, needs to be done(Comment by David)
    }
    break;
  case busRoutes:

    break;
  case query5:
    if (currentScreen==blankScreen)
    {
      renderQuery5(results);
    }

    break;
  case query6:
     if (currentScreen==blankScreen)
    {
      renderQuery6(results);
    }
    break;
  case query7:

      query7Render(occurrences);
    
   
    break;
  case query8:
if (currentScreen==blankScreen)
    {
    query8Render(frequencies);
    }
  }
}

void mousePressed() {   //Changed code to make seperate Screens, David
  //added ability to go back screens, David
  //mainScreenOn=false;
  int event;
  int eventTemp;
  DataList D=new DataList();
  event=currentScreen.getEvent(mouseX, mouseY);
  eventTemp=event;
  int amountWidgets1=screen3.size();
  int amountWidgets2=screen5.size();
  if (current_query>=busRoutes&&current_query<=query8)
  {  

    if (event> EVENT_3&&event<=(EVENT_3+amountWidgets1))
    {
      if (event!=EVENT_BACK||current_query==queryNull)
      {

        event=EVENT_4;
      } else if (event==EVENT_BACK&&currentScreen==screen3)
      {
        currentScreen=screen1;
        current_query=mainQuery;
      }
    }
    if (((event> (EVENT_3+amountWidgets1)&&event<=(EVENT_3+amountWidgets1+5))||event==EVENT_BACK)&&current_query<=query8)
    {

      if (event!=EVENT_BACK)
      {

        event=EVENT_5;
      } else if (event==EVENT_BACK)
      {
        println("hi");
        currentScreen=screen4;
      }
    }
  }
  if (current_query>=query10)
  {
    if (event> EVENT_3&&event<=(EVENT_3+amountWidgets2)||currentScreen==screen5&&event==EVENT_BACK)
    {
      if (event!=EVENT_BACK)
      {
        event=EVENT_7;
      } else if (event==EVENT_BACK&&currentScreen==screen5)
      {

        currentScreen=screen1;
        current_query=mainQuery;
      }
    }
    if (event> (EVENT_3+amountWidgets2)&&event<=(EVENT_3+amountWidgets2+5)&&current_query!=query8)
    {
      if (event!=EVENT_BACK)
      {

        event=EVENT_8;
      }
    }
  }
  switch(event)                                                  
  {
  case EVENT_MAP:

    currentScreen=screenMap;
    ismousePressed = false;
    break;

  case EVENT_ENTER :
    currentScreen= screen1;
    event= EVENT_1;
    ismousePressed = false;
    mainScreenOn=true;
    current_query=mainQuery;
    yay.play();
    break;

  case EVENT_1:
    currentScreen=screen2;

    dataList=D.listArray();
    results=query1(dataList);
    current_query=query1;
    ohh.rewind();
    ohh.play();
    ismousePressed = false;
    break;
  case BUS_QUERY:

    dataList=D.listArray();
    route=query2(dataList);
    screen3=screen3Build(route);
    currentScreen=screen3;
    current_query=busRoutes; 

    break;
  case EVENT_BACK:

    if (currentScreen==screen2)
    {

      currentScreen=screen1;
      current_query=mainQuery;
    }

    if (currentScreen==screen4)
    {
      event=eventTemp;
      screen3=screen3Build(route);
      currentScreen=screen3;
    }
    if (currentScreen==screen6)
    {
      currentScreen=screen5;
    }


    // mainScreenOn=true;

    break;
  case EVENT_4:

    int i=eventTemp-4;
    screen4=screen4Build(i, amountWidgets1+3);
    indivRouteList=query4(dataList, i);                    //List containing every dataPoint of route selected
    currentScreen=screen4;


    break;
  case EVENT_5:
    if (eventTemp==EVENT_3+amountWidgets1+1)                                  
    {
      results=query5( indivRouteList);
      current_query=query5;
      currentScreen=blankScreen;
      //delay Data
    }
    if (eventTemp==EVENT_3+amountWidgets1+2)
    {
    
      resultString=Query6(indivRouteList);
      current_query=query6;
      currentScreen=blankScreen;
    }
    if (eventTemp==EVENT_3+amountWidgets1+3)
    {
      occurrences=query7(indivRouteList);
      current_query=query7;
      currentScreen=blankScreen2;
      //Stop Data
    }
    if (eventTemp==EVENT_3+amountWidgets1+4)
    {
      current_query=query8;
      frequencies=query8(indivRouteList);
      currentScreen=blankScreen;
   
      //VID Data
    }
    if (eventTemp==EVENT_3+amountWidgets1+5)
    {
      //current_query=query9;
      //   results=query6( indivRouteList); needs some wrapping up before its finished David
      //   current_query=query6;
      //   currentScreen=blankScreen;
      //Time At Stop Data
    }
    break;
  case EVENT_6:
    mainScreenOn=false;      // for bus data
    dataList=D.listArray();
    stops=query10(dataList);
    current_query=query10;
    screen5=screen5Build(stops);
    currentScreen=screen5;
    break;
  case EVENT_7:

    int j=eventTemp-4;
    indivStopList=query9(dataList, j);                    //List containing every dataPoint of route selected
    screen6=screen6Build(j, amountWidgets2+3);

    currentScreen=screen6;
    break;
     case EVENT_NEXT_PAGE:
     int previousPageNo=page;
     page=page+1;

     if(pages==page)
     {
       blankScreen2.remove(nextPage);
     }
     if(previousPageNo==1)
     {
       blankScreen2.add(previousPage);
     }
   break;
   case EVENT_PREVIOUS_PAGE:
   int previousPageNo2=page;
       page=page-1;
     if(pages==1)
     
     {
   
       blankScreen2.remove(previousPage);
     }
     if(previousPageNo2==pages)
     {
       blankScreen2.add(nextPage);
     }
   break;
  }
}
void keyPressed() {
  if (key == '1') {
   map.mapDisplay.setProvider(provider1);
   } else if (key == '2') {
   map.mapDisplay.setProvider(provider2);
   }
   
}




int [] query1(ArrayList<Data> dataList)                      //code by David
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
      int[] ratios= new int[6];
      if (total1!=0)
      {
        temp=(earlyCongestion/total1)*360;
        ratios[0]=round(temp);
        temp=(lateCongestion/total1)*360;
        ratios[1]=round(temp);
        temp=(onTimeCongestion/total1)*360;
        ratios[2]=round(temp);
      }
      if (total2!=0)
      {
        temp=(earlyNoCongestion/total2)*360;
        ratios[3]=round(temp);
        temp=(lateNoCongestion/total2)*360;
        ratios[4]=round(temp);
        temp=(onTimeNoCongestion/total2)*360;
        ratios[5]=round(temp);
      }
      return ratios;
    }
  }
  return null;
}
public ArrayList<Routes> query2(ArrayList<Data> dataList)
{

  boolean alreadyInList=false;
  ArrayList<Routes> route = new ArrayList<Routes>();

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
  return route;
}

public ArrayList<Data> query4(ArrayList<Data> dataList, int i)              //This function adds every instance of the route selected to a list, David
{
  Routes r=route.get(i);
  int route=r.route;
  DataList data=new DataList();
  ArrayList<Data> indivRoute = new ArrayList<Data>();
  for (int j=0; j<dataList.size(); j++)
  {
    Data d=dataList.get(j);
    if (d.line==route)
    {
      String ts=d.ts;
      String line=""+d.line;
      String congestion=""+d.congestion;
      String lon=d.lon;
      String lat=d.lat;
      String delay=""+d.delay;
      String vid=""+d.vid;
      String sid=""+d.stopID;
      String atshop=d.atshop;
      Data newData=new Data(ts, line, congestion, lon, lat, delay, vid, sid, atshop);     //Previous code I ahd written was incorrect, was adding the same data every time, David
      indivRoute.add(newData);
    }
  }
  return indivRoute;
}
void renderQuery1(int []angles)                        //the angles are stored in results array. results 1,2 and 3 are when there was congestion, opposite for 4,5, and 6(Comment by David)                                                    
  //Will need to edit sample bus data to get more interesting results, so far there is never any congestion
{
  int[]angles1=new int[3];
  for (int i=0; i<3; i++)
  {
    angles1[i]=angles[i];
  }

  // p.draw(10, angles1);
  int[]angles2=new int[3];
  for (int i=0; i<3; i++)
  {
    angles2[i]=angles[i+3];
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
public Screen screen3Build(ArrayList<Routes> route)                  //Added Screen displaying routes, David
{
  int j=4;
  int x=300;
  int y=200;
  String routeName;
  routeFont=loadFont("ArialMT-12.vlw");
  screen3.add(backWidget);
  for (int i=0; i<route.size(); i++)
  {

    Routes r=route.get(i);
    routeName=""+r.route;
    widget=new WidgetButton(x, y, 80, 40, routeName, color(0), color(255), routeFont, j);
    screen3.add(widget);
    j++;
    y=y+50;
    if (y+700>height)
    {
      y=200;
      x=x+100;
    }
  }
  return screen3;
}
public Screen screen4Build(int i, int size)                            //Building Screen with variable widgets, David
{
  int x=20;
  int y=20;
  Routes r=route.get(i);
  String delay="delay data";
  String position="position";
  String stopID="stops";
  String vID="vehicle ID";
  String timeAtStop="time at Stop";
  int routeNumber=r.route;
  String title="Data for "+routeNumber;
  String title2;
  int j=size+1;

  screen4=new Screen(color(255), title);
  screen4.add(backWidget);
  for (i=0; i<5; i++)
  {
    switch(i)
    {
    case 0:
      title2=delay;
      widget=new WidgetButton(x, y, 150, 50, title2, color(0), color(255), routeFont, j);
      screen4.add(widget);
      break;
    case 1:
      title2=position;
      widget=new WidgetButton(x, y, 150, 50, title2, color(0), color(255), routeFont, j);
      screen4.add(widget);
      break;
    case 2:
      title2=stopID;
      widget=new WidgetButton(x, y, 150, 50, title2, color(0), color(255), routeFont, j);
      screen4.add(widget);
      break;
    case 3:
      title2=vID;
      widget=new WidgetButton(x, y, 150, 50, title2, color(0), color(255), routeFont, j);
      screen4.add(widget);
      break;
    case 4:
      title2=timeAtStop;
      widget=new WidgetButton(x, y, 150, 50, title2, color(0), color(255), routeFont, j);
      screen4.add(widget);
      break;
    }
    y=y+70;
    j++;
  }
  return screen4;
}
public int[] query5(ArrayList<Data> indivRouteList)                  //Code by david, used to display pieChart
{
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
  int[] ratios= new int[3];
  temp=(timesEarly/total)*360;
  ratios[0]=round(temp);
  temp=(timesDelayed/total)*360;
  ratios[1]=round(temp);
  temp=(timesOnTime/total)*360;
  ratios[2]=round(temp);
  return ratios;
}

public void  renderQuery5(int[]angles)
{
  int[]angles1=new int[3];
  for (int i=0; i<3; i++)
  {
    angles1[i]=angles[i];
  }
  int gap=0;
  String title1=("PieChart of percentage of time delayed, on time and early");
  int x=height/2;
  int y=width/2-300;
  float diameter=100;
  PieChart p=new PieChart(diameter, x, y, title1, gap);
  p.draw(angles1);
}

public ArrayList<Stop> query10(ArrayList<Data> dataList)
{

  boolean alreadyInList=false;
  ArrayList<Stop> stops = new ArrayList<Stop>();

  for (int i=0; i<dataList.size(); i++)
  {
    Data part = dataList.get(i);

    for (int j=0; j<stops.size(); j++)
    {
      Stop s=stops.get(j);
      if (s.stop==part.stopID||part.stopID==-1)
      {
        alreadyInList=true;
      }
    }
    if (alreadyInList==false)
    {
      Stop s=new Stop(part.stopID);
      stops.add(s);
    }
    alreadyInList=false;
  }
  return stops;
}

public ArrayList<Occurrences> query7(ArrayList<Data> indivRouteList)                            //This code would have been used to display bar chart, but kept getting errors. Will be fixed over weekend
{
  boolean alreadyInList=false;
  ArrayList<Stop> stopID = new ArrayList<Stop>();
  ArrayList<Occurrences> occurence=new ArrayList<Occurrences>();
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
    occurence.add(b);
  }

  return occurence;
}
public void renderQuery6(int[]results)
{
  for (int i=0; i<results.length; i++)
  {
  }
}

public String []Query6(ArrayList<Data> indivRouteList)
{
  String[] string=new String[indivRouteList.size()];

  for (int i=0; i<indivRouteList.size(); i++)
  {
    Data in=indivRouteList.get(i);
    String title ="X co ordinate "+in.lat+" Y co ordinate "+ in.lon;
    string[i]=title;
  }

  return string;
}
public Screen screen5Build(ArrayList<Stop> stops)
{
  int j=4;
  int x=200;
  int y=20;
  String stopName;
  stopFont=loadFont("ArialMT-12.vlw");
  screen5.add(backWidget);
  for (int i=0; i<stops.size(); i++)
  {

    Stop s=stops.get(i);
    stopName=""+s.stop;
    widget4=new WidgetButton(x, y, 80, 40, stopName, color(0), color(255), stopFont, j);
    screen5.add(widget4);
    j++;
    y=y+50;
    if (y>1000-400)
    {
      y=20;
      x=x+100;
    }
  }
  return screen5;
}
public void renderQuery6(String[] resultString)                  //Code by David
{
  int x=40;
  int y=0;
  positionFont=loadFont("ArialMT-10.vlw"); 
  textFont(positionFont);
  for (int i=0; i<resultString.length; i++)
  {
    fill(0);
    text(resultString[i], x, y);
    y=y+15;
    if (y+100>1000)
    {
      y=0;
      x=x+300;
    }
  }
}
public ArrayList<Data> query9(ArrayList<Data> dataList, int i)              //This function adds every instance of the route selected to a list, David
{
  Stop s=stops.get(i);
  int stop=s.stop;
  DataList data=new DataList();
  ArrayList<Data> indivStop = new ArrayList<Data>();
  for (int j=0; j<dataList.size(); j++)
  {
    Data d=dataList.get(j);
    if (d.stopID==stop)
    {
      String ts=d.ts;
      String line=""+d.line;
      String congestion=""+d.congestion;
      String lon=d.lon;
      String lat=d.lat;
      String delay=""+d.delay;
      String vid=""+d.vid;
      String sid=""+d.stopID;
      String atshop=d.atshop;
      Data newData=new Data(ts, line, congestion, lon, lat, delay, vid, sid, atshop);    
      indivStop.add(newData);
    }
  }
  return indivStop;
}
public Screen screen6Build(int i, int size)                            //Building Screen for bus stops with variable widgets, David and Thomas
{
  int x=20;
  int y=20;
  Stop s=stops.get(i);
  String delay="delay data";
  String position="position";
  String stopID="stops";
  String vID="vehicle ID";
  String timeAtStop="time at Stop";
  int stopNumber=s.stop;
  String title="Data for "+stopNumber;
  String title2;
  int j=size+1;
  screen6=new Screen(color(255), title);
  screen6.add(backWidget);
  for (i=0; i<5; i++)
  {
    switch(i)
    {
    case 0:
      title2=delay;
      widget=new WidgetButton(x, y, 150, 50, title2, color(0), color(255), stopFont, j);
      screen6.add(widget);
      break;
    case 1:
      title2=position;
      widget=new WidgetButton(x, y, 150, 50, title2, color(0), color(255), stopFont, j);
      screen6.add(widget);
      break;
    case 2:
      title2=stopID;
      widget=new WidgetButton(x, y, 150, 50, title2, color(0), color(255), stopFont, j);
      screen6.add(widget);
      break;
    case 3:
      title2=vID;
      widget=new WidgetButton(x, y, 150, 50, title2, color(0), color(255), stopFont, j);
      screen6.add(widget);
      break;
    case 4:
      title2=timeAtStop;
      widget=new WidgetButton(x, y, 150, 50, title2, color(0), color(255), stopFont, j);
      screen6.add(widget);
      break;
    }
    y=y+70;
    j++;
  }
  return screen6;
}
public void query7Render(ArrayList<Occurrences> occurrence)          
{


  float tempSample=occurrence.size();;
if(occurrence.size()>50)
{
  tempSample=occurrence.size()/2;
  pages=2;
}
if(occurrence.size()>100)
{
 tempSample=occurrence.size()/3;
  pages=3;
}
if(occurrence.size()>150)
{
  tempSample=occurrence.size()/4;
  pages=4;
}

int sample=round(tempSample);
int start=page*sample-sample;

 barChart = new BarChart(this);
 int maxAmount=0;
 int amountDone=0;
   String[] titles=new String[sample];
  float[] dataSet=new float[sample];
 for(int i=start;amountDone<sample;i++)
 {
   Occurrences part=occurrence.get(i);
   dataSet[amountDone]=part.occurrence;
   titles[amountDone]=""+part.stop;
   if(part.occurrence>=maxAmount)
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
  textFont(createFont("Serif",10),10);   
  barChart.showValueAxis(true);
  barChart.setBarLabels(titles);
  barChart.showCategoryAxis(true);
 barChart.draw(50,0,950,700);
}
public ArrayList<Frequency> query8(ArrayList<Data> indivRouteList)                            //This code would have been used to display bar chart, but kept getting errors. Will be fixed over weekend
{
  boolean alreadyInList=false;
  ArrayList<Vehicle> vehicle = new ArrayList<Vehicle>();
  ArrayList<Frequency> frequency=new ArrayList<Frequency>();
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

    frequency.add(b);
  }

  return frequency;
}
public void query8Render(ArrayList<Frequency> frequency)
{

  float total1=0;
  for (int i=0; i<frequency.size(); i++)
  {
    Frequency f=frequency.get(i);
    total1=total1+f.occurrence;
  }

  int[] data=new int[frequency.size()];
  for (int j=0; j<frequency.size(); j++)
  {
    Frequency f=frequency.get(j);
    float temp=(f.occurrence/total1)*360;
    data[j]=round(temp);
  }
  int gap=0;
  String title1=("PieChart of percentage of time delayed, on time and early");
  int x=height/2;
  int y=width/2-300;
  float diameter=100;
  PieChart2 p=new PieChart2(diameter, x, y, title1, gap, "piechart showing frequency of certain vehicles", frequency);
  fill(0);
  p.draw(data);
}