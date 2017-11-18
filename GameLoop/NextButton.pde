class NextButton extends Button
{
  private static final String NEXT_LABEL = "NEXT";
  
  public NextButton(int xpos, int ypos, int width, int height, int activeColour, int inactiveColour)
  {
    super(xpos, ypos, width, height, activeColour, inactiveColour);
  }
  
  public void display()
  {
    super.display(); 
    
    textSize(22);
    
    if (active)
    {
      fill(Colour.BLUE_06);
    }
    else
    {
      fill(Colour.BLUE_10);
    }
    
    text(NEXT_LABEL, xpos + (width/3), ypos + ((height*2)/3)); 
  }
  
  public void mouseClick(GameBoard gameBoard)
  {
    if (mouseOver())
    {
      gameBoard.nextLevel();
    }
  }
}
   