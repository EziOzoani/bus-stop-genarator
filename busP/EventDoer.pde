class EventDoer{
 
  public void doEvent(int event, int eventTemp)
  {
    DataList D=new DataList();
 int amountWidgets1=screen3.size();
  int amountWidgets2=screen5.size();
  Query q=new Query();
  switch(event)                                                  
  {
  case EVENT_MAP:
    currentScreen=screenMap;
    break;
  case EVENT_ENTER :
    currentScreen= screen1;                                //Screen containing general, map, route and stop widgets
    current_query=mainQuery;
    yay.play();
    break;
  case EVENT_1:
  Screen2 s=new Screen2();
    screen2=s.buildScreen2();
    currentScreen=screen2;                                //Screen containing first General PieChart
    


 
    ohh.rewind();
    ohh.play();
 
    break;
  case BUS_QUERY:
  stopsData=false;
    dataList=D.listArray();                                //Screen containing bus routes in drop down list
    q.query2();
    screen3=screen3Build(route);
    currentScreen=screen3;
    break;
//code by David
//Slightly broke code when dealing with some Screens, will fix tomorrow David
  case EVENT_BACK:
    if (currentScreen==screen2)
    {
      currentScreen=screen1;
      current_query=mainQuery;
    }
    if (currentScreen==screen3)
    {
      currentScreen=screen1;
      current_query=mainQuery;
      ddl.hide();
    }
    if (currentScreen==screen4)
    {
 
      current_query=noQuery;
      currentScreen=screen3;
      ddl.show();
    }
  if (currentScreen==screen7)
    {
       current_query=noQuery;
      currentScreen=screen3;
      ddl.show();
  
    }
    
    if (currentScreen==screen8)
    {
      currentScreen=screen7;
    }
    if(currentScreen==blankScreen)
    {
      if(current_query>query1&&current_query<=query9)
      {
        currentScreen=screen4;
        current_query=noQuery;
        textFont(stdFont);
      }
      if(current_query==query10||current_query==query1)
      {
        current_query=noQuery;
     
        currentScreen=screen2;
      }
      if(current_query==query12)
      
      {
         currentScreen=screen8;
        current_query=noQuery;
      }
      if(mapOn==1)
      {
        mapOn=0;
        currentScreen=screen4;
        current_query=noQuery;
      }
      
      
    }
    if(currentScreen==blankScreen2)
      {
        if(current_query==query11)
        {
           currentScreen=screen8;
        current_query=noQuery;
        }
           if(current_query==query7)
        {
           currentScreen=screen4;
        current_query=noQuery;
        textFont(stdFont);
        pages=1;
        page=1;
        }
        
      }
      textFont(stdFont);
    break;
 
  case EVENT_5:
    if (eventTemp==500)                                  
    {
   

      q.query5(indivRouteList);
      current_query=query5;
      currentScreen=blankScreen;
      //delay Data
    }
    if (eventTemp==501)
    {//This will be the event for map Screen Ezi
      q.Query6();
      current_query=query6;
      currentScreen=blankScreen;
    }
    if (eventTemp==502)
    {
      q.query7();

      current_query=query7;
      currentScreen=blankScreen2;
      //Stop Data
    }
    if (eventTemp==503)
    {
      current_query=query8;
      q.query8();
      currentScreen=blankScreen;
      //VID Data
    }
    if (eventTemp==504)
    {
      current_query=query9;
      q.query9();
      currentScreen=blankScreen;
    }
   
    break;
    //Dont think used anymore David
    /*
  case EVENT_6:
    // mainScreenOn=false;      // for bus data
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
    */
  case EVENT_NEXT_PAGE:
    int previousPageNo=page;
  
    page=page+1;
    if (pages==page)
    {
      blankScreen2.remove(nextPage);
    }
    if (previousPageNo==1)
    {
      blankScreen2.add(previousPage);
    }
   
    break;
  case EVENT_PREVIOUS_PAGE:
    int previousPageNo2=page;
    page=page-1;
    if (page==1)
    {
      blankScreen2.remove(previousPage);
    }
    if (previousPageNo2==pages)
    {
      blankScreen2.add(nextPage);
    }
     
    break;
    case EVENT_9:
    int stopIndex=eventTemp-700;
    println(stopIndex);
    DataList data=new DataList();
    indivStopList=data.buildSubList(stopIndex);
    Screen8 screen=new Screen8();
      screen8=screen.buildScreen8(stopIndex);
      currentScreen=screen8;
    break;
    case EVENT_10:
    
    currentScreen=blankScreen;
    current_query=query1;
    dataList=D.listArray();
   q.query1();
   break;
   case EVENT_11:
     dataList=D.listArray();
   currentScreen=blankScreen;
   q.query10();
  
   current_query=query10;
   break;
   case EVENT_12:
   if(eventTemp==1200)
   {
    page=1;
    pages=1;
     current_query=query11;
     currentScreen=blankScreen2;
   }
   if(eventTemp==1201)
   {
     current_query=query12;
     q.query12();
     currentScreen=blankScreen;
   }
   break;
   case EVENT_13:
   dataList=D.listArray();                                //Screen containing bus routes in drop down list
    q.query2();
    screen3=screen3Build(route);
    currentScreen=screen3;
    stopsData=true;
  }
  }
}