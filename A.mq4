int RoundPrice = Bid;
int OrderBuy;
int OrderSell;

int OnInit()
  {

  return(INIT_SUCCEEDED);
  }

void OnTick()
  {
  
  Comment("Round Price: ",RoundPrice,"\n","Open Trades: ",OrdersTotal());
  if(TimeMinute(TimeCurrent())!=0)
  {
   if(Ask > RoundPrice+1+0.3)
   {
     OrderBuy = OrderSend(Symbol(),OP_BUY,0.01,MarketInfo(Symbol(),MODE_ASK),0,NULL,NULL);
     RoundPrice += 1;
     for(int i=0;i<OrdersTotal();i++)//(int i=OrdersTotal();i>0;i--)
     {
       OrderSelect(i-1, SELECT_BY_POS);
       if(OrderType()== OP_SELL && (RoundPrice-OrderOpenPrice())>0)
       {
         OrderClose(OrderTicket(),OrderLots(),MarketInfo(Symbol(),MODE_ASK),0,NULL);
       }
     }
   }
     
   if(Bid < RoundPrice-0.3)
   {
     OrderSell = OrderSend(Symbol(),OP_SELL,0.01,MarketInfo(Symbol(),MODE_BID),0,NULL,NULL);
     RoundPrice -= 1;
     for(int j=0; j<OrdersTotal();j++)//(int j=OrdersTotal();i>0;i--)
     {
       OrderSelect(j-1, SELECT_BY_POS);
       if(OrderType()== OP_BUY &&(OrderOpenPrice()-(RoundPrice+1))>0)
       {
         OrderClose(OrderTicket(),OrderLots(),MarketInfo(Symbol(),MODE_BID),0,NULL);
       }
     }
   }
   }
   else
   {
   for(int k=OrdersTotal()-1;k>=0;k--)
   {
   OrderSelect(k,SELECT_BY_POS);
   
     if(OrderType()== OP_BUY)
     {
       OrderClose(OrderTicket(),OrderLots(),MarketInfo(Symbol(),MODE_BID),0);
     }
     else
     {
       OrderClose(OrderTicket(),OrderLots(),MarketInfo(Symbol(),MODE_ASK),0);
     }
     
   }
   }    
  }   
