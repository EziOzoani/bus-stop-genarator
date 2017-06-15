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


UnfoldingMap map;
AbstractMapProvider provider1;
AbstractMapProvider provider2;

 
void setup() {
  MapWidget= new WidgetButton(300,300,158,50,"Map",color(0),color(255),kFont,EVENT_MAP); 
    size(800, 600);
 final int EVENT_MAP=13;
    provider1 = new Google.GoogleMapProvider();
    provider2 = new Microsoft.AerialProvider();
   
 
    map = new UnfoldingMap(this, provider1);
    MapUtils.createDefaultEventDispatcher(this, map);
    
    Location dublinLocation = new Location(53.35, -6.26);                  // {these lines
    map.zoomAndPanTo(dublinLocation, 10);                                  // set the center of the map to be dublin
    float maxPanningDistance = 30; // in km                                // if deleted then, the full map of the globe can be seen (note : full map is in half english , half german 
   map.setPanningRestriction(dublinLocation, maxPanningDistance);         // } Note: + "zooms in , or double click on the mouse ", 'up and down keys' - to move up and down or drag map with mouse 
    
    
// Create point markers for locations
//draw
 if(currentScreen==screenMap)
  {
    map.draw();
  }
  
if(currentScreen!=screenMap)
  {
    image(background4Home,0,750);
  }
  //top
  boolean mainScreenOn =false;
  ///
  
  ///
  //switch events 
   case EVENT_MAP:
        
        currentScreen=screenMap;
        ismousePressed = false;
       break;
       
       ///
///
////
//setup
//
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
//
//
//



SimplePointMarker dublinMarker = new SimplePointMarker(dublinLocation);
     
// Add markers to the map
map.addMarkers(dublinMarker);
}
 
void draw() {
    map.draw();
}
 
// void displayPoints(list<Location> location)
 //{
 //  for(int i=o;lcation.size();i++)
   //{
    // map.addMarker(new SimplePointerMarker(location.get(i)));
  // }
 //}
void keyPressed() {
    if (key == '1') {
        map.mapDisplay.setProvider(provider1);
    } else if (key == '2') {
        map.mapDisplay.setProvider(provider2);
    }            
}

      // adding the routs ,i.e stops , is still to be done 
      //code by Ezi