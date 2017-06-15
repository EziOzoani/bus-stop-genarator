import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class busPro extends PApplet {

PFont  stdFont;
Data d;
PieChart p;


Data myDataPoints;
String output[], lines[];
int x=0;
int y=0;
ArrayList<Data> dataList;
int current_query,result,query1;
int[]results;
 

public void  setup() { 
  
  
  
    lines  =  loadStrings("bus-first100.csv"); 
ArrayList<Data> dataList = new ArrayList<Data>();
  //Need better way of extracting data   (by David)
  for    (int  i=0;  i  <  lines.length;  i++)  {  
  fill(255);
    rect(x,y,1000,50);
    fill(0);
    println(lines[i]);
    String[] values = lines[i].split(",");
    Data d = new Data(values[0],values[1],values[2],values[3],values[4],values[5],values[6],values[7],values[8]);
    dataList.add(d);
  text(d.total,x,y+20);
  text(d.total2,x,y+45);
  y=y+75;
  }
  //

  current_query = query1;                  //default query is pie charts
  results=query1(dataList); 
  stdFont=loadFont("ArialMT-18.vlw"); 
   textFont(stdFont);
}

public void draw()
{
  background(0);
  renderQuery1(results);                //render pie charts, needs to be done(Comment by David)

}
public void  mousePressed(){  
  //  switch(currentScreen.getEvent(mouseX,  mouseY))  {        //need it so that if user clicks box, it switches to whatever query the button corresponds to
                                                                //right now only have one query(Comment by David)
  //  case  EVENT_BUTTON1:  
        current_query=query1;
    //    results=query1();
     //   break;  
   // }      
} 

public int [] query1(ArrayList<Data> dataList)                      //code by David
{
  int congestion=0;
  double earlyCongestion=0;
  double lateCongestion=0;
  double onTimeCongestion=0;
  double earlyNoCongestion=0;
  double lateNoCongestion=0;
  double onTimeNoCongestion=0;
  
 for (int i=0;i<dataList.size();i++)
 {
   Data d = dataList.get(i);
  congestion= d.congestion;
  if (congestion==1)
  {
    if(d.delay<-30)
    {
      println("hi");
      earlyCongestion=earlyCongestion+1;
    }
     if(d.delay>30)
    {
      println("hi");
      lateCongestion=lateCongestion+1;
    }
     if(d.delay>=-30&&d.delay<=30)
    {
      println("hi");
      onTimeCongestion=onTimeCongestion+1;
    }
  }
   if (congestion==0)
  {
    if(d.delay<-30)
    {
      earlyNoCongestion=earlyNoCongestion+1;
    }
     if(d.delay>30)
    {
      lateNoCongestion=lateNoCongestion+1;
    }
     if(d.delay>=-30&&d.delay<=30)
    {
    
      onTimeNoCongestion=onTimeNoCongestion+1;
    }
  }
  if(dataList.size()==i+1)
  {
    double temp=0;
    double total1=earlyCongestion+lateCongestion+onTimeCongestion;
    double total2=earlyNoCongestion+lateNoCongestion+onTimeNoCongestion;
    int[] ratios= new int[6];
  if(total1!=0)
  {
      temp=(earlyCongestion/total1)*360;
   ratios[0]=(int)temp;
  temp=(lateCongestion/total1)*360;
   ratios[1]=(int)(temp)*360;
   temp=(onTimeCongestion/total1)*360;
   ratios[2]=(int)temp;
  }
  if(total2!=0)
  {
   temp=(earlyNoCongestion/total2)*360;
   ratios[3]=(int)temp;
  temp=(lateNoCongestion/total2)*360;
   ratios[4]=(int)(temp)*360;
   temp=(onTimeNoCongestion/total2)*360;
   ratios[5]=(int)temp;
 
  }
  return ratios;
  }
 }
 return null;
}

public void renderQuery1(int []angles)                        //the angles are stored in results array. results 1,2 and 3 are when there was congestion, opposite for 4,5, and 6(Comment by David)                                                    
//Will need to edit sample bus data to get more interesting results, so far there is never any congestion
{
  int[]angles1=new int[3];
  for(int i=0;i<3;i++)
  {
  angles1[i]=angles[i];
  }
  
  {
    println("k");
    float diameterz=300;
    int y=1500;
    float u= 40;
    PieChart p=new PieChart(diameterz);
    p.draw(angles1,y,u);
    fill(0);
    text("word3", 750,450);
    fill(255);
    text("word4", 640,540);
    println("5");
  }
  
 
// p.draw(10, angles1);
  int[]angles2=new int[3];                    
  for(int i=0;i<3;i++)
  {
  angles2[i]=angles[i+3];
  }
  {
  float diameter=300;
  int x=500;
  float w = 10;
  PieChart p=new PieChart(diameter);
  p.draw(angles2,x,w);
  //noLoop();
  //textSize(42);
  fill(0);
  text("word1", 190,430);
  fill(255);
  text("word2", 250,555);
  
 // noLoop();
  println("4");
  
  }

}
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
class PieChart                    
{
  float diameter;
 
    public PieChart(float diameter) 
   {
      this.diameter=diameter;
    }
  
  public void draw(int[]data,int x, float w)
  
  {
    loop();
     float lastAngle = w;
      for (int i = 0; i < data.length; i++) 
      {
        float gray = map(i, 0, data.length, 0, 255);
        fill(gray);
        arc(x/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
        lastAngle += radians(data[i]);
      }
  }
}
  public void settings() {  size(1000,1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "busPro" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
