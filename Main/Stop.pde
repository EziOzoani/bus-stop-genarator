class Stop{
  
  public int stop;
    public Stop(int s) {
    this.stop=s;
   
}
public ArrayList<Stop> buildStopList(ArrayList<Data> list)
{
  boolean alreadyInList=false;
  ArrayList<Stop> stops = new ArrayList<Stop>();

  for (int i=0; i<list.size(); i++)
  {
    Data part = list.get(i);

    for (int j=0; j<stops.size(); j++)
    {
      Stop s=stops.get(j);
      if (s.stop==part.stopID||part.stopID==-1)
      {
        alreadyInList=true;
      }
    }
    if (alreadyInList==false)
    {
      Stop s=new Stop(part.stopID);
      stops.add(s);
    }
    alreadyInList=false;
  }
  return stops;
 
}

}