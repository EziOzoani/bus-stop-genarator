import g4p_controls.*;

import codeanticode.glgraphics.*;

import controlP5.*;

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
ControlP5 cp5, cp52;
Table table1;
DropdownList ddl, d2;
PFont  stdFont, routeFont, positionFont, stopFont, kFont, barChartFont, chartFont, timeTableFont, scatterPlotFont;
XYChart scatterplot;
Data d;
PieChart p;
Minim minim, minim2;
AudioSnippet yay;     // sound of when you click "hop on bored " ,Ezi
AudioSnippet ohh;    // sound is played when you click on the pie chart,Ezi 
boolean stopsData;
PImage busStops, mainPageImg, background4Home, pie, busRoute, back, cloud, mapImage;
Data myDataPoints;
String output[], lines[], resultString[];
int x=0;
int y=0;
ArrayList<Data> dataList, indivRouteList, indivStopList, dataListTemp;
ArrayList<RoutesStops> routesGoHere;
ArrayList <SpecialRouteData> routeData;
ArrayList<Occurrences> occurrences;
ArrayList<Routes> route;
ArrayList<Stop> stopList, routeStopList;
ArrayList<Stop> stops;
ArrayList <Frequency> frequencies;
int current_query, result;
float[]results;
ArrayList WidgetList;
int page=1;
int pages=1;
int page2=1;
int pages2=1;
  BarChart barChart;
  
int currentRoute=-1;
int routeNo=-1;
boolean mainScreenOn =false;
boolean mouse = false;
boolean ismousePressed = false;
WidgetButton widget, widget4;
Screen screen1, screen2, currentScreen, screen3, screen4, blankScreen, screen5, screen6, screenH, screenMap, blankScreen2, screen7, screen8, screen9;
WidgetButton HomeScreenWidget, nextWidget, backWidget, stopWidget, EnterWidget, MapWidget, nextPage, previousPage;
void  setup() { 
  scatterplot = new XYChart(this);
  size(1200, 800, P3D);//P3D);
barChart = new BarChart(this);                                        //Used in barChartsOfBusStopsVisited in class Query, had to initialise here David
cp52 = new ControlP5(this);  
  provider1 = new Google.GoogleMapProvider();
  provider2 = new Microsoft.AerialProvider();


  map = new UnfoldingMap(this, provider1);
  MapUtils.createDefaultEventDispatcher(this, map);

  Location dublinLocation = new Location(53.35, -6.26);                  // {these lines
  map.zoomAndPanTo(dublinLocation, 10);                                  // set the center of the map to be dublin
  float maxPanningDistance = 30; // in km                                // if deleted then, the full map of the globe can be seen (note : full map is in half english , half german 
  map.setPanningRestriction(dublinLocation, maxPanningDistance);         // } Note: + "zooms in , or double click on the mouse ", 'up and down keys' - to move up and down or drag map with mouse 

  SimplePointMarker dublinMarker = new SimplePointMarker(dublinLocation);
  dublinMarker.setColor(color(255, 100, 200, 200));//color, try to reduce to 3 values
  dublinMarker.setStrokeColor(color(255, 0, 0));
  strokeWeight(12);
  // Add markers to the map
  map.addMarkers(dublinMarker);
  
  //  DataList  d=new DataList();
   //dataListTemp=d.listArray();
   ArrayList<Marker> markers = new ArrayList<Marker>();
   
   
  /* for(int j =0; j<dataListTemp.size();j++)
   {
   Data part =dataListTemp.get(j);
   float lon=part.lon;
   float lat=part.lat;
   
   Location stops = new Location(lat, lon);  //list = list of data
   SimplePointMarker stopMarker = new SimplePointMarker(stops); 
   stopMarker.setColor(color(255,100,200, 200));//color, try to reduce to 3 values
   stopMarker.setStrokeColor(color(255, 0, 0));
   strokeWeight(12);
   markers.add(stopMarker);
   
   }
   
   
   
   */map.addMarkers(markers);
   
  back= loadImage("backwithbluebackground.png");// back button image - from - <div>Icons made by <a href="http://www.flaticon.com/authors/linh-pham" title="Linh Pham">Linh Pham</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
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


  stdFont=loadFont("Constantia-26.vlw"); 
  kFont=loadFont("ComicSansMS-BoldItalic-34.vlw");
  textFont(stdFont);




  //300,700,158,50,3,6,1,18
  MapWidget= new WidgetButton(220, 360, 100, 90, "Map", color(255), color(255), kFont, EVENT_MAP); 
  EnterWidget = new WidgetButton(490, 300, 158, 50, "Hop on Board", color(204, 229, 255), color(51, 51, 255), kFont, EVENT_ENTER);
  textFont(stdFont);
  HomeScreenWidget = new WidgetButton(width/2-100, 100, 110, 100, "pieChart", color(255), color(255), stdFont, EVENT_1);
  WidgetList = new ArrayList();
  nextWidget=new WidgetButton(width/2-80, 600, 100, 90, "routeData", color(255), color(255), stdFont, BUS_QUERY);
  backWidget=new WidgetButton(25, 600, 40, 40, "", color(140, 234, 249), color(140, 234, 249), stdFont, EVENT_BACK);
  stopWidget=new WidgetButton(850, 360, 100, 90, "bus stops", color(255), color(255), stdFont, EVENT_13);
  screenH= new Screen(color(140, 234, 249), "");
  screenMap=new Screen(color(140, 234, 249), "");
  screen1 = new Screen(color(140, 234, 249), "Please select an image to learn more" );

  screen3 = new Screen(color(140, 234, 249), "");
  screen5=new Screen(color(140, 234, 249), "Pick a stop to see its data");
  screen6=new Screen(color(140, 234, 249), "Fix in post");

  blankScreen=new Screen(color(140, 234, 249), "");
  blankScreen2=new Screen(color(140, 234, 249), "");
  WidgetList.add(HomeScreenWidget);
  blankScreen.add(backWidget);
  WidgetList.add(nextWidget);
  WidgetList.add(MapWidget);
  screenH.add(EnterWidget);
  screen1.add(HomeScreenWidget);
  screen1.add(MapWidget);
  screen1.add(nextWidget);
  screen1.add(stopWidget);
  blankScreen2.add(backWidget);

  nextPage=new WidgetButton(1050, 700, 100, 30, "nextPage", color(155, 1555, 155), color(155, 155, 155), stdFont, EVENT_NEXT_PAGE);
  previousPage=new WidgetButton(850, 700, 100, 30, "PeviousPage", color(155, 1555, 155), color(155, 155, 155), stdFont, EVENT_PREVIOUS_PAGE);
  blankScreen2.add(nextPage);

  //currentScreen=screen1;
  currentScreen= screenH;
  current_query = queryH;
}

void draw()                             
{
  currentScreen.draw();
  //form my experience anyway 
  if (currentScreen==screenMap)
  {
    map.draw();
  }                                                                            //  ,ezi *}

  if (currentScreen!=screenH&&currentScreen!=screen1)
  {
    image(back, 25, 600, 40, 40);
  }
  Query q=new Query();
  switch(current_query)
  {

  case queryH:                                                        //Screenh stuff
    if (currentScreen!=screenMap)
    {
    
    }
    if (currentScreen==screenH&&currentScreen!=screenMap)
    {

      image(cloud, 90, 90, 200, 100);
      image(cloud, 900, 90, 200, 100);
      image(cloud, 900, 400, 200, 100);
      image(cloud, 90, 400, 200, 100);
      image(cloud, 490, 550, 200, 100);
    }
    break;
  case mainQuery:                                                  //Screen 1 stuff
    image(cloud, width/2-180, 40, 310, 200);            //{                                * {
    image(pie, width/2-80, 90, 110, 100);         // widgets are in                           please do not
    image(cloud,width/2-180, 530, 310, 200);          //cloud images                              move these 2 
    image(busRoute, width/2-80, 600, 100, 90);    //if it needs to be changed                  if statements around 
    image(cloud, 740, 305, 310, 200);        // change the (x,y,width,hight)               leave in this order ,unless
    image(busStops, 850, 360, 100, 90);   // of the widgets in setup                    map starts to glitch 
    image(cloud, 120, 305, 310, 200);         // Ezi
    image(mapImage, 220, 360, 100, 90);       //}
    break;
  case query1:                                                      
                                                    //Screen 2 stuff(pieChart)
      q.renderQuery1();
     
    
    break;

  case query5:                                          //Blank Screen   delay of route
    if (currentScreen==blankScreen)
    {
      q.drawDelayPieChartRoute();

    }

    break;
  case query6:                                          //Blank Screen   position of route
    if (currentScreen==blankScreen)
    {
      map.draw();
      //The rendering of the maps should be in this function in class Query Ezi, explained it in the comments in the query 6 methods in class query David. 
      //Probably be a good idea to make a second map screen instead of using blankScreen
     // q.renderQuery6;
      
    }
    break;
  case query7:
   q.barChartsOfBusStopsVisited();
    break;
  case query8:
    if (currentScreen==blankScreen)
    {            //Blank Screen    frequency vehicle on route
      q.pieChartFrequencyVehicles();
    }
    break;
    case query9:
    q.scatterPlot2();
  case noQuery:
  if(currentScreen==screen3)
  {
    fill(255);
  if(stopsData==false)
  {
    text("Please select a route to see its data", width/2-200, 20);
  }
  else if(stopsData==true)
  {
  text("Please select a route to see its stops data", width/2-200, 20);
  }
  }
    break;
    case query10:
    q.scatterPlot();
    break;
    case query11:
    q.query11();
    break;
    case query12:
    q.displayRoutes();
  }
}

void mousePressed() {   //Changed code to make seperate Screens, David
  //added ability to go back screens, David
  //mainScreenOn=false;
  //split up code into differant classes David
  EventGetter e=new EventGetter();
  int eventTemp=currentScreen.getEvent(mouseX, mouseY);
 
  int event=e.getEvent(currentScreen, eventTemp);
  EventDoer doNow=new EventDoer();                                          

  doNow.doEvent(event, eventTemp);
}

void keyPressed() {

  if (key == '1') {
    map.mapDisplay.setProvider(provider1);
  } else if (key == '2') {
    map.mapDisplay.setProvider(provider2);
  }
  if (key=='3'){
    currentScreen=screen1;
  }
}

//Temp location hopefully, will move to different class if there is Time, and have a next page if there is too much routes to display, with a technique like I did for bar chart, David
public Screen screen3Build(ArrayList<Routes> route)                  //Added Screen displaying routes, David
{
  
   screen3.add(backWidget);
  String[]routeNames=new String[route.size()];
  for (int i=0; i<route.size(); i++)
  {
    Routes r=route.get(i);
    routeNames[i]=""+r.route;                                  //This drop down list is built on the controlP5 library
  }                                                            //The template for this code was taken from http://www.sojamo.de/libraries/controlP5/examples/controllers/ControlP5dropdownList/ControlP5dropdownList.pde
  cp5 = new ControlP5(this);                                  //and modified slightly  David
  // create a DropdownList
  ddl = cp5.addDropdownList("List of BusRoutes") .setPosition(100, 80) .setSize(1000, 650)  ;

  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(40);

  for (int i=0; i<routeNames.length; i++) {
    String temp=routeNames[i];
    ddl.addItem(temp, i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(110, 110, 110));
  ddl.setColorActive(color(255, 255, 255));
  
  current_query=noQuery;
  return screen3;
}
void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup

  } else if (theEvent.isController()) {
    Query q=new Query();
    float  item=theEvent.getController().getValue();
    int index=(int)item;
    ddl.hide();
    if(stopsData==false)
    
    {
     
    q.query4(dataList, index);
//    indivRouteList=query4(dataList, index);                    //List containing every dataPoint of route selected
    Screen4 screen=new Screen4();
    screen4=screen.buildScreen(index);
    currentScreen=screen4;

    current_query=noQuery;
    }
    else if(stopsData==true)
    {
    q.query4(dataList, index);
    Screen7 screen=new Screen7();
      screen7=screen.buildScreen7(indivRouteList);
      currentScreen=screen7;
    }
  }
}