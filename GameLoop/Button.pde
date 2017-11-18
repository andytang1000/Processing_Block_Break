
class Button
{
  protected int xpos;
  protected int ypos;
  
  protected int width;
  protected int height;
  
  protected int activeColour;
  protected int inactiveColour;
  protected boolean active;
  
  public Button(int xpos, int ypos, int width, int height, int activeColour, int inactiveColour)
  {
    this.xpos = xpos;
    this.ypos = ypos;
    
    this.width = width;
    this.height = height;
    
    this.activeColour = activeColour;
    this.inactiveColour = inactiveColour;
    
    active = false;
    
  }
 
  public void display()
  {
    if (active)
    {
      fill(activeColour);
      stroke(Colour.GREY_09);
    }
    else
    {
      fill(inactiveColour);
      stroke(Colour.GREY_10);
    }

    strokeWeight(4);
    rect(xpos, ypos, width, height, 10);
  }
  
  public void mousePressed()
  {
    if (mouseOver())
    {
      active = true;
    }
    else
    {
      active = false; 
    }
  }
  
  public void mouseReleased()
  {
    active = false;
  }
  
  public boolean mouseOver()
  {
    if (mouseX > xpos && mouseX < xpos + width 
      && mouseY > ypos && mouseY < ypos + height)
    {
      active = true;
      return true;
    }
    else
    {
      active = false; 
      return false;
    }
  }
}