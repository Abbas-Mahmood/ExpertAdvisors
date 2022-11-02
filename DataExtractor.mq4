#include <UsedFunctions.mqh>

float bidprice_0;
float askprice_0;
string StartDate;

int OnInit()
  {
      StartDate = TimeToStr(TimeGMT(),TIME_DATE);
      bidprice_0 = MarketInfo(Symbol(),MODE_BID); 
      askprice_0 = MarketInfo(Symbol(),MODE_ASK); 

      return(INIT_SUCCEEDED);
  }
  
void OnTick()
  {
   DataExport(bidprice_0,askprice_0,StartDate);
  }