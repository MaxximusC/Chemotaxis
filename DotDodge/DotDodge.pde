//declare little boi variables here  
ArrayList<LittleBois> army = new ArrayList<LittleBois>();
ArrayList<Coins> money = new ArrayList<Coins>();
ArrayList<Obstacle> objects;
int[] triggered;
int[] triggeredDot;
int shade;
int size;
boolean lose;
boolean blocked;
boolean unblockPlayer;
boolean blockedDot;
boolean letGoStart;
int letGoTimer;
int blockX;
int blockY;
int timer;
int exitTime;
int stop;
int stopstop;
int points;
int finalPoints;
int finalLevel;
PlayerBoi player;
void setup() { 
  objects = new ArrayList<Obstacle>();
  triggered = new int[10];
  triggeredDot = new int[10];
  player = new PlayerBoi(12);
  finalPoints = 0;
  timer = 0;
  letGoStart = false;
  blockedDot = false;
  unblockPlayer = true;
  blocked = false;
  stop = 0;
  size(800, 800);
  background(0);
  points = 0;
  shade = 0;
  size = 10;
  lose = false;
  frameRate(60);
  army.add(new LittleBois(round(random(800)), round(random(800)), 20, 20));
  money.add(new Coins());
}   
void draw() {  
  if(army.size() == 1){
    textSize(100);
    text("Dodge the dots!", 350, 150);
  }
  timer++;
  stop++;
  if (letGoStart == true) {
    letGoTimer++;
  }
  if (timer == 1) {
    if (army.size() % 4 == 0) {
      objects.add(new Obstacle(round(random(600) + 100), round(random(600) + 100), round(random(115) + 30), round(random(115) + 30)));
      triggered[objects.size()-1] = 0;
    }
  }
  if (timer == 300) {
    points += 10;
    army.add(new LittleBois(round(random(800)), round(random(800)), 20, 20));
    if (money.size() > 0) {
      money.remove(0);
    }
    money.add(new Coins());
    timer = 0;
  }
  fill(125, 0, 0);
  rect(0, 0, width, height);
  for (int i = 0; i < army.size(); i++) {
    fill(0);
    textSize(50);
    text("Level: "+ army.size(), 50, 50);
    text("Score: " + points, 550, 50);
    if(army.size() == 1){
    text("Dodge the dots!", 200, 150);
    }
    if(army.size() == 2){
    text("Collect yellow coins!", 150, 150);
    }
    if (objects.size() > 0) {
      if (i < objects.size()) {
        objects.get(i).show();
      }
    }
    if (army.size() < 4) {
      player.setxpos(mouseX);
      player.setypos(mouseY);
      player.Display();
    }
    if (objects.size() > 0) {
      if (i < objects.size()) {
        if ((mouseX > objects.get(i).getXpos() && mouseX < objects.get(i).getXpos() + objects.get(i).getLength()) && (mouseY > objects.get(i).getYpos() && mouseY < objects.get(i).getYpos() + objects.get(i).getWidth())) {
          triggered[i] = 1;
        } else {
          triggered[i] = 0;
        }
      }
    }
    blocked = false;
    for (int q = 0; q < 10; q++) {
      if (triggered[q] == 1) {
        if (unblockPlayer == true) {
          blockX = player.getxpos();
          blockY = player.getypos();
        }
        blocked = true;
        unblockPlayer = false;
        letGoStart = true;
      }
    }
    if (blocked == true && letGoTimer == 60) {
      letGoTimer = 0;
    }
    if (blocked == false) {
      if (letGoStart == true) {
        player.Display();
        if (letGoTimer == 60) {
          letGoStart = false;
          letGoTimer = 0;
          unblockPlayer = true;
          player.setxpos(mouseX);
          player.setypos(mouseY);
          player.Display();
        }
      } else if (letGoStart == false) {
        player.setxpos(mouseX);
        player.setypos(mouseY);
        player.Display();
      }
    } else if (blocked == true) {
      player.setxpos(blockX);
      player.setypos(blockY);
      player.Display();
    }
    if (money.size() > 0) {
      money.get(0).Display();
    }
    if (money.size() > 0) {
      if ((money.get(0).getxpos() - 5 < player.getxpos() && money.get(0).getypos() - 5 < player.getypos()) && (money.get(0).getxpos() + 5 > player.getxpos() && money.get(0).getypos() + 5 > player.getypos())) {
        points += money.get(0).getWorth();
        money.remove(0);
      }
    }

    fill(0, 0, 150);
    int j1 = army.get(i).getXpos();  
    int j2 = army.get(i).getYpos();
    fill(shade);
    army.get(i).render();
    blockedDot = false;
    if (objects.size() > 0) {
      for (int q = 0; q < objects.size(); q++) {
        if ((army.get(i).getXpos() > objects.get(q).getXpos() - 15 && army.get(i).getXpos() < objects.get(q).getXpos() + objects.get(q).getLength() + 15) && (army.get(i).getYpos() > objects.get(q).getYpos() - 15 && army.get(i).getYpos() < objects.get(q).getYpos() + objects.get(q).getWidth() + 15)) {
          blockedDot = true;
          triggeredDot[q] = 1;
        }
        if ((army.get(i).getXpos() > objects.get(q).getXpos() - 14 && army.get(i).getXpos() < objects.get(q).getXpos() + objects.get(q).getLength() + 14) && (army.get(i).getYpos() > objects.get(q).getYpos() - 14 && army.get(i).getYpos() < objects.get(q).getYpos() + objects.get(q).getWidth() + 14)) {
          blockedDot = true;
          triggeredDot[q] = 1;
        }
        if ((army.get(i).getXpos() > objects.get(q).getXpos() - 13 && army.get(i).getXpos() < objects.get(q).getXpos() + objects.get(q).getLength() + 13) && (army.get(i).getYpos() > objects.get(q).getYpos() - 13 && army.get(i).getYpos() < objects.get(q).getYpos() + objects.get(q).getWidth() + 13)) {
          blockedDot = true;
          triggeredDot[q] = 1;
        }
        if ((army.get(i).getXpos() > objects.get(q).getXpos() - 12 && army.get(i).getXpos() < objects.get(q).getXpos() + objects.get(q).getLength() + 12) && (army.get(i).getYpos() > objects.get(q).getYpos() - 12 && army.get(i).getYpos() < objects.get(q).getYpos() + objects.get(q).getWidth() + 12)) {
          blockedDot = true;
          triggeredDot[q] = 1;
        }
        if ((army.get(i).getXpos() > objects.get(q).getXpos() - 11 && army.get(i).getXpos() < objects.get(q).getXpos() + objects.get(q).getLength() + 11) && (army.get(i).getYpos() > objects.get(q).getYpos() - 11 && army.get(i).getYpos() < objects.get(q).getYpos() + objects.get(q).getWidth() + 11)) {
          blockedDot = true;
          triggeredDot[q] = 1;
        }
        if ((army.get(i).getXpos() > objects.get(q).getXpos() - 10 && army.get(i).getXpos() < objects.get(q).getXpos() + objects.get(q).getLength() + 10) && (army.get(i).getYpos() > objects.get(q).getYpos() - 10 && army.get(i).getYpos() < objects.get(q).getYpos() + objects.get(q).getWidth() + 10)) {
          blockedDot = true;
          triggeredDot[q] = 1;
        }
      }
    }
    if (blockedDot == true) {
      for (int q = 0; q < triggered.length; q++) {
        if (triggeredDot[q] == 1) {
          if (army.get(i).getXpos() - 1 - round(random(army.size())) < objects.get(q).getXpos() - 15) {
            army.get(i).setXpos(j1 - 1 - round(random(army.size())));
          } else if (army.get(i).getXpos() + 1 + round(random(army.size())) > objects.get(q).getXpos() + objects.get(q).getLength() + 15) {
            army.get(i).setXpos(j1 + 1 + round(random(army.size())));
          }
          if (army.get(i).getYpos() - 1 - round(random(army.size())) < objects.get(q).getYpos() - 15) {
            army.get(i).setYpos(j2 - 1 - round(random(army.size())));
          } else if (army.get(i).getYpos() + 1 + round(random(army.size())) > objects.get(q).getYpos() + objects.get(q).getWidth() + 15) {
            army.get(i).setYpos(j2 + 1 + round(random(army.size())));
          }
        }
      }
    }

    if (blockedDot == false) {
      if (timer % 2 == 0) {
        if (army.get(i).getXpos() < player.getxpos()) {
          army.get(i).setXpos(j1 + 1 + round(random(army.size())));
        } else if (army.get(i).getXpos() > player.getxpos()) {
          army.get(i).setXpos(j1 - 1 - round(random(army.size())));
        }
        if (army.get(i).getYpos() > player.getypos()) {
          army.get(i).setYpos(j2 - 1 - round(random(army.size())));
        } else if (army.get(i).getYpos() < player.getypos()) {
          army.get(i).setYpos(j2 + 1 + round(random(army.size())));
        }
      }
    }

    if ((army.get(i).getXpos() + int(size/2) > player.getxpos() - 6 && army.get(i).getYpos() + int(size/2) > player.getypos() - 6) && (army.get(i).getXpos() - int(size/2) < player.getxpos() + 6 && army.get(i).getYpos() - int(size/2) < player.getypos() + 6))
    {
      if (lose == false) {
        lose = true;
        finalPoints = points;
        finalLevel = army.size();
        stopstop = stop;
      }
    }
    if (lose == true) {
      textSize(100);
      text("You LOST", 175, 200);
      textSize(50);
      text("Final level: "+ finalLevel, 50, 250);
      text("Final score: " + finalPoints, 400, 250);
      if (stop - stopstop > 200) {
        exit();
      }
    }
  }
}

class Obstacle {
  int xpos;
  int ypos;
  int length;
  int width;
  public Obstacle(int x, int y, int a, int b) {
    xpos = x;
    ypos = y;
    length = a;
    width = b;
  }
  void show() {
    fill(0);
    rect(xpos, ypos, length, width);
  }
  int getXpos() {
    return xpos;
  }
  int getYpos() {
    return ypos;
  }
  int getLength() {
    return length;
  }
  int getWidth() {
    return width;
  }
}

class Coins {
  int worth = round(random(15));
  int xpos = round(random(650));
  int ypos = round(random(650));
  void Display() {
    fill(255, 215, 0);
    ellipse(xpos, ypos, 10, 10);
  }
  int getWorth() {
    return worth;
  }
  int getxpos() {
    return xpos;
  }
  int getypos() {
    return ypos;
  }
}

class PlayerBoi
{
  int xpos = mouseX;
  int ypos = mouseY;
  int size;
  public PlayerBoi(int siz) {
    size = siz;
  }
  void Display() {
    fill(0, 255, 0);
    ellipse(xpos, ypos, size, size);
  }
  void setxpos(int x) {
    xpos = x;
  }
  void setypos(int y) {
    ypos = y;
  }
  int getxpos() {
    return xpos;
  }
  int getypos() {
    return ypos;
  }
}

class LittleBois    
{     
  int xpos;
  int ypos;
  public LittleBois(int xx, int yy, int siz, int cc) { 
    xpos = xx;
    ypos = yy;
    size = siz;
    shade = cc;
  }
  public void render() {
    ellipse(xpos, ypos, size, size);
  }
  int getXpos() {
    return xpos;
  }

  void setXpos(int x) {
    xpos=x;
  }
  int getYpos() {
    return ypos;
  }

  void setYpos(int y) {
    ypos=y;
  }
}    
