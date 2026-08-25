// =============================================
//   Plantilla Arduino para controles analógicos
//   Compatible con el juego Duel Shooter en Processing
// =============================================


#define sensorMovimiento1 A0
#define sensorAccion1     A1
#define sensorMovimiento2 A2
#define sensorAccion2     A3

// Variables para almacenar lecturas
int mov1 = 0;
int accion1 = 0;
int mov2 = 0;
int accion2 = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  // Leer los valores de los sensores (0–1023)
  mov1 = analogRead(sensorMovimiento1);
  accion1 = analogRead(sensorAccion1);
  mov2 = analogRead(sensorMovimiento2);
  accion2 = analogRead(sensorAccion2);

  // --- Dependiente de los valores del sensor es necesario hacer una calibración de rangos ---
  // mov1 = map(mov1, 200, 800, 0, 1023);
  // mov2 = map(mov2, 150, 850, 0, 1023);
  // accion1 = constrain(accion1, 0, 1023);
  // accion2 = constrain(accion2, 0, 1023);

  // Enviar datos en formato compatible con Processing:
  // mov1,accion1,mov2,accion2
  Serial.print(mov1);
  Serial.print(",");
  Serial.print(accion1);
  Serial.print(",");
  Serial.print(mov2);
  Serial.print(",");
  Serial.println(accion2);

  delay(50); // tiempo entre envíos
}
