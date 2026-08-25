# Documentación del montaje físico

Esta sección documenta el montaje físico del prototipo de controles desarrollado alrededor de un **Arduino Uno**. Las fotografías muestran los componentes utilizados, el cableado y la distribución sobre una base de madera.

El sistema está compuesto principalmente por:

- 1 Arduino Uno.
- 2 potenciómetros rotatorios B1K.
- 2 módulos de botón.
- 2 LEDs indicadores.
- Resistencias para los LEDs.
- Cables con conectores.
- Termorretráctil.
- Base de madera contrachapada.

Los dos controles físicos proporcionan las entradas que posteriormente son procesadas por el Arduino.

---

## 1. LED verde

La primera fotografía muestra un **LED verde** utilizado como salida visual del circuito.

Se observa:

- El ánodo del LED conectado mediante un cable negro protegido con termorretráctil.
- El cátodo conectado a una resistencia.
- La resistencia conectada posteriormente a un cable violeta.
- El conjunto fijado sobre la base de madera mediante pegamento caliente.

La resistencia se utiliza para limitar la corriente que atraviesa el LED y protegerlo.

---

## 2. LED rojo

La segunda fotografía muestra el **LED rojo**, utilizado como segunda salida visual del prototipo.

El cátodo se encuentra conectado a un cable naranja/rojo con una sección protegida mediante termorretráctil.

Al fondo se observa el Arduino Uno, que centraliza las conexiones del sistema.

Los LEDs permiten utilizar señales luminosas como indicadores del estado del circuito o de determinadas acciones.

---

## 3. Potenciómetro B1K

Esta fotografía muestra uno de los **potenciómetros rotatorios B1K** utilizados como entrada analógica.

El componente posee tres terminales conectados mediante cables con conectores hembra. Las conexiones están protegidas con termorretráctil.

El potenciómetro funciona como un dispositivo de entrada variable. Al girarlo, cambia el valor de la señal analógica que recibe Arduino.

En el contexto del proyecto, este tipo de entrada permite representar el movimiento de la paleta del jugador.

---

## 4. Segundo potenciómetro

La cuarta fotografía muestra el segundo potenciómetro B1K.

Se observa claramente el vástago metálico utilizado para girar físicamente el componente.

Este segundo potenciómetro corresponde a la entrada de movimiento del otro jugador, permitiendo que ambos jugadores dispongan de un control físico independiente.

---

## 5. Botón rojo

La quinta fotografía muestra el módulo del **botón rojo**.

El módulo presenta tres conexiones:

```text
VCC
OUT
GND
