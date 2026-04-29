// Lucy Kleven | Tank Game | April 1, 2026

Heart h1;
PowerUp p1;
PImage bg1, wallImg;
Tank t1;
ArrayList<Bomb> bombs;
ArrayList<Bullet> bullets;
ArrayList<Obstacle> obstacles;

void setup() {
  size(500, 500);
  bg1 = loadImage("bg1.png");
  wallImg = loadImage("wall.png");
  t1 = new Tank();
  p1 = new PowerUp();
  bombs = new ArrayList<Bomb>();
  bullets = new ArrayList<Bullet>();
  obstacles = new ArrayList<Obstacle>();
  h1 = new Heart(random(50, 450), random(50, 450), 40, 40, 20);

  for (int i = 0; i < 5; i++) {
    obstacles.add(new Obstacle(random(50, 450), random(50, 450)));
  }
}

void draw() {
  if (bg1 != null) background(bg1);
  else background(50);

  if (t1.health > 0) {
    t1.display();

    // Spawn Bombs
    if (frameCount % 40 == 0) {
      bombs.add(new Bomb(random(width), -50, 60, 60, 20, random(2, 5)));
    }

    // Spawn Obstacles
    if (frameCount % 600 == 0) {
      obstacles.add(new Obstacle(random(50, 450), random(50, 450)));
    }

    // Bullet Logic
    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.move();
      b.display();
      boolean bulletRemoved = false;
      for (int j = bombs.size() - 1; j >= 0; j--) {
        if (dist(b.x, b.y, bombs.get(j).x, bombs.get(j).y) < 30) {
          bombs.remove(j);
          bulletRemoved = true;
          break;
        }
      }
      if (!bulletRemoved) {
        for (int k = obstacles.size() - 1; k >= 0; k--) {
          if (dist(b.x, b.y, obstacles.get(k).x, obstacles.get(k).y) < 25) {
            obstacles.remove(k);
            bulletRemoved = true;
            break;
          }
        }
      }
      if (bulletRemoved || b.y < 0 || b.y > height || b.x < 0 || b.x > width) bullets.remove(i);
    }

    // Bomb Logic
    for (int i = bombs.size() - 1; i >= 0; i--) {
      Bomb b = bombs.get(i);
      b.move();
      b.display(t1.bombImg);
      if (t1.hitBomb(b)) {
        t1.health -= b.val;
        bombs.remove(i);
      } else if (b.y > height + 50) bombs.remove(i);
    }

    // Obstacle Logic
    for (Obstacle obs : obstacles) {
      obs.display(wallImg);
      if (dist(t1.x, t1.y, obs.x, obs.y) < (t1.w/2 + obs.w/2 - 10)) {
        if (t1.idir == 'w') t1.y += t1.speed;
        if (t1.idir == 's') t1.y -= t1.speed;
        if (t1.idir == 'a') t1.x += t1.speed;
        if (t1.idir == 'd') t1.x -= t1.speed;
      }
    }

    // Heart Logic
    h1.display(t1.heartImg);
    if (t1.hitHeart(h1)) {
      t1.health += h1.val;
      h1.reset();
    }

    // PowerUp Logic
    p1.display();
    if (p1.checkCollision(t1.x, t1.y, t1.w)) {
      t1.boostSpeed();
    }
    if (frameCount % 600 == 0 && !p1.active) p1.reset(); // Respawn every 10 seconds if gone

    fill(255);
    textSize(20);
    text("Health: " + (int)t1.health, 20, 30);

    // UI Feedback: Show "BOOST!" if speed is high
    if (t1.speed > t1.baseSpeed) {
      fill(0, 255, 0);
      text("SPEED BOOST ACTIVE!", 20, 60);
    }
  } else {
    background(0);
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(40);
    text("GAME OVER", width/2, height/2);
  }
}

void keyPressed() {
  t1.move(key);
}
void mousePressed() {
  bullets.add(new Bullet(t1.x, t1.y, t1.idir));
}
