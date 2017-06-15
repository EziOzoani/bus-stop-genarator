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
    size(800, 600);
 
    provider1 = new Google.GoogleMapProvider();
    provider2 = new Microsoft.AerialProvider();
   
 
    map = new UnfoldingMap(this, provider1);
    MapUtils.createDefaultEventDispatcher(this, map);
    
    Location dublinLocation = new Location(53.35, -6.26);                  // {these lines
    map.zoomAndPanTo(dublinLocation, 10);                                  // set the center of the map to be dublin
    float maxPanningDistance = 30; // in km                                // if deleted then, the full map of the globe can be seen (note : full map is in half english , half german 
    map.setPanningRestriction(dublinLocation, maxPanningDistance);         // } Note: + "zooms in , or double click on the mouse ", 'up and down keys' - to move up and down or drag map with mouse 
}
 
void draw() {
    map.draw();
}
 
void keyPressed() {
    if (key == '1') {
        map.mapDisplay.setProvider(provider1);
    } else if (key == '2') {
        map.mapDisplay.setProvider(provider2);
    }            
}

      // adding the routs ,i.e stops , is still to be done 
      //code by Ezi