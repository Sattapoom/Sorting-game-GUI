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
        String[] move_able = {"","","",""};
        if(index_space[0]==1){
            move_able[0] = game_board[index_space[0]-1][index_space[1]];
            move_able[1] = game_board[index_space[0]+1][index_space[1]];
        }
        else if(index_space[0]==0){
            move_able[1] = game_board[index_space[0]+1][index_space[1]];
        }
        else if(index_space[0]==2){
            move_able[0] = game_board[index_space[0]-1][index_space[1]];
        }
        if(index_space[1]==0){
            move_able[3] = game_board[index_space[0]][index_space[1]+1];
        }
        else if(index_space[1]==3){
            move_able[2] = game_board[index_space[0]][index_space[1]-1];
        }
        else{
            move_able[3] = game_board[index_space[0]][index_space[1]+1];
            move_able[2] = game_board[index_space[0]][index_space[1]-1];
        }
        String moving = "";
        while (moving.equals("") && !moving.equals(remember[(round+1)%3]) && !moving.equals(remember[(round+2)%3])){
            moving = move_able[(int) random(0,5)];
        }
        moveChar(moving);
        remember[round%3] = moving;
    }
}


String onClick(int mouse_x,int mouse_y){
  
  
  return "something";
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

void draw(){
 background(255);
 
 fill(0);
 noStroke();
 ellipse(random(0,width), random(0,height),size_x,size_x);
}
