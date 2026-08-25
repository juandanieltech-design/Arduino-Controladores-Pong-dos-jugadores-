# Pong — Processing

Implementación de un juego de **Pong para dos jugadores**, controlado mediante los dos controles físicos conectados al Arduino Uno.

El programa recibe mediante comunicación serie los valores enviados por Arduino y los utiliza para controlar el movimiento de las paletas y activar los disparos.

## Funciones principales

* Pong para 2 jugadores.
* Control de las paletas mediante potenciómetros.
* Disparos mediante los botones de acción.
* Hasta **4 pelotas simultáneas**.
* Rebotes contra paredes y paletas.
* Sistema de puntuación.
* **+1 punto** cuando una pelota atraviesa el lado contrario.
* **+5 puntos** cuando un disparo impacta al jugador contrario.
* Victoria al alcanzar **100 puntos**.
* Reinicio mediante la tecla `R`.
* Comunicación serie a **9600 baudios**.

## Comunicación con Arduino

El programa utiliza la librería:

```java
import processing.serial.*;
```

Arduino envía los datos en formato CSV:

```text
mov1,accion1,mov2,accion2
```

Processing recibe estos datos mediante `serialEvent()` y los convierte en valores numéricos.

### Movimiento

Los valores de los potenciómetros, comprendidos entre `0` y `1023`, se transforman en posiciones verticales dentro de la ventana:

```java
p1Y = map(mov1, 0, 1023, height - playerH, 0);
p2Y = map(mov2, 0, 1023, height - playerH, 0);
```

De esta manera:

* `mov1` controla la paleta del Jugador 1.
* `mov2` controla la paleta del Jugador 2.

### Disparos

Los botones de acción utilizan un umbral de `500`.

Cuando:

```text
accion1 > 500
```

se genera un disparo del Jugador 1.

Cuando:

```text
accion2 > 500
```

se genera un disparo del Jugador 2.

Cada jugador puede tener un único disparo activo simultáneamente.

## Pelotas

El juego utiliza un máximo de **4 pelotas** mediante arreglos independientes para almacenar:

* Posición `X`.
* Posición `Y`.
* Velocidad horizontal.
* Velocidad vertical.

Las pelotas rebotan contra el techo, el suelo y las paletas.

Cuando una pelota abandona completamente el campo por uno de los lados, se registra un punto y la pelota vuelve a aparecer en el centro.

## Disparos

Los proyectiles se desplazan horizontalmente:

* Jugador 1 → hacia la derecha.
* Jugador 2 → hacia la izquierda.

Si un disparo impacta la paleta contraria, el jugador que disparó obtiene **5 puntos**.

Los disparos también pueden interactuar con las pelotas y provocar su reinicio.

## Sistema de puntuación

| Evento                                |    Resultado |
| ------------------------------------- | -----------: |
| Pelota sale por el lado del Jugador 1 | Jugador 2 +1 |
| Pelota sale por el lado del Jugador 2 | Jugador 1 +1 |
| Disparo impacta al Jugador 2          | Jugador 1 +5 |
| Disparo impacta al Jugador 1          | Jugador 2 +5 |

El límite de victoria está definido mediante:

```java
final int GOAL_LIMIT = 100;
```

Al alcanzar los 100 puntos, se muestra el jugador ganador y el juego se detiene.

Para comenzar una nueva partida:

```text
R
```

## Configuración del puerto serie

En `setup()` se obtiene la lista de puertos disponibles:

```java
println(Serial.list());
```

y posteriormente se selecciona el puerto utilizado por Arduino:

```java
myPort = new Serial(this, Serial.list()[1], 9600);
```

El índice `Serial.list()[1]` puede variar dependiendo del ordenador y de los dispositivos conectados. Si Arduino aparece en otro índice, debe modificarse este valor.

## Flujo del sistema

```text
Control Jugador 1 ─┐
                   │
Control Jugador 2 ─┤
                   ▼
              Arduino Uno
                   │
                   │ USB / Serial
                   │ 9600 baud
                   ▼
               Processing
                   │
                   ▼
              Juego Pong
```

Los **dos controles están conectados al Arduino Uno**. Processing no recibe directamente los controles: recibe los datos de ambos jugadores enviados por Arduino.

## Archivo

El código de este juego se encuentra en:

```text
Processing/JuegoPongMultiple.pde
```

## Tecnologías

* Processing
* Java
* Arduino Uno
* Comunicación serie
* Librería `processing.serial`

