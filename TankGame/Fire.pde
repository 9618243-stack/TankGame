class Bullet {
  float x, y, speed, size = 7; 
  char dir;
  Bullet(float x, float y, char dir) {
    this.x = x; this.y = y; this.dir = dir; this.speed = 10;
  }
  void move() {
    if (dir == 'w') y -= speed;
    else if (dir == 's') y += speed;
    else if (dir == 'a') x -= speed;
    else if (dir == 'd') x += speed;
  }
  void display() {
    pushMatrix();
    translate(x, y);
    if (dir == 's') rotate(PI);
    else if (dir == 'a') rotate(-HALF_PI);
    else if (dir == 'd') rotate(HALF_PI);
    fill(255, 150, 0); noStroke();
    triangle(0, -size, -size/2, size, size/2, size);
    popMatrix();
  }
}
