class Bomb {
  float x, y, w, h, val, speed;
  Bomb(float x, float y, float w, float h, float v, float s) {
    this.x = x; this.y = y; this.w = w; this.h = h; this.val = v; this.speed = s;
  }
  void display(PImage img) {
    imageMode(CENTER);
    if (img != null) image(img, x, y, w, h);
    else { fill(255, 0, 0); ellipse(x, y, w, h); }
  }
  void move() { y += speed; }
}
