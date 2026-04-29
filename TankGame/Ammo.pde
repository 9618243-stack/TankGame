class AmmoBox {
  float x, y, w = 30, h = 30;

  AmmoBox(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display(PImage img) {
    imageMode(CENTER);
    if (img != null) {
      image(img, x, y, w, h);
    } else {
      fill(200, 200, 0); // Yellow box if image missing
      rect(x, y, w, h);
    }
  }

  boolean checkCollision(float tx, float ty, float tw) {
    return dist(x, y, tx, ty) < (w/2 + tw/2);
  }
}
