class BlockType
{
  private int blockTypeId;
  
  public BlockType(int blockTypeId)
  {
    this.blockTypeId = blockTypeId;
  }
  
  public int getBlockTypeId()
  {
    return blockTypeId; 
  }
  
  public void displayBlockTypeIcon(int left, int top, int size)
  {
    switch(blockTypeId) 
    {
      case BlockConstant.TYPE_BASIC: 
        break;
        
      case BlockConstant.TYPE_LEFT: 
        strokeWeight(size/8);
        stroke(Colour.GREY_01);
        line(left + (2*size/5), top + size/2, left + ((3 * size) / 5), top + ((2 * size) / 5));
        line(left + (2*size/5), top + size/2, left + ((3 * size) / 5), top + ((3 * size) / 5));
        break;
        
      case BlockConstant.TYPE_RIGHT: 
        strokeWeight(size/8);
        stroke(Colour.GREY_01);
        line(left + (2*size/5), top + ((2 * size) / 5), left + ((3 * size) / 5), top + size/2);
        line(left + (2*size/5), top + ((3 * size) / 5), left + ((3 * size) / 5), top + size/2);
        break;
        
      case BlockConstant.TYPE_UP: 
        strokeWeight(size/8);
        stroke(Colour.GREY_01);
        line(left + (2*size/5), top + ((3 * size) / 5), left + size/2, top + ((2 * size) / 5));
        line(left + (3*size/5), top + ((3 * size) / 5), left + size/2, top + ((2 * size) / 5));
        break;
        
      case BlockConstant.TYPE_DOWN: 
        strokeWeight(size/8);
        stroke(Colour.GREY_01);
        line(left + (2*size/5), top + ((2 * size) / 5), left + size/2, top + ((3 * size) / 5));
        line(left + (3*size/5), top + ((2 * size) / 5), left + size/2, top + ((3 * size) / 5));
        break;
        
      case BlockConstant.TYPE_CHAIN: 
        strokeWeight(size/8);
        stroke(Colour.GREY_01);
        line(left + (2*size/5), top + ((3 * size) / 7), left + (3 * size) / 5, top + ((4 * size) / 7));
        line(left + (2*size/5), top + ((4 * size) / 7), left + (3 * size) / 5, top + ((3 * size) / 7));
        line(left + size/2, top + ((5 * size) / 13), left + size/2, top + ((8 * size) / 13));
        break; 
    }
  }
}