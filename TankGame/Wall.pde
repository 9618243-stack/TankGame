class Obstacle {
  float x, y, w = 50, h = 50;
  Obstacle(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void display(PImage img) {
    imageMode(CENTER);
    if (img != null) image(img, x, y, w, h);
    else {
      fill(120);
      rect(x, y, w, h);
    }
  }
} 
