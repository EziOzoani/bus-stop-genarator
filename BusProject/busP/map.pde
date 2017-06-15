class map{
  
 
  
 
  ArrayList<Data> dataList;
 
  //SimplePointMarker dublinMarker = new SimplePointMarker(dublinLocation);
 
    DataList  d=new DataList();
   //dataListTemp=d.listArray();
   ArrayList<Marker> markers = new ArrayList<Marker>();
   float lat;
   float lon;
   
  public void Map()
   
   {
  //   size(1200,800,P3D);
     
     
      for(int j =0; j<indivRouteList.size();j++)
     {
       Data part =indivRouteList.get(j);
      lon=part.lon;
       lat=part.lat;
       
       Location stops = new Location(lat, lon);  //list = list of data
       SimplePointMarker stopMarker = new SimplePointMarker(stops); 
       stopMarker.setColor(color(255,100,200, 200));//color, try to reduce to 3 values
       stopMarker.setStrokeColor(color(255, 0, 0));
       strokeWeight(13);
       markers.add(stopMarker);
       
     }
       map.addMarkers(markers);
   
   }
   
   

}