# Arduino Controller

Código de Arduino encargado de leer los cuatro sensores correspondientes a los dos controles físicos y enviar sus valores al juego desarrollado en Processing.

## Función

El Arduino Uno recibe:

* `A0` → Movimiento Jugador 1
* `A1` → Acción Jugador 1
* `A2` → Movimiento Jugador 2
* `A3` → Acción Jugador 2

Los valores se leen mediante `analogRead()` en un rango de `0–1023`.

## Comunicación

Los datos se envían mediante el puerto serie a **9600 baudios**, utilizando el siguiente formato CSV:

```text
mov1,accion1,mov2,accion2
```

Ejemplo:

```text
512,0,768,1023
```

Processing puede utilizar estos cuatro valores para controlar las acciones de ambos jugadores.

## Calibración

El código incluye ejemplos comentados de `map()` y `constrain()` para ajustar el rango de los sensores cuando estos no utilizan todo el intervalo `0–1023`.

## Frecuencia de lectura

El Arduino realiza una nueva lectura y transmisión aproximadamente cada **50 ms** mediante `delay(50)`.

Este sketch funciona como la interfaz entre los **dos controles físicos**, el **Arduino Uno** y el juego en **Processing**.

