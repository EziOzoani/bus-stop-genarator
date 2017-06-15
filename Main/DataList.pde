class DataList
{
  String[] lines;
  public ArrayList<Data> listArray()
  {
    lines  =  loadStrings("bus-first100000.csv"); 
ArrayList<Data> dataList = new ArrayList<Data>();
  //Need better way of extracting data   (by David)
  for    (int  i=0;  i  <  lines.length;  i++)  {  
   
    String[] values = lines[i].split(",");
  
    Data d = new Data(values[0],values[1],values[2],values[3],values[4],values[5],values[6],values[7],values[8]);
    dataList.add(d);
  }
    return dataList;
  }

  public ArrayList<Data> buildSubList(int i)                              //Code by Thomas and David
  {
  
   
   Stop s=routeStopList.get(i);
 
  int stop=s.stop;
 println(stop);
  ArrayList<Data> subList = new ArrayList<Data>();
  for (int j=0; j<dataList.size(); j++)
  {
    Data d=dataList.get(j);
    if (d.stopID==stop)
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
      Data newData=new Data(ts, line, congestion, lon, lat, delay, vid, sid, atshop);     
      subList.add(newData);
    }
  }
  return subList;
  }
 
}