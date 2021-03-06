class ResetButton extends Button
{
  private static final String RESET_LABEL = "RESET";
  
  public ResetButton(int xpos, int ypos, int width, int height, int activeColour, int inactiveColour)
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
    
    text(RESET_LABEL, xpos + (width/3), ypos + ((height*2)/3)); 
  }
  
  public void mouseClick(GameBoard gameBoard)
  {
    if (mouseOver())
    {
      gameBoard.reset();
    }
  }
}
   