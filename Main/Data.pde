class Data
{
  String output[];
 public String ts,   atshop, total, total2;
 public int congestion, delay, line, stopID, vid;
 public float lon, lat;
  
  public Data(String ts, String line, String congestion, String lon, String lat, String delay, String vid, String sid,String atshop) {
    
    this.ts = ts;
    this.line =Integer.valueOf(line);
    this.congestion= Integer.valueOf(congestion);
    this.lon=new Float(lon);
    this.lat=new Float(lat);
    this.delay=Integer.valueOf(delay);
    if(!vid.equals("null"))          //some values of stopID are null, David
    {
    this.vid=Integer.valueOf(vid);
    }
    else if(vid.equals("null"))          //some values of stopID are null, David
    {
    this.vid=-1;
    }
    
    if(!sid.equals("null"))          //some values of stopID are null, David
    {
    this.stopID=Integer.valueOf(sid);
    }
    else if(sid.equals("null"))          //some values of stopID are null, David
    {
    this.stopID=-1;
    }
    this.atshop=atshop;
 

}

 public int[]buildDataList()
 {
   return null;
 }
  
  
  

 

}