class Curves {
    float x1 ,x2 ,x3, x4;    
    float y1 ,y2, y3, y4;
    
    int n = 0;      
 
  Curves( float tmpX , float tmpY  ) {
    
    x1 = x2 = x3 = x4 = tmpX;          
    y1 = y2 = y3 = y4 = tmpY;
  }
  
  void addPos ( float tmpdX , float tmpdY ) {
     x1 = x2;          
     x2 = x3;
     x3 = x4;
     x4 += tmpdX;
 
     y1 = y2;
     y2 = y3;
     y3 = y4;
     y4 += tmpdY; 
     n++;
  }
}
