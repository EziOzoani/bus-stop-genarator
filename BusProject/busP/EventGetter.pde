class EventGetter
{
  public int getEvent(Screen thisScreen, int event)
  {
     DataList D=new DataList();
 
   int amountWidgets1=screen3.size();

int EVENT_3=3;
  if(event>=500&&event<506)
  {

    event=EVENT_5;
    return event;
  }

  if(event>=700&&event<1200)
  {
    println("hi");
    event=EVENT_9;
  }
  if(event>=1200&&event<1400)
  event=EVENT_12;
  
  
      return event;
  }
}