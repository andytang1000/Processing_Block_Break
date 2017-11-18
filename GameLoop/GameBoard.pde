


class GameBoard
{
  public final static int SCREEN_WIDTH = 480; // Real screen width
  public final static int SCREEN_HEIGHT = 840; // Real screen height
  
  public final static int MIN_PADDING_WIDTH = 20; // Min left / right padding
  public final static int PADDING_TOP = 100; // Top padding
  
  public final static int MAX_GAME_SCREEN_WIDTH = 440;
  public final static int MAX_GAME_SCREEN_HEIGHT = 560;
  
  private final static int RESET_BUTTON_WIDTH = 200;
  private final static int RESET_BUTTON_HEIGHT = 50;
  
  private final static int NEXT_BUTTON_WIDTH = 200;
  private final static int NEXT_BUTTON_HEIGHT = 50;
  
  private final static int PREVIOUS_BUTTON_WIDTH = 200;
  private final static int PREVIOUS_BUTTON_HEIGHT = 50;
  
  private Level level;
  private int currentLevel;
  
  private int m_paddingWidth;
  private int m_gameScreenWidth;
  private int m_cellSize;
  private int m_rows;
  private int m_columns;
  
  private Cell [][] m_cells;
  private CellUI [][] m_fakeCells; // Cells for emulating falling animation.
  private ArrayList<Cell> m_cellsToClear;
  
  private int m_timeToClearUpdateboard;
  
  private ResetButton m_resetButton;
  private NextButton m_nextButton;
  private PreviousButton m_previousButton;
  
  public GameBoard()
  {
    int resetButtonTop = PADDING_TOP/3;
    int resetButtonLeft = (SCREEN_WIDTH/2) - (RESET_BUTTON_WIDTH/2);
    
    m_resetButton = new ResetButton(resetButtonLeft, resetButtonTop, RESET_BUTTON_WIDTH, RESET_BUTTON_HEIGHT, Colour.GREY_01, Colour.GREY_03);
    m_nextButton = new NextButton(resetButtonLeft + 100, 680, NEXT_BUTTON_WIDTH, NEXT_BUTTON_HEIGHT, Colour.GREY_01, Colour.GREY_03);
    m_previousButton = new PreviousButton(resetButtonLeft - 100, 680, PREVIOUS_BUTTON_WIDTH, PREVIOUS_BUTTON_HEIGHT, Colour.GREY_01, Colour.GREY_03);
    
    currentLevel = 1;
  }
  
  public void createLevel()
  {
    level = new Level(currentLevel);
    
    Block[][] blocks = level.getBlockGrid();
    
    m_columns = blocks.length; // 1st demension indicates number of m_rows
    m_rows = blocks[0].length; // 2nd demension indicates number of m_columns
    m_cells = new Cell[m_columns][m_rows];
    
    m_gameScreenWidth = ((MAX_GAME_SCREEN_WIDTH / 10) / m_columns) * m_columns * 10;
    m_paddingWidth = ((MAX_GAME_SCREEN_WIDTH - m_gameScreenWidth) / 2) + MIN_PADDING_WIDTH;
    m_cellSize = m_gameScreenWidth / m_columns;
    
    for (int row = 0; row < m_rows; row++)
    {
      for (int column = 0; column < m_columns; column++)
      {
          int xpos = m_paddingWidth + m_cellSize * column;
          int ypos = PADDING_TOP + m_cellSize * row;
          
          m_cells[column][row] = new Cell(column, row, m_cellSize, xpos, ypos);
          m_cells[column][row].addBlock(blocks[column][row]);
      }
    }
        
    createFakeBoard();
  }
  
  public void display()
  {
    if (m_fakeCells != null)
    {
      for (int column = 0; column < m_columns; column++)
      {
        for (int row = 0; row < m_rows; row++)
        {
          if (m_fakeCells[column][row].isVisible())
          {
            m_fakeCells[column][row].display();
          }
        }
      }
    }
    
    m_resetButton.display();
    m_nextButton.display();
    m_previousButton.display();
  }
  
  public void updateBoard()
  {
    if (m_cellsToClear != null && !m_cellsToClear.isEmpty())
    {
      if (millis() > m_timeToClearUpdateboard) 
      {
        while (!m_cellsToClear.isEmpty())
        {
          Cell cell = m_cellsToClear.remove(0);  
          cell.clearCell();
        }

        createFakeBoard();
        cleanupBoard();
      }
    }
  }
  
  public void mousePressedGameBoard()
  {
    if (mouseX > m_paddingWidth && mouseY > PADDING_TOP)
    {
      int x = (mouseX - m_paddingWidth) / m_cellSize;
      int y = (mouseY - PADDING_TOP) / m_cellSize;
      
      handleCellMousePressed(x, y);
    }
            
    m_resetButton.mousePressed();
    m_nextButton.mousePressed();
    m_previousButton.mousePressed();
  }
  
  public void mouseClickedBoardGame()
  {
     m_resetButton.mouseClick(this);
     m_resetButton.mouseReleased();
     
     m_nextButton.mouseClick(this);
     m_nextButton.mouseReleased();
     
     m_previousButton.mouseClick(this);
     m_previousButton.mouseReleased();
  }
  
  public void mouseReleasedGameBoard()
  {
    m_resetButton.mouseReleased();
    m_nextButton.mouseReleased();
    m_previousButton.mouseReleased();
  }
  
  public void handleCellMousePressed(int x, int y)
  {
    if (x >= 0 && x < m_columns
      && y >= 0 && y < m_rows && !m_cells[x][y].isEmpty())
    {
      if (!m_cells[x][y].isEmpty() && m_cells[x][y].getBlock().getBlockType().getBlockTypeId() != BlockConstant.TYPE_BASIC)
      {
        ArrayList<Cell> cellsToClear = new ArrayList();
        m_cellsToClear = getCellsToClear(cellsToClear, new ArrayList(), x, y);
        createFakeBoard();
        m_timeToClearUpdateboard = millis() + 250;
      }
    }
  }
  
  public ArrayList<Cell> getCellsToClear(ArrayList<Cell> cellsToClear, ArrayList<Cell> cellAlreadyTriggered, int x, int y)
  {
    cellsToClear.add(m_cells[x][y]);
    cellAlreadyTriggered.add(m_cells[x][y]);  
      
    Block block = m_cells[x][y].getBlock();
    BlockType blockType = block.getBlockType();
    block.setActive(false);
    
    if (blockType.getBlockTypeId() == BlockConstant.TYPE_UP)
    {
      for (int row = 0; row < y; row++)
      {
        Block b = m_cells[x][row].getBlock();
        
        if (b != null)
        {
          if (block.getBlockColourId() == b.getBlockColourId())
          {
            cellsToClear.add(m_cells[x][row]);
            b.setActive(false);
          }
        }
      }
    }
    
    if (blockType.getBlockTypeId() == BlockConstant.TYPE_DOWN)
    {
      for (int row = y; row < m_rows; row++)
      {
        Block b = m_cells[x][row].getBlock();
        
        if (b != null)
        {
          if (block.getBlockColourId() == b.getBlockColourId())
          {
            cellsToClear.add(m_cells[x][row]);
            b.setActive(false);
          }
        }
      }
    }
    
    if (blockType.getBlockTypeId() == BlockConstant.TYPE_LEFT)
    {
      for (int column = 0; column < x; column++)
      {
        Block b = m_cells[column][y].getBlock();
        
        if (b != null)
        {
          if (block.getBlockColourId() == b.getBlockColourId())
          {
            cellsToClear.add(m_cells[column][y]);
            b.setActive(false);
          }
        }
      }
    }
    
    if (blockType.getBlockTypeId() == BlockConstant.TYPE_RIGHT)
    {
      for (int column = x; column < m_columns; column++)
      {
        Block b = m_cells[column][y].getBlock();
        
        if (b != null)
        {
          if (block.getBlockColourId() == b.getBlockColourId())
          {
            cellsToClear.add(m_cells[column][y]);
            b.setActive(false);
          }
        }
      }
    }
    
    if (blockType.getBlockTypeId() == BlockConstant.TYPE_CHAIN)
    {
        cellsToClear.add(m_cells[x][y]);
        
        ArrayList<Cell> cellsAlreadyTraversed = new ArrayList();
        cellsToClear.addAll(triggerChainBlock(cellsAlreadyTraversed, x, y));
    }
    
    for (int n = 0; n < cellsToClear.size(); n++)
    {
      Cell cell = cellsToClear.get(n);
      if (!cellAlreadyTriggered.contains(cell))
      {
         cellsToClear = getCellsToClear(cellsToClear, cellAlreadyTriggered, cell.getXCoord(), cell.getYCoord());
         break;
      }
    }
    
    return cellsToClear;
  }
  
  private ArrayList<Cell> triggerChainBlock(ArrayList<Cell> cellsAlreadyTraversed, int currentColumn, int currentRow)
  {
    
    if (currentColumn - 1 >= 0 && // Column to the left exists
        !m_cells[currentColumn - 1][currentRow].isEmpty() &&  // Has block
        m_cells[currentColumn - 1][currentRow].getBlock().getBlockColourId() == m_cells[currentColumn][currentRow].getBlock().getBlockColourId() && // Same colour
        !cellsAlreadyTraversed.contains(m_cells[currentColumn - 1][currentRow])) // Hasn't already been traversed
    {
      cellsAlreadyTraversed.add(m_cells[currentColumn - 1][currentRow]);
      triggerChainBlock(cellsAlreadyTraversed, currentColumn - 1, currentRow);
      m_cells[currentColumn - 1][currentRow].getBlock().setActive(false);
    }
    
    if (currentColumn + 1 < m_columns && // Column to the right exists
        !m_cells[currentColumn + 1][currentRow].isEmpty() &&  // Has block
        m_cells[currentColumn + 1][currentRow].getBlock().getBlockColourId() == m_cells[currentColumn][currentRow].getBlock().getBlockColourId() && // Same colour
        !cellsAlreadyTraversed.contains(m_cells[currentColumn + 1][currentRow])) // Hasn't already been traversed
    {
      cellsAlreadyTraversed.add(m_cells[currentColumn + 1][currentRow]);
      triggerChainBlock(cellsAlreadyTraversed, currentColumn + 1, currentRow);
      m_cells[currentColumn + 1][currentRow].getBlock().setActive(false);
    }
    
    if (currentRow - 1 >= 0 && // Column to the top exists
        !m_cells[currentColumn][currentRow - 1].isEmpty() &&  // Has block
        m_cells[currentColumn][currentRow - 1].getBlock().getBlockColourId() == m_cells[currentColumn][currentRow].getBlock().getBlockColourId() && // Same colour
        !cellsAlreadyTraversed.contains(m_cells[currentColumn][currentRow - 1])) // Hasn't already been traversed
    {
      cellsAlreadyTraversed.add(m_cells[currentColumn][currentRow - 1]);
      triggerChainBlock(cellsAlreadyTraversed, currentColumn, currentRow - 1);
      m_cells[currentColumn][currentRow - 1].getBlock().setActive(false);
    }
    
    if (currentRow + 1 < m_rows && // Column to the bottom exists
        !m_cells[currentColumn][currentRow + 1].isEmpty() &&  // Has block
        m_cells[currentColumn][currentRow + 1].getBlock().getBlockColourId() == m_cells[currentColumn][currentRow].getBlock().getBlockColourId() && // Same colour
        !cellsAlreadyTraversed.contains(m_cells[currentColumn][currentRow + 1])) // Hasn't already been traversed
    {
      cellsAlreadyTraversed.add(m_cells[currentColumn][currentRow + 1]);
      triggerChainBlock(cellsAlreadyTraversed, currentColumn, currentRow + 1);
      m_cells[currentColumn][currentRow + 1].getBlock().setActive(false);
    }
    
    return cellsAlreadyTraversed;
  }
  
  public void cleanupBoard()
  {
    ArrayList<Block> blockList = new ArrayList();
      
    for (int column = 0; column < m_columns; column++)
    {
      for (int row = m_rows-1; row >= 0; row--)
      {
        if (!m_cells[column][row].isEmpty())
        {
          blockList.add(m_cells[column][row].getBlock());
        }
      }
      
      for (int row = m_rows-1; row >= 0; row--)
      {
        if (blockList.isEmpty())
        {
          m_cells[column][row].clearCell();
        }
        else
        {
          m_cells[column][row].addBlock(blockList.remove(0));
        }
      }
    }
  }
  
  public void createFakeBoard()
  {
    m_fakeCells = new CellUI[m_columns][m_rows];
    for (int column = 0; column < m_columns; column++)
    {
      for (int row = 0; row < m_rows; row++)
      {
          m_fakeCells[column][row] = new CellUI(m_cells[column][row]);
      }
    }
  }
  
  public void simulateBlockDrop()
  {
    if (m_fakeCells != null)
    {
      for (int column = m_columns-1; column >= 0; column--)
      {
        // If bottom cell does not contain block, we must still give it a value so following blocks are able to stack on top of this empty cell.
        if (m_fakeCells[column][m_rows-1].isEmpty())
        {
          m_fakeCells[column][m_rows-1].setTop((m_rows * m_cellSize) + PADDING_TOP);
          m_fakeCells[column][m_rows-1].setVisible(false);
        }
        
        // We don't need to check if the bottom cells are at the bottom hence we start at (length - 2)
        for (int row = m_rows-2; row >= 0; row--)
        {
          // Ignore empty cells.  By setting the empty cell to have the same top value as the cell below it, we are effectively ignoring it.
          if (m_fakeCells[column][row].isEmpty())
          {
            m_fakeCells[column][row].setTop(m_fakeCells[column][row+1].getTop());
            m_fakeCells[column][row].setVisible(false);
          }
          else
          {
            // If the cell is not empty, we want to move the tile until it stacks directly above the tile below it.
            if (m_fakeCells[column][row].getTop() + m_cellSize < m_fakeCells[column][row+1].getTop())
            {
              m_fakeCells[column][row].setTop(m_fakeCells[column][row].getTop() + BlockConstant.BLOCK_DROP_SPEED);
            }
          }
        }
      }
    }
  }
  
  public void reset()
  {
    createLevel();
  }
  
  public void nextLevel()
  {
    if (level.getLevel() < 3)
    {
       currentLevel++;
       reset();
    }
  }
  
  public void previousLevel()
  {
    if (level.getLevel() > 1)
    {
       currentLevel--;
       reset();
    }
  }
}