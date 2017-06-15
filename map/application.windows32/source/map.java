import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

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

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class map extends PApplet {


















UnfoldingMap map;
AbstractMapProvider provider1;
AbstractMapProvider provider2;

 
public void setup() {
    
 
    provider1 = new Google.GoogleMapProvider();
    provider2 = new Microsoft.AerialProvider();
   
 
    map = new UnfoldingMap(this, provider1);
    MapUtils.createDefaultEventDispatcher(this, map);
    
    Location dublinLocation = new Location(53.35f, -6.26f);                  // {these lines
    map.zoomAndPanTo(dublinLocation, 10);                                  // set the center of the map to be dublin
    float maxPanningDistance = 30; // in km                                // if deleted then, the full map of the globe can be seen (note : full map is in half english , half german 
    map.setPanningRestriction(dublinLocation, maxPanningDistance);         // } Note: + "zooms in , or double click on the mouse ", 'up and down keys' - to move up and down or drag map with mouse 
}
 
public void draw() {
    map.draw();
}
 
public void keyPressed() {
    if (key == '1') {
        map.mapDisplay.setProvider(provider1);
    } else if (key == '2') {
        map.mapDisplay.setProvider(provider2);
    }            
}

      // adding the routs ,i.e stops , is still to be done 
      //code by Ezi
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "map" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
