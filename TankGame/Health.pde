class Heart {
  float x, y, w, h, val;
  Heart(float x, float y, float w, float h, float v) {
    this.x = x; this.y = y; this.w = w; this.h = h; this.val = v;
  }
  void display(PImage img) {
    imageMode(CENTER);
    if (img != null) image(img, x, y, w, h);
  }
  void reset() { x = random(50, 450); y = random(50, 450); }
}
