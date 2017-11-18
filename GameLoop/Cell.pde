
class Cell 
{
  private int m_size;
  
  // left and top property of the cell on the screen
  private int m_left;
  private int m_top;
  
  // x and y coordinate on the grid
  private int m_xCoord; // Starts at 0
  private int m_yCoord; // Starts at 0
  
  private Block m_block;
  
  public Cell(int xCoord, int yCoord, int size, int left, int top)
  {
    m_size = size;
    m_left = left;
    m_top = top;
    m_xCoord = xCoord;
    m_yCoord = yCoord;
  }
  
  public Block getBlock()
  {
    return m_block;  
  }
  
  public void addBlock(Block block)
  {
    if (block == null)
    {
      return; 
    }
    
    m_block = new Block(block.getBlockColourId(), block.getBlockType().getBlockTypeId());
  }
  
  public Block removeBlock()
  {
    Block blockRef = m_block;
    m_block = null;
    return blockRef;
  }
  
  public boolean isEmpty()
  {
    return m_block == null;
  }
  
  public void clearCell()
  {
    m_block = null; 
  }
  
  public int getXCoord()
  {
    return m_xCoord; 
  }
  
  public int getYCoord()
  {
    return m_yCoord; 
  }
}