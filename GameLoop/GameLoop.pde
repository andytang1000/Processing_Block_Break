GameBoard gameBoard;

public void settings()
{
  size(GameBoard.SCREEN_WIDTH, GameBoard.SCREEN_HEIGHT);
}

public void setup()
{
  
  gameBoard = new GameBoard();
  gameBoard.createLevel();
}

public void draw()
{
  background(Colour.BLUE_GREY_10);
  gameBoard.updateBoard();
  gameBoard.simulateBlockDrop();
  gameBoard.display();
  
}

public void mousePressed()
{
  gameBoard.mousePressedGameBoard();
}

public void mouseClicked() 
{
  gameBoard.mouseClickedBoardGame();
}

public void mouseReleased()
{
  gameBoard.mouseReleasedGameBoard();
}