import java.util.Arrays;

String[][] game_board = {{"A","B","C","D"}, {"E","F","G","H"}, {"I","J","K"," "}};
int[] index_space = {2,3};
String game_mode = "Menu";

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
  String[][] sorted_board = {{"A","B","C","D"}, {"E","F","G","H"}, {"I","J","K"," "}};
  if (Arrays.deepEquals(game_board, sorted_board)){
    Manage_file("d");
    return true;
  }
  else{
    return false;
  }
}

void Manage_file(String game_mode){
  if (game_mode.equals("w")) {
    String[] data = {""};
    for (int i=0;i < 3;i++) {
      for (int j=0;j < 4;j++) {
        data[0] += game_board[i][j] + ",";
      }
    }
    saveStrings("save.csv", data);
  }
  else if (game_mode.equals("r")) {
    String[] data = loadStrings("save.csv");
    String[] list = split(data[0], ',');
    int index = 0;
    for (int i=0;i < 3;i++) {
      for (int j=0;j < 4;j++) {
        game_board[i][j] = list[index];
        index += 1;
        if (game_board[i][j].equals(" ")) {
          index_space[0] = i;
          index_space[1] = j;
        }
      }
    }
  }
  else if (game_mode.equals("d")) {
    String[] data = {"A,B,C,D,E,F,G,H,I,J,K"};
    saveStrings("save.csv", data);
  }
  return;
}

// ********* GUI's part *********
void draw_Menu(Boolean click_status){
  String[] save = loadStrings("save.csv");
  int rectcolor = 240;
  int rectover = 200;
  textSize(55);
  if (mouseX >= 250 && mouseX <= 550 && 
    mouseY >= 150 && mouseY <= 250) {
    fill(rectover);
    rect(250,150,300,100);
    fill(0,120,50);
    text("New game",260,215);
    if(click_status){
      game_mode = "Play";
    }
  }
  else if(mouseX >= 250 && mouseX <= 550 && 
    mouseY >= 350 && mouseY <= 450 && !(save[0].equals("A,B,C,D,E,F,G,H,I,J,K, ,"))) {
    fill(rectover);
    rect(250,350,300,100);
    fill(0,120,50);
    text("Continue",280,415);
    if(click_status){
      game_mode = "Continue";
    }
  }
  else{
    background(255);
    fill(rectcolor);
    rect(250,150,300,100);
    fill(0,120,50);
    text("New game",260,215);
    
    if(!(save[0].equals("A,B,C,D,E,F,G,H,I,J,K, ,"))){
      fill(rectcolor);
      rect(250,350,300,100);
      fill(0,120,50);
      text("Continue",280,415);
    }
    game_mode = "Menu";
  }
}

void draw_Game(Boolean click_status){
  background(255);
  if (!checkCondition()) {
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
     if(game_mode.equals("Play") && click_status){   
       String c = onClick(mouseX,mouseY);
       moveChar(c);
    }
  }
  else {
    fill(255,120,75);
    textSize(240);
    text("WIN",200,400);
    game_mode = "None";
  }
  game_mode = "Play";
}
void mouseReleased() {
  if(game_mode.equals("Menu")){
    draw_Menu(true);
  }
  else if(game_mode.equals("Play")){
    draw_Game(true);
    Manage_file("w");
  }
}

void setup(){
 size(800,600);
 frameRate(60);
 shuffle_board();
}

void draw() {
  switch(game_mode) {
  case "Menu":
    draw_Menu(false);
    break;
  case "Play":
    draw_Game(false);
    break;
  case "Continue":
    Manage_file("r");
    game_mode = "Play";
    break;
  }
}
