class CellUI
{
  private int m_size;
  
  // left and top property of the cell on the screen
  private int m_left;
  private int m_top;
  
  private boolean m_visible = true;
  
  private Block m_block;
  
  // Used for cloning a cell for animation purposes.
  public CellUI(Cell cell)
  {
   m_size = cell.m_size;
   m_left = cell.m_left;
   m_top = cell.m_top;
   
   // Shallow copy of block since we only animate cells that have blocks otherwise it would be pointless.
   m_block = cell.m_block;
  }
  
  public Block getBlock()
  {
    return m_block;  
  }
  
  public boolean isEmpty()
  {
    return m_block == null;
  }
  
  public void display()
  {
    fill(m_block.getColour());
    stroke(Colour.GREY_10);
    strokeWeight(m_size/20);
    rect(m_left, m_top, m_size, m_size, m_size/8);

    displayBlockIcon();
  }
  
  public void displayBlockIcon()
  {
    if (m_block == null)
    {
      return;
    }
    
    BlockType blockType = m_block.getBlockType();
    
    if (m_block == null)
    {
      return; 
    }
    
    blockType.displayBlockTypeIcon(m_left, m_top, m_size);
  }
  
  public int getLeft()
  {
    return m_left; 
  }
  
  public int getTop()
  {
    return m_top; 
  }
  
  public void setLeft(int left)
  {
    m_left = left; 
  }
  
  public void setTop(int top)
  {
    m_top = top; 
  }
  
  public boolean isVisible()
  {
    return m_visible; 
  }
  
  public void setVisible(boolean visible)
  {
    m_visible = visible;
  }
}