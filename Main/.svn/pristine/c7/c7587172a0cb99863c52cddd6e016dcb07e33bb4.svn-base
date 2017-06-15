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

    currentScreen=screen2;                                //Screen containing first General PieChart
    dataList=D.listArray();

   q.query1(dataList);
    current_query=query1;
    ohh.rewind();
    ohh.play();
    ismousePressed = false;
    break;
  case BUS_QUERY:

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
      event=eventTemp;
      screen3=screen3Build(route);
      currentScreen=screen3;
    }
  if (currentScreen==screen7)
    {
      currentScreen=screen4;
    }
    if (currentScreen==screen8)
    {
      currentScreen=screen7;
    }
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
      Screen7 screen=new Screen7();
      screen7=screen.buildScreen7(indivRouteList);
      currentScreen=screen7;
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
    if (pages==1)
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
    
  }
  }
}