class Block
{
  private int blockColour;
  private int blockColourId;
  private BlockType blockType;
  private boolean active = true;
  
  public Block(int blockColourId, int blockTypeId)
  {
    this.blockColourId = blockColourId;
    setColour(blockColourId);
    blockType = new BlockType(blockTypeId);
  }
  
  public Block(int blockColourId, BlockType blockType)
  {
    this.blockColourId = blockColourId;
    setColour(blockColourId);
    this.blockType = blockType;
  }
  
  public int getBlockColourId()
  {
    return blockColourId;
  }
  
  public BlockType getBlockType()
  {
    return blockType; 
  }
  
  public int getColour()
  {
    return blockColour;
  }
  
  public boolean isActive()
  {
    return active; 
  }
  
  public void setActive(boolean active)
  {
    this.active = active;
    setColour(blockColourId);
  }
  
  public void setColour(int blockColourId)
  {
    if (active)
    {
      switch(blockColourId)
      {
        case BlockConstant.COLOUR_RED_IDENTIFER:
          blockColour = Colour.RED_05;
          break;
        case BlockConstant.COLOUR_GREEN_IDENTIFER:
          blockColour = Colour.GREEN_05;
          break;
        case BlockConstant.COLOUR_ORANGE_IDENTIFER:
          blockColour = Colour.AMBER_05;
          break;  
        case BlockConstant.COLOUR_BLUE_IDENTIFER:
          blockColour = Colour.BLUE_05;
          break;   
      }
    }
    else
    {
      switch(blockColourId)
      {
        case BlockConstant.COLOUR_RED_IDENTIFER:
          blockColour = Colour.RED_02;
          break;
        case BlockConstant.COLOUR_GREEN_IDENTIFER:
          blockColour = Colour.GREEN_02;
          break;
        case BlockConstant.COLOUR_ORANGE_IDENTIFER:
          blockColour = Colour.AMBER_02;
          break;  
        case BlockConstant.COLOUR_BLUE_IDENTIFER:
          blockColour = Colour.BLUE_02;
          break;   
      } 
    }
  }
}