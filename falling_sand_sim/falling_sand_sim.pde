int[][] grid;
//scale of each square
int scale = 5;
int cols, rows;
int hueValue = 200;

void setup()
{
  size(400,600);
  colorMode(HSB, 360, 255, 255);
  //gets column and row amount depending on screen size
  //and scale
  cols = (int)width / scale;
  rows = (int)height / scale;
  grid = new int[cols][rows];
  //fills array with 0s
  fillArray(grid);
}

boolean withinCols(int i)
{
  return i >= 0 && i < cols;
}

boolean withinRows(int i)
{
  return i >= 0 && i < rows;
}

void mouseDragged()
{
  int mouseC = (int) mouseX / scale;
  int mouseR = (int) mouseY / scale;
  
  int matrix = 4;
  int extent = matrix/2;
  for(int a = -extent; a <= extent; a++)
  {
    for(int b = -extent; b <= extent; b++)
    {
      if(random(0,1) > 0.50) //spawns sand randomly around matrix
      {
      int c = mouseC + a;
      int r = mouseR + b;
       if(withinCols(c) && withinRows(r))
        {
         grid[c][r] = hueValue;
        }
      }
    }
  }
  //changes colour
  hueValue ++;
  if(hueValue > 360)
  {
    hueValue = 1;
  }
 
}

void draw()
{
  background(0);
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      noStroke();
      if(grid[i][j] > 0)
      {
        fill(grid[i][j], 255, 255);
      }
      else
      {
        noFill();
      }
      int x = i*scale;
      int y = j*scale;
      rect(x,y,scale,scale);
    }
  }
  
  int[][] nextGrid = new int[cols][rows];
  fillArray(nextGrid);
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      int state = grid[i][j]; //checking grid square
      int below = -1; //below variables are set to invalid numbers, for now
      int belowR = -1;
      int belowL = -1;
      if(state > 0) //if grid square is active
      {
        //below
        if(withinCols(i) && withinRows(j+1))
        {
           below = grid[i][j+1]; //gets grid square below this one, if in bounds
        }
        
        //right
        if(withinCols(i+1) && withinRows(j+1))
        {
           belowR = grid[i+1][j+1];
        }
        
        //left
        if(withinCols(i-1) && withinRows(j+1))
        {
          belowL = grid[i-1][j+1];
        }
        
        if(below == 0)
        {
          nextGrid[i][j+1] = state;
        }
        else if(belowR == 0)
        {
          nextGrid[i+1][j] = state;
        }
        else if(belowL == 0)
        {
          nextGrid[i-1][j] = state;
        }
        else
        {
          nextGrid[i][j] = state;
        }
      }
    }
  }
  grid = nextGrid;
}

void fillArray(int[][] arr)
{
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      arr[i][j] = 0;
    }
  }
  
}
