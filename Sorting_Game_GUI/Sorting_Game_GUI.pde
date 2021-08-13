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
    Manage_file("w");
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
  Manage_file("w");
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
  JSONObject save = new JSONObject();
  if (game_mode.equals("w")) {
    JSONArray json_index_space = new JSONArray();
    json_index_space.setInt(0, index_space[0]);
    json_index_space.setInt(1, index_space[1]);
    save.setJSONArray("index_space",json_index_space);
    
    JSONArray json_game_board = new JSONArray();
    for (int i =0;i < 3;i++) {
      JSONArray line = new JSONArray();
      for (int j =0;j < 4;j++) {
        line.setString(j,game_board[i][j]);
      }
      json_game_board.setJSONArray(i,line);
    }
    
    save.setJSONArray("game_board",json_game_board);
    saveJSONObject(save, "save.json");
  }
  else if (game_mode.equals("r")) {
     save = loadJSONObject("save.json");
     JSONArray json_index_space = save.getJSONArray("index_space");
     index_space[0] = json_index_space.getInt(0);
     index_space[1] = json_index_space.getInt(1);
     
     JSONArray json_game_board = save.getJSONArray("game_board");
     for (int i =0;i < 3;i++) {
       JSONArray line = json_game_board.getJSONArray(i);
       for (int j =0;j < 4;j++) {
         game_board[i][j] = line.getString(j);
       }
     }
  }
  else if (game_mode.equals("d")) {
    save.setJSONArray("index_space",null);
    save.setJSONArray("game_board",null);
    saveJSONObject(save, "save.json");
  }
  return;
}

// ********* GUI's part *********
void draw_Menu(){
  int rectcolor = 240;
  int rectover = 200;
  if (mouseX >= 250 && mouseX <= 550 && 
    mouseY >= 150 && mouseY <= 250) {
    fill(rectover);
    rect(250,150,300,100);
    fill(0,120,50);
    textSize(55);
    text("New game",260,215);
    if(mousePressed){
      game_mode = "New";
    }
  }
  else if(mouseX >= 250 && mouseX <= 550 && 
    mouseY >= 350 && mouseY <= 450) {
    fill(rectover);
    rect(250,350,300,100);
    fill(0,120,50);
    textSize(55);
    text("Continue",280,415);
    if(mousePressed){
      game_mode = "Continue";
    }
  }
  else{
    background(255);
    fill(rectcolor);
    rect(250,150,300,100);
    rect(250,350,300,100);
    fill(0,120,50);
    textSize(55);
    text("New game",260,215);
    text("Continue",280,415);
    game_mode = "Menu";
  }
}

void draw_Game(){
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

void setup(){
 size(800,600);
 frameRate(60);
 shuffle_board();
}

void draw() {
  switch(game_mode) {
  case "Menu":
    draw_Menu();
    break;
  case "New":
    draw_Game();
    break;
  case "Continue":
    
    break;
  }
}
