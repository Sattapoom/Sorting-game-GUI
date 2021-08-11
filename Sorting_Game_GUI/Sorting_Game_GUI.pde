import java.util.Arrays;

int size_x = 800;
int size_y = 600;
String[][] game_board = {{"A","B","C","D"}, {"E","F","G","H"}, {"I","J","K"," "}};
String[][] sorted_board = {{"A","B","C","D"}, {"E","F","G","H"}, {"I","J","K"," "}};
int[] index_space = {2,3};

void shuffle_board(){
    String[] remember = new String[3];
    int ran = (int) random(100,250);
    for (int round=0 ; round<=ran;round++) {
        String[] move_able = {" "," "," "," "};
        if (index_space[0]==1) {
            move_able[0] = game_board[index_space[0]-1][index_space[1]];
            move_able[1] = game_board[index_space[0]+1][index_space[1]];
        }
        else if (index_space[0]==0) {
            move_able[1] = game_board[index_space[0]+1][index_space[1]];
        }
        else if (index_space[0]==2) {
            move_able[0] = game_board[index_space[0]-1][index_space[1]];
        }
        if (index_space[1]==0) {
            move_able[3] = game_board[index_space[0]][index_space[1]+1];
        }
        else if (index_space[1]==3) {
            move_able[2] = game_board[index_space[0]][index_space[1]-1];
        }
        else {
            move_able[3] = game_board[index_space[0]][index_space[1]+1];
            move_able[2] = game_board[index_space[0]][index_space[1]-1];
        }
      
        String moving = move_able[(int) random(0,4)];  
        while (moving.equals(" ")) {
          moving = move_able[(int) random(0,4)];    
        }
        if ( !(moving.equals(remember[0]) || moving.equals(remember[1]) || moving.equals(remember[2]))) {
          moveChar(moving);
        }
        if (0<(int)random(0,1)) {
          remember[round%3] = moving;
        }
    }
}


String onClick(int mouse_x,int mouse_y){
  
  int row,col;
  row = (int)mouse_y/200;
  col = (int)mouse_x/200;
  
  return game_board[row][col];
}

void moveChar(String c){
  int topIndex = index_space[0] - 1;
  if (topIndex >= 0) {
    if (game_board[topIndex][index_space[1]].equals(c)) {
      game_board[topIndex][index_space[1]] = " ";
      game_board[index_space[0]][index_space[1]] = c;
      index_space[0] = topIndex;
      return;
    }
  }
  int bottomIndex = index_space[0] + 1;
  if (bottomIndex <= 2) {
    if (game_board[bottomIndex][index_space[1]].equals(c)) {
      game_board[bottomIndex][index_space[1]] = " ";
      game_board[index_space[0]][index_space[1]] = c;
      index_space[0] = bottomIndex;
      return;
    }
  }
  int leftIndex = index_space[1] - 1;
  if (leftIndex >= 0) {
    if (game_board[index_space[0]][leftIndex].equals(c)) {
      game_board[index_space[0]][leftIndex] = " ";
      game_board[index_space[0]][index_space[1]] = c;
      index_space[1] = leftIndex;
      return;
    }
  }
  int rightIndex = index_space[1] + 1;
  if (rightIndex <= 3) {
    if (game_board[index_space[0]][rightIndex].equals(c)) {
      game_board[index_space[0]][rightIndex] = " ";
      game_board[index_space[0]][index_space[1]] = c;
      index_space[1] = rightIndex;
      return;
    }
  }
  return;
}

Boolean checkCondition(){
  if (Arrays.deepEquals(game_board, sorted_board)){
    return true;
  }
  else{
    return false;
  }
}

// ********* GUI's part *********

void setup(){
 size(800,600);
 frameRate(10);
 shuffle_board();
}

void add_section(){
   for (int x = 0;x<3;x++){
     int rowx = 0;
     int rowy = 200 * x;
     for (int y = 0;y<4;y++){
       fill(255);
       rect(rowx,rowy,200,200);
       rowx += 200;
     }
   }
  for(int i = 0;i<game_board.length;i++){
    for(int j=0;j<game_board[i].length;j++){
      fill(75,120,255);
      textSize(120);
      text(game_board[i][j],65+(200*j),140+(200*i));
    }
  }
}

void draw(){
  background(255);
  if (!checkCondition()) {
    add_section();
    if(mousePressed){
      String c = onClick(mouseX,mouseY);
      moveChar(c);
    }
  } 
  else {
    fill(255,120,75);
    textSize(240);
    text("WIN",200,400);
  }
}
