final int EVENT_NULL = 0; 
final int EVENT_1 = 1;                //Event leads to general PieChart, no sub events
final int BUS_QUERY=2;                //Event leads to bus route quert, no sub events
final int EVENT_ENTER =3;                    //Event which brings you to main Screen
//final int EVENT_4=4;
final int EVENT_MAP=4;
final int EVENT_5=5;                  //Event which handles the four widgets describing a certain route, four sub sub events from 500 to 503
final int EVENT_6=6;                 //Maps to Bus stops, Thomas and David
final int EVENT_7=7;               //Maps to screen with delay, time etc widgets for one stop, by Thomas and David
final int EVENT_8=8;  
final int EVENT_9=9;               //Maps to stops on route Screen, screen7
final int EVENT_BACK=400;            //back button event David
final int EVENT_NEXT_PAGE=600;            //back button event David
final int EVENT_PREVIOUS_PAGE=601;            //back button event David

final int queryH=-1;
final int queryNull=-2;
final int mainQuery=0;
final int homeScreen=1;
final int query1=2;
final int busRoutes=3;
final int pieChart2=4;
final int query3=5;
final int query5=5;
final int query6=6;
final int query7=7;
final int query8=8;
final int query9=9;
final int query10=10;
final int noQuery=123;