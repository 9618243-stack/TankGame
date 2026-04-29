class Tank {
  float x, y, w, h, speed, health;
  float baseSpeed = 8.0; // Your normal speed
  int boostTimer = 0;    // Tracks when the boost should end
  char idir;
  PImage iTankW, iTankA, iTankS, iTankD, bombImg, heartImg;

  Tank() {
    x = 250; y = 250; w = 80; h = 80; 
    speed = baseSpeed; 
    health = 75.0; 
    idir = 'w';
    iTankW = loadImage("tankW.png");
    iTankA = loadImage("tankA.png");
    iTankS = loadImage("tankS.png");
    iTankD = loadImage("tankD.png");
    bombImg = loadImage("kleven_bomb.png");
    heartImg = loadImage("health.png");
  }

  void display() {
    checkBoost(); // Check if the speed boost has expired
    imageMode(CENTER);
    if (idir == 'w') image(iTankW, x, y, w, h);
    else if (idir == 'a') image(iTankA, x, y, w, h);
    else if (idir == 's') image(iTankS, x, y, w, h);
    else if (idir == 'd') image(iTankD, x, y, w, h);
  }

  void move(char dir) {
    idir = dir;
    if (dir == 'w') y -= speed;
    else if (dir == 's') y += speed;
    else if (dir == 'a') x -= speed;
    else if (dir == 'd') x += speed;
    x = constrain(x, w/2, width - w/2);
    y = constrain(y, h/2, height - h/2);
  }

  void boostSpeed() {
    speed = baseSpeed + 10;      // Increase speed by 10
    boostTimer = millis() + 5000; // Set end time to 5 seconds (5000ms) from now
  }

  void checkBoost() {
    if (millis() > boostTimer) {
      speed = baseSpeed; // Reset to normal speed after 5 seconds
    }
  }

  boolean hitBomb(Bomb b) { return dist(x, y, b.x, b.y) < (w/2 + b.w/2 - 10); }
  boolean hitHeart(Heart hrt) { return dist(x, y, hrt.x, hrt.y) < (w/2 + hrt.w/2); }
}
