# Arduino Pong Controller

Proyecto de desarrollo de **dos controles físicos independientes para un juego de Pong**, utilizando un **Arduino Uno** como interfaz entre los controles y el juego ejecutado en **Processing**.

Cada jugador dispone de un control con dos funciones principales:

* **Movimiento vertical:** permite controlar la posición de la paleta en el eje Y.
* **Acción de disparo:** permite lanzar un proyectil que puede otorgar puntos adicionales al impactar al oponente.

El sistema integra electrónica, programación de Arduino, comunicación serie y una interfaz física diseñada para ser utilizada por dos jugadores.

---

## 1. Objetivo

Desarrollar dos controles físicos independientes, conectados a un único Arduino Uno, capaces de controlar las paletas de dos jugadores dentro de un juego de Pong desarrollado en Processing.

Cada control dispone de:

* Un sensor de movimiento para controlar la posición vertical de la paleta.
* Un pulsador para ejecutar la acción de disparo.

El Arduino recibe las señales de ambos controles y transmite la información mediante comunicación serie al programa de Processing.

---

## 2. Arquitectura del sistema

El Arduino Uno funciona como **interfaz entre los controles físicos y el juego**.

```text
┌──────────────────────┐
│   Control Jugador 1  │
│                      │
│  Potenciómetro       │
│  Pulsador            │
└──────────┬───────────┘
           │
           │
           ▼
     ┌─────────────┐
     │             │
     │ Arduino Uno │
     │             │
     │ A0 → Mov. 1 │
     │ A1 → Acc. 1 │
     │ A2 → Mov. 2 │
     │ A3 → Acc. 2 │
     │             │
     └──────┬──────┘
            │
            │ USB / Puerto Serie
            │ 9600 baud
            ▼
┌───────────────────────────┐
│        Processing         │
│                           │
│       Juego de Pong       │
│                           │
│ Recibe los datos de ambos │
│ controles y actualiza las │
│ acciones de los jugadores │
└───────────────────────────┘
            ▲
            │
            │
┌───────────┴───────────────┐
│     Control Jugador 2     │
│                           │
│     Potenciómetro         │
│     Pulsador              │
└───────────────────────────┘
```

El flujo de información es:

```text
Controles físicos
       ↓
   Arduino Uno
       ↓
 Comunicación serie
       ↓
    Processing
       ↓
     Juego
```

---

## 3. Materiales utilizados

### Electrónica

* **1 × Arduino Uno** o placa compatible.
* **4 × sensores**, dos por jugador:

  * 2 potenciómetros para el movimiento.
  * 2 pulsadores para la acción.
* Cables de conexión.
* Protoboard.

### Estructura física

* Carcasa o cerramiento para cada control.
* Cableado con una longitud aproximada de **1.5 m** para permitir separación entre jugadores.
* Diseño físico basado en los bocetos y modelado del proyecto.

### Software

* Arduino IDE.
* Processing.
* PC para ejecutar el juego.

---

## 4. Esquema de conexiones

Los cuatro sensores se conectan al Arduino Uno de la siguiente manera:

| Función              | Pin Arduino |
| -------------------- | ----------: |
| Movimiento Jugador 1 |        `A0` |
| Acción Jugador 1     |        `A1` |
| Movimiento Jugador 2 |        `A2` |
| Acción Jugador 2     |        `A3` |

### Potenciómetros

Los potenciómetros funcionan como sensores de posición.

Su terminal central se conecta al pin analógico correspondiente, mientras que los extremos se conectan a `5V` y `GND`.

```text
          5V
           │
           │
      ┌────┴────┐
      │         │
      │   POT   │
      │         │
      └────┬────┘
           │
           └──────→ Pin analógico
           │
          GND
```

La lectura analógica del Arduino se encuentra normalmente entre:

```text
0 ───────────────────────── 1023
```

### Pulsadores

Los pulsadores corresponden a las entradas de acción de cada jugador.

La conexión contempla una configuración con resistencia de polarización (`pull-up` o `pull-down`) para mantener un estado estable de la entrada.

En la implementación utilizada para este proyecto, los botones pueden leerse mediante entradas analógicas, produciendo valores cercanos a:

```text
0       → Estado bajo
1023    → Estado alto
```

También es posible adaptar la implementación para utilizar entradas digitales mediante `digitalRead()`.

---

## 5. Código Arduino

El código utilizado para el Arduino se encuentra en:

```text
Arduino/EjemploControlMovimientoAccionArduino.ino
```

El sketch realiza las siguientes funciones:

1. Inicializa la comunicación serie.
2. Lee los cuatro sensores.
3. Obtiene los valores de movimiento y acción.
4. Envía los valores mediante el puerto serie.
5. Repite el proceso aproximadamente cada 50 ms.

La velocidad de comunicación utilizada es:

```text
9600 baudios
```

### Formato de datos

Arduino transmite los cuatro valores en formato CSV:

```text
mov1,accion1,mov2,accion2
```

Por ejemplo:

```text
512,0,768,1023
```

Donde:

| Valor     | Descripción              |
| --------- | ------------------------ |
| `mov1`    | Movimiento del jugador 1 |
| `accion1` | Acción del jugador 1     |
| `mov2`    | Movimiento del jugador 2 |
| `accion2` | Acción del jugador 2     |

El intervalo de lectura utilizado en el sketch es aproximadamente:

```cpp
delay(50);
```

---

## 6. Juego de Pong en Processing

El proyecto utiliza un juego de Pong desarrollado en Processing.

El código correspondiente se encuentra en:

```text
Processing/JuegoPongMultiple.pde
```

El programa recibe mediante comunicación serie los valores enviados por el Arduino y utiliza estos datos para controlar las acciones de los dos jugadores.

### Movimiento de las paletas

Los valores `mov1` y `mov2` se utilizan para determinar la posición vertical de las paletas.

El rango analógico:

```text
0 ─────────────── 1023
```

se transforma mediante `map()` al rango vertical disponible en la ventana del juego.

De esta manera, el jugador puede controlar la paleta moviendo físicamente el potenciómetro.

### Disparos

Los valores correspondientes a las acciones se comparan con un umbral:

```text
accion1 > 500
accion2 > 500
```

Cuando se supera este valor, se activa el disparo correspondiente.

El proyectil se desplaza horizontalmente desde la paleta del jugador hacia el lado contrario.

---

## 7. Sistema de puntuación

El juego incorpora dos formas principales de obtener puntos.

| Evento                           | Puntos |
| -------------------------------- | -----: |
| La pelota atraviesa el borde     |     +1 |
| Un proyectil impacta al oponente |     +5 |

El objetivo es alcanzar **100 puntos**.

Cuando uno de los jugadores alcanza esta cantidad, el juego muestra el resultado correspondiente y detiene la ejecución.

El juego puede reiniciarse utilizando la tecla:

```text
R
```

---

## 8. Pelotas múltiples

El juego permite tener hasta **4 pelotas simultáneamente**.

Las pelotas pueden:

* Rebotar contra las paredes.
* Rebotar contra las paletas.
* Atravesar los límites del campo.
* Generar puntos al abandonar el área de juego.

La utilización de múltiples pelotas incrementa la dificultad y exige una mayor precisión por parte de ambos jugadores.

---

## 9. Funcionamiento general

El funcionamiento completo del sistema es el siguiente:

### 1. Preparación

Se conecta el Arduino Uno al ordenador mediante USB.

### 2. Arduino

Se carga el sketch:

```text
EjemploControlMovimientoAccionArduino.ino
```

El Arduino comienza a leer los cuatro sensores.

### 3. Comunicación

Arduino transmite periódicamente los datos mediante el puerto serie:

```text
mov1,accion1,mov2,accion2
```

a una velocidad de:

```text
9600 baud
```

### 4. Processing

Se ejecuta el juego de Pong en Processing.

El programa abre el puerto serie y recibe los datos enviados por el Arduino.

### 5. Controles

Cada jugador puede:

* Girar o desplazar el potenciómetro para mover su paleta.
* Presionar el pulsador para lanzar un proyectil.

### 6. Partida

El juego continúa mediante el sistema de rebotes, pelotas múltiples, disparos y puntuación hasta que uno de los jugadores alcanza los 100 puntos.

---

## 10. Calibración y ajustes

Los sensores analógicos pueden no utilizar exactamente todo el rango `0–1023`.

Por esta razón, el código Arduino contempla la posibilidad de utilizar:

* `map()`
* `constrain()`

para adaptar las lecturas de los sensores.

Por ejemplo:

```cpp
valor = map(valor, MINIMO, MAXIMO, 0, 1023);
valor = constrain(valor, 0, 1023);
```

Los valores `MINIMO` y `MAXIMO` deben determinarse experimentalmente según el sensor utilizado.

### Pulsadores

Aunque los pulsadores son dispositivos digitales, en esta implementación pueden leerse mediante las entradas analógicas para mantener una estructura uniforme con los demás sensores.

La lectura se interpreta mediante un umbral de:

```text
500
```

Por lo tanto, una lectura superior a este valor puede activar el disparo.

Otra implementación posible consiste en utilizar `digitalRead()` directamente o mantener un contador interno que represente el estado de la acción.

---

## 11. Diseño de los controles

Cada jugador dispone de un control físico independiente.

La carcasa debe integrar:

* El sensor de movimiento.
* El pulsador de acción.
* Las conexiones electrónicas necesarias.
* Una salida para el cable que conecta el control con el Arduino.

El diseño debe considerar la ergonomía para que los jugadores puedan utilizar los controles cómodamente durante una partida.

También se contempla el diseño mediante bocetos y modelado de las carcasas.

---

## 12. Resultados y pruebas

Durante las pruebas del prototipo se verificó el funcionamiento de ambos controles dentro del juego.

Los resultados registrados incluyen:

* Movimiento correcto de ambas paletas.
* Respuesta al accionamiento de los botones.
* Disparos funcionales.
* Movimiento suave de las paletas.
* Comunicación entre los controles, Arduino y Processing.
* Separación adecuada entre los jugadores mediante cables de aproximadamente 1.5 m.
* Integración de los componentes electrónicos dentro de las carcasas.

El proyecto cuenta además con **evidencia audiovisual de una prueba funcional del prototipo**.

---

## 13. Estructura del proyecto

Una estructura recomendada para este repositorio es:

```text
Arduino-Pong-Controller/
│
├── README.md
│
├── Arduino/
│   └── EjemploControlMovimientoAccionArduino.ino
│
├── Processing/
│   └── JuegoPongMultiple.pde
│
├── Documentation/
│   ├── Circuit/
│   ├── Enclosure/
│   └── Photos/
│
└── Media/
    └── Video/
```

Las fotografías, bocetos, modelados y video pueden incorporarse posteriormente a las carpetas correspondientes.

---

## 14. Estado del proyecto

**Prototipo funcional.**

El sistema fue construido y probado como parte del proyecto académico. Actualmente se está realizando un proceso de recuperación y replicación del montaje original para volver a verificar su funcionamiento con el hardware disponible.

### Funcionalidades

* [x] Dos controles físicos.
* [x] Dos jugadores.
* [x] Un Arduino Uno para ambos controles.
* [x] Lectura de sensores.
* [x] Movimiento vertical.
* [x] Acción de disparo.
* [x] Comunicación serie.
* [x] Integración con Processing.
* [x] Pelotas múltiples.
* [x] Sistema de puntuación.
* [x] Condición de victoria.
* [x] Prueba funcional del prototipo.
* [ ] Replicación completa del montaje original.
* [ ] Revisión y calibración del hardware.
* [ ] Incorporación de documentación fotográfica.
* [ ] Incorporación de evidencia audiovisual al repositorio.

---

## 15. Conclusiones

El proyecto cumple con los objetivos establecidos para el **Micro Proyecto 3 – Opción 2**, mediante la creación de dos controles físicos capaces de interactuar con un juego de Pong.

El Arduino Uno funciona como intermediario entre los sensores de ambos controles y el juego desarrollado en Processing, permitiendo transformar acciones físicas en comandos dentro del videojuego.

El proyecto permitió aplicar conceptos de:

* Lectura de sensores.
* Entradas analógicas y digitales.
* Comunicación serie.
* Arduino.
* Processing.
* Procesamiento de datos.
* Diseño de interfaces físicas.
* Prototipado electrónico.
* Diseño de carcasas.

La arquitectura también permite extender el concepto a otros juegos o sustituir los sensores utilizados por diferentes dispositivos de entrada.

---

## 16. Evidencia del proyecto

El repositorio incorporará progresivamente la documentación visual del prototipo, incluyendo:

* Fotografías del circuito.
* Fotografías de los controles.
* Diseño y bocetos de las carcasas.
* Modelado 3D.
* Capturas del juego.
* Video de la prueba funcional.

El video constituye evidencia de que el sistema llegó a funcionar como un conjunto integrado entre **controles físicos → Arduino Uno → comunicación serie → Processing**.

---

## Licencia

Este proyecto fue desarrollado con fines académicos y de aprendizaje.

La licencia del código y de los recursos del proyecto puede definirse posteriormente según las condiciones de distribución del material académico original.
