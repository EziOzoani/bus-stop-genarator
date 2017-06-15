class Data
{
  String output[];
 public String ts, line, lon, lat,  vid,sid,atshop, total, total2;
 public int congestion, delay;
  
  public Data(String ts, String line, String congestion, String lon, String lat, String delay, String vid, String sid,String atshop) {
    
    this.ts = ts;
    this.line = line;
    this.congestion= Integer.valueOf(congestion);
    this.lon=lon;
    this.lat=lat;
    this.delay=Integer.valueOf(delay);
    this.vid=vid;
    this.sid=sid;
    this.atshop=atshop;
    this.total=("Time is "+this.ts+"Route is "+this.line+ "Congestion Y/N "+this.congestion+"longitude is "+this.lon);
    this.total2=("Latitude is "+this.lat + "Time delay is "+this.delay+"s"+"Vehicle I.D is "+this.vid+"Stop is "+this.sid+"At stop "+this.atshop);
}
  
  
  

 

}