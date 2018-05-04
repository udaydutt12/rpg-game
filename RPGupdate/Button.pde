class Button {
  String text;
  int xPos, yPos;
  float heightSize, widthSize;
  color boxColor;
  color textColor, overColor;
  color baseColor;
  int textSize = 20;
  
  Button(String text, int x, int y, float widths,float heights,
  color textColor, color overColor, color boxColor) {
    this.text = text;
    this.xPos = x;
    this.yPos = y;
    this.heightSize = heights;
    widthSize = widths;
    this.textColor = textColor;
    baseColor = textColor;
    this.overColor = overColor;
    this.boxColor = boxColor;
  }
  
  void display()
  {
    pushStyle();
  //  textAlign(CENTER);
    if (mouseOver())
    {
      fill(overColor);
    }
    else
    {
      fill(baseColor);
    }
    
    stroke(textColor);
    strokeWeight(2);
    rect(xPos, yPos, widthSize, heightSize, 10);
    fill(boxColor);
    textSize(textSize);
    text(text, xPos + widthSize/2, yPos + heightSize/2 + textSize/2);
    popStyle();
  }
  
  boolean mouseOver()
  {
    if (mouseX >= xPos && mouseX <= (xPos + widthSize) && mouseY >= yPos && mouseY <= (yPos + heightSize))
    {
      return true;
    }
    else 
    {
      return false;
    }
  }
  

  
  
}