import processing.serial.*;
Serial myPort;

// Parámetros generales
final int playerW = 40;
final int playerH = 80;
final int PLAYER_MARGIN = 60;
final int NUM_BALLS = 4;
final int GOAL_LIMIT = 100; // puntos para ganar

float p1Y, p2Y;
int p1Score = 0;
int p2Score = 0;

// Disparos
boolean p1ShotActive = false;
boolean p2ShotActive = false;
float p1ShotX, p1ShotY;
float p2ShotX, p2ShotY;
final float SHOT_SPEED = 30;
final float SHOT_SIZE = 40; // tamaño más grande

// Pelotas
float[] ballX = new float[NUM_BALLS];
float[] ballY = new float[NUM_BALLS];
float[] ballVX = new float[NUM_BALLS];
float[] ballVY = new float[NUM_BALLS];
float ballSize = 25;

// Serial
void setup() {
  fullScreen();
  textAlign(CENTER, CENTER);
  textSize(32);
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil('\n');
  
  resetGame();
}

void resetGame() {
  p1Y = height/2 - playerH/2;
  p2Y = p1Y;
  p1Score = 0;
  p2Score = 0;

  for (int i = 0; i < NUM_BALLS; i++) {
    resetBall(i, random(1) > 0.5 ? 1 : -1);
  }

  p1ShotActive = false;
  p2ShotActive = false;
  loop();
}

void draw() {
  background(20);

  // Línea divisoria
  stroke(100);
  for (int y = 0; y < height; y += 20)
    line(width/2, y, width/2, y+10);
  noStroke();

  // Mostrar puntaje
  fill(255);
  text("Jugador 1: " + p1Score, width*0.25, 40);
  text("Jugador 2: " + p2Score, width*0.75, 40);

  // Dibujar jugadores
  fill(0, 150, 255);
  rect(PLAYER_MARGIN, p1Y, playerW, playerH);

  fill(255, 100, 0);
  rect(width - PLAYER_MARGIN - playerW, p2Y, playerW, playerH);

  // Dibujar pelotas
  fill(255);
  updateBalls();

  // Dibujar disparos
  updateShots();

  // Verificar fin del juego
  if (p1Score >= GOAL_LIMIT || p2Score >= GOAL_LIMIT) {
    fill(255, 255, 0);
    textSize(60);
    if (p1Score > p2Score) text("¡GANA JUGADOR 1!", width/2, height/2);
    else text("¡GANA JUGADOR 2!", width/2, height/2);
    textSize(32);
    text("Presiona R para reiniciar", width/2, height/2 + 60);
    noLoop();
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') resetGame();
}

void updateBalls() {
  for (int i = 0; i < NUM_BALLS; i++) {
    ballX[i] += ballVX[i];
    ballY[i] += ballVY[i];

    // Rebote con techo y suelo
    if (ballY[i] < 0 || ballY[i] > height) ballVY[i] *= -1;

    ellipse(ballX[i], ballY[i], ballSize, ballSize);

    // Colisión con jugadores (rebote)
    if (collides(ballX[i], ballY[i], PLAYER_MARGIN, p1Y, playerW, playerH)) {
      ballVX[i] = abs(ballVX[i]);
    }
    if (collides(ballX[i], ballY[i], width - PLAYER_MARGIN - playerW, p2Y, playerW, playerH)) {
      ballVX[i] = -abs(ballVX[i]);
    }

    // GOL del jugador 2 (pelota pasa detrás del jugador 1)
    if (ballX[i] < 0) {
      p2Score++;
      resetBall(i, 1);
    }
    // GOL del jugador 1 (pelota pasa detrás del jugador 2)
    if (ballX[i] > width) {
      p1Score++;
      resetBall(i, -1);
    }

    // Colisión con disparos
    if (p1ShotActive && dist(ballX[i], ballY[i], p1ShotX, p1ShotY) < ballSize/2 + SHOT_SIZE/2) {
      resetBall(i, 1);
      p1ShotActive = false;
    }
    if (p2ShotActive && dist(ballX[i], ballY[i], p2ShotX, p2ShotY) < ballSize/2 + SHOT_SIZE/2) {
      resetBall(i, -1);
      p2ShotActive = false;
    }
  }
}

void updateShots() {
  // Disparo jugador 1
  fill(0, 200, 255);
  if (p1ShotActive) {
    p1ShotX += SHOT_SPEED;
    ellipse(p1ShotX, p1ShotY, SHOT_SIZE, SHOT_SIZE);

    // Si golpea al jugador 2
    if (collides(p1ShotX, p1ShotY, width - PLAYER_MARGIN - playerW, p2Y, playerW, playerH)) {
      p1Score += 5;
      p1ShotActive = false;
    }

    // Fuera de pantalla
    if (p1ShotX > width) p1ShotActive = false;
  }

  // Disparo jugador 2
  fill(255, 150, 0);
  if (p2ShotActive) {
    p2ShotX -= SHOT_SPEED;
    ellipse(p2ShotX, p2ShotY, SHOT_SIZE, SHOT_SIZE);

    // Si golpea al jugador 1
    if (collides(p2ShotX, p2ShotY, PLAYER_MARGIN, p1Y, playerW, playerH)) {
      p2Score += 5;
      p2ShotActive = false;
    }

    // Fuera de pantalla
    if (p2ShotX < 0) p2ShotActive = false;
  }
}

void resetBall(int i, int direction) {
  ballX[i] = width / 2;
  ballY[i] = random(height * 0.2, height * 0.8);
  ballVX[i] = direction * random(5, 9);
  ballVY[i] = random(-5, 5);
}

boolean collides(float bx, float by, float rx, float ry, float rw, float rh) {
  return bx > rx && bx < rx + rw && by > ry && by < ry + rh;
}

// 🔹 Lectura serial desde Arduino
void serialEvent(Serial p) {
  String line = p.readStringUntil('\n');
  if (line == null) return;
  line = trim(line);
  String[] parts = split(line, ',');

  if (parts.length == 4) {
    try {
      int mov1 = int(parts[0]);
      int act1 = int(parts[1]);
      int mov2 = int(parts[2]);
      int act2 = int(parts[3]);

      // Movimiento
      p1Y = map(mov1, 0, 1023, height - playerH, 0);
      p2Y = map(mov2, 0, 1023, height - playerH, 0);

      // Disparos
      if (act1 > 500 && !p1ShotActive) {
        p1ShotActive = true;
        p1ShotX = PLAYER_MARGIN + playerW;
        p1ShotY = p1Y + playerH/2;
      }
      if (act2 > 500 && !p2ShotActive) {
        p2ShotActive = true;
        p2ShotX = width - PLAYER_MARGIN - playerW;
        p2ShotY = p2Y + playerH/2;
      }

    } catch (Exception e) {
      println("Error parseando datos: " + line);
    }
  }
}
