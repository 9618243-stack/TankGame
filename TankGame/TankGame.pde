// Lucy Kleven | Tank Game | April 1, 2026
Heart h1;
PowerUp p1;
PImage bg1, wallImg, ammoImg; 
Tank t1;
ArrayList<Bomb> bombs;
ArrayList<Bullet> bullets;
ArrayList<Obstacle> obstacles;
ArrayList<AmmoBox> ammoBoxes; // Added list for dropped ammo

void setup() {
  size(500, 500);
  bg1 = loadImage("bg1.png");
  wallImg = loadImage("wall.png");
  ammoImg = loadImage("ammo.png"); // Load ammo image
  t1 = new Tank();
  p1 = new PowerUp();
  bombs = new ArrayList<Bomb>();
  bullets = new ArrayList<Bullet>();
  obstacles = new ArrayList<Obstacle>();
  ammoBoxes = new ArrayList<AmmoBox>(); // Initialize ammo list
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

    if (frameCount % 40 == 0) {
      bombs.add(new Bomb(random(width), -50, 60, 60, 20, random(2, 5)));
    }
    
    if (frameCount % 600 == 0) {
      obstacles.add(new Obstacle(random(50, 450), random(50, 450)));
    }

    // Bullet & Collision Logic
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
            // Drop ammo box when wall is shot
            ammoBoxes.add(new AmmoBox(obstacles.get(k).x, obstacles.get(k).y));
            obstacles.remove(k);
            bulletRemoved = true;
            break;
          }
        }
      }

      if (bulletRemoved || b.y < 0 || b.y > height || b.x < 0 || b.x > width) 
        bullets.remove(i);
    }

    // Ammo Box Collection Logic
    for (int i = ammoBoxes.size() - 1; i >= 0; i--) {
      AmmoBox ab = ammoBoxes.get(i);
      ab.display(ammoImg);
      if (ab.checkCollision(t1.x, t1.y, t1.w)) {
        t1.ammo += 10; // Gain 10 ammo per box
        ammoBoxes.remove(i);
      }
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

    // Obstacle Wall Logic
    for (Obstacle obs : obstacles) {
      obs.display(wallImg);
      if (dist(t1.x, t1.y, obs.x, obs.y) < (t1.w/2 + obs.w/2 - 10)) {
        if (t1.idir == 'w') t1.y += t1.speed;
        if (t1.idir == 's') t1.y -= t1.speed;
        if (t1.idir == 'a') t1.x += t1.speed;
        if (t1.idir == 'd') t1.x -= t1.speed;
      }
    }

    h1.display(t1.heartImg);
    if (t1.hitHeart(h1)) {
      t1.health += h1.val;
      h1.reset();
    }

    p1.display();
    if (p1.checkCollision(t1.x, t1.y, t1.w)) {
      t1.boostSpeed();
    }
    if (frameCount % 600 == 0 && !p1.active) p1.reset();

    // UI Feedback
    fill(255);
    textSize(20);
    text("Health: " + (int)t1.health, 20, 30);
    text("Ammo: " + t1.ammo, 20, 60); // Show Ammo on screen
    if (t1.speed > t1.baseSpeed) {
      fill(0, 255, 0);
      text("SPEED BOOST ACTIVE!", 20, 90);
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
  if (t1.ammo > 0) { // Only fire if there is ammo
    bullets.add(new Bullet(t1.x, t1.y, t1.idir));
    t1.ammo--; 
  }
}
