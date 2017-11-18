

class Level
{
  private int level;
  
  private int rows;
  private int columns;
  
  private final int [][] level1 = {
    {102, 100, 304},
    {200, 204, 201},
    {402, 105, 400},
    {100, 200, 101}
  };
  
  private final int [][] level2 = {
    {102, 400, 304, 100, 304},
    {202, 200, 200, 103, 201},
    {405, 105, 404, 200, 101},
    {100, 100, 400, 300, 300},
    {402, 100, 400, 401, 301},
    {100, 200, 100, 400, 101}
  };
  
   private final int [][] level3 = {
    {102, 400, 304, 100, 304, 102, 400, 304, 100, 304},
    {202, 200, 205, 103, 201, 204, 200, 200, 103, 201},
    {405, 105, 404, 200, 101, 405, 105, 404, 200, 101},
    {100, 100, 400, 300, 300, 100, 100, 400, 300, 300},
    {402, 100, 400, 401, 301, 402, 100, 400, 401, 301},
    {100, 200, 100, 400, 101, 100, 200, 100, 400, 101},
    {102, 400, 304, 100, 304, 102, 400, 304, 100, 304},
    {202, 200, 200, 103, 201, 205, 200, 200, 103, 201},
    {405, 105, 404, 200, 101, 405, 105, 404, 200, 101},
    {100, 100, 400, 300, 300, 100, 100, 400, 300, 300},
    {402, 100, 400, 401, 301, 402, 100, 400, 401, 301},
    {100, 200, 100, 400, 101, 100, 200, 100, 400, 101,}
  };
  
  private Block[][] blocks;
  
  public Level(int level)
  {
    this.level = level;
    
    int[][] levelGrid;
    
    if (this.level == 1)
    {
      levelGrid = level1;
    }
    else if (this.level == 2)
    {
      levelGrid = level2;
    }
    else if (this.level == 3)
    {
      levelGrid = level3;
    }
    else
    {
      levelGrid = level1;
    }
    
    rows = levelGrid.length; // 1st demension indicates number of rows
    columns = levelGrid[0].length; // 2nd demension indicates number of columns
    
    blocks = new Block[columns][rows];
    
    for (int row = 0; row < rows; row++)
    {
      for (int column = 0; column < columns; column++)
      {
        int blockTypeId = levelGrid[row][column] % 100; // 1st digit contains ID for block colour
        int blockId = levelGrid[row][column] / 100; // 2nd and 3rd digit contains ID for block type
        
        blocks[column][row] = new Block(blockId, blockTypeId);
      }
    }
  }

  public Block[][] getBlockGrid()
  {
    return blocks; 
  }
  
  public int getLevel()
  {
    return level; 
  }
}