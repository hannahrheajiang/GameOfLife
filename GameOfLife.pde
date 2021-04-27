import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final int NUM_ROWS = 50;
public final int NUM_COLS = 50;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program
int frame = 7;
boolean on = true;

public void setup () {
  size(700, 700);
  frameRate(frame);
  // make the manager
  Interactive.make( this );
  
  //your code to initialize buttons goes here
  buttons = new Life [NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++)
  {
    for (int c = 0; c < NUM_COLS; c++)
    {
      buttons[r][c] = new Life (r, c);
    }
  }
  
  //your code to initialize buffer goes here
  buffer = new boolean [NUM_ROWS][NUM_COLS];
  for (int r = 0; r < buffer.length; r++)
  {
    for (int c = 0; c < buffer[0].length; c++)
    {
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();
  //copyFromBufferToButtons();
  if (on) {
    //use nested loops to draw the buttons here
    for (int r = 0; r < buttons.length; r++)
    {
      for (int c = 0; c < buttons[0].length; c++)
      {
        if (countNeighbors(r, c) == 3)
        {
          buffer[r][c] = true;
        }
        else if (countNeighbors(r, c) == 2 && buttons[r][c].getLife())
        {
          buffer[r][c] = true;
        }
        else
        {
          buffer[r][c] = false;
        }
        buttons[r][c].draw();
      }
    }
    copyFromBufferToButtons();
  }
}

public void keyPressed() {
  //adjust framerate
  if (keyCode == DOWN) {
      frame--; 
    }
  if (keyCode == UP) {
      frame++; 
    }
   if (frame > 0){
     frameRate(frame);
   }
   if (key == ' ') {
      on = !on; 
    }
}

public void copyFromBufferToButtons() {
  for (int r = 0; r < buffer.length; r++)
  {
    for (int c = 0; c < buffer[0].length; c++)
    {
      buttons[r][c].setLife(buffer[r][c]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  for (int r = 0; r < buffer.length; r++)
  {
    for (int c = 0; c < buffer[0].length; c++)
    {
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
    return true;
  else
    return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  for (int r = row-1; r <= row+1;  r++){
    for (int c = col-1; c <= col+1; c++){
      if (isValid(r, c)){
        if (buttons[r][c].getLife() == true){
          neighbors += 1;
        }
      }
    }
  }
  if (buttons[row][col].getLife()) {
    neighbors--;
  }
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private double x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 700/NUM_COLS;
    height = 700/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () { 
    noStroke();
    fill(alive ? 255 : 0);
    rect((float) x, (float)y, (float)width, (float)height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
