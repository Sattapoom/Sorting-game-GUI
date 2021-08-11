int size_x = 800;
int size_y = 600;
String[][] game_board = {{"A","B","C","D"}, {"E","F","G","H"}, {"I","J","K"," "}};
String[][] sorted_board = {{"A","B","C","D"}, {"E","F","G","H"}, {"I","J","K"," "}};
int[] index_space = {2,3};
// Poom was tried Char array to declare board but it's can't be used.we need to use str[][].

void shuffle_board(){
    String[] remember = new String[3];
    int ran = (int) random(50,250);
    for(int round=0 ; round<=ran;round++){
        String[] move_able = new String[0];
        if(index_space[0]==1){
            move_able = append(move_able,game_board[index_space[0]-1][index_space[1]]);
            move_able = append(move_able,game_board[index_space[0]+1][index_space[1]]);
        }
        else if(index_space[0]==0){
            move_able = append(move_able,game_board[index_space[0]+1][index_space[1]]);
        }
        else if(index_space[0]==2){
            move_able = append(move_able,game_board[index_space[0]-1][index_space[1]]);
        }
        if(index_space[1]==0){
            move_able = append(move_able,game_board[index_space[0]][index_space[1]+1]);
        }
        else if(index_space[1]==3){
            move_able = append(move_able,game_board[index_space[0]][index_space[1]-1]);
        }
        else{
            move_able = append(move_able,game_board[index_space[0]][index_space[1]+1]);
            move_able = append(move_able,game_board[index_space[0]][index_space[1]-1]);
        }
        String moving = game_board[index_space[0]][index_space[1]];
        while (moving.equals(" ") || moving.equals(remember[(round+1)%3]) || moving.equals(remember[(round+2)%3])){
            moving = move_able[(int) random(0,5)];
        }
        moveChar(moving);
        remember[round%3] = moving;
    }
}


String onClick(int mouse_x,int mouse_y){
  int row,col;
  row = (int)mouse_y/200;
  col = (int)mouse_x/200;
  return game_board[row][col];
}

void moveChar(String c){

}

Boolean checkCondition(){
  return true;
}

// ********* GUI's part *********

void setup(){
 size(800,600);
 frameRate(10);
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
 add_section();
 if(mousePressed){
   onClick(mouseX,mouseY);
 }
}
