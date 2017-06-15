class DataList
{
  String[] lines;
  public ArrayList<Data> listArray()
  {
    lines  =  loadStrings("bus-first1000.csv"); 
ArrayList<Data> dataList = new ArrayList<Data>();
  //Need better way of extracting data   (by David)
  for    (int  i=0;  i  <  lines.length;  i++)  {  
   
    String[] values = lines[i].split(",");
  
    Data d = new Data(values[0],values[1],values[2],values[3],values[4],values[5],values[6],values[7],values[8]);
    dataList.add(d);
  }
    return dataList;
  }
  //Code is deadCode
  public  ArrayList<Data> oneRoute(int i, ArrayList<Data> indivRoute)     //The result of this list will Contain everyInstance of the route selected
  {
    System.out.println("hello");
     lines  =  loadStrings("bus-first1000.csv");
     String[] values = lines[i].split(",");
      Data d = new Data(values[0],values[1],values[2],values[3],values[4],values[5],values[6],values[7],values[8]);
    indivRoute.add(d);
    return indivRoute;
  }
 
}