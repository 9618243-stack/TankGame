class PowerUp {
  float x, y, w=40, h=40;
  PImage img;
  boolean active;

  PowerUp() {
    img = loadImage("powerup.png");
    reset();
  }

  void display() {
    if (active) {
      imageMode(CENTER);
      if (img != null) image(img, x, y, w, h);
    }
  }

  void reset() {
    x = random(50, 450);
    y = random(50, 450);
    active = true;
  }

  boolean checkCollision(float tx, float ty, float tw) {
    if (active && dist(x, y, tx, ty) < (w/2 + tw/2)) {
      active = false;
      return true;
    }
    return false;
  }
}
