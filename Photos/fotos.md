Documentación del montaje físico

Esta sección documenta el montaje físico del prototipo de controles desarrollado alrededor de un Arduino Uno. Las fotografías muestran los componentes utilizados, el cableado y la distribución sobre una base de madera.

El sistema está compuesto principalmente por:

1 Arduino Uno.
2 potenciómetros rotatorios B1K.
2 módulos de botón.
2 LEDs indicadores.
Resistencias para los LEDs.
Cables con conectores.
Termorretráctil.
Base de madera contrachapada.

Los dos controles físicos proporcionan las entradas que posteriormente son procesadas por el Arduino.

1. LED verde




La primera fotografía muestra un LED verde utilizado como salida visual del circuito.

Se observa:

El ánodo del LED conectado mediante un cable negro protegido con termorretráctil.
El cátodo conectado a una resistencia.
La resistencia conectada posteriormente a un cable violeta.
El conjunto fijado sobre la base de madera mediante pegamento caliente.

La resistencia se utiliza para limitar la corriente que atraviesa el LED y protegerlo.

2. LED rojo




La segunda fotografía muestra el LED rojo, utilizado como segunda salida visual del prototipo.

El cátodo se encuentra conectado a un cable naranja/rojo con una sección protegida mediante termorretráctil.

Al fondo se observa el Arduino Uno, que centraliza las conexiones del sistema.

Los LEDs permiten utilizar señales luminosas como indicadores del estado del circuito o de determinadas acciones.

3. Potenciómetro B1K




Esta fotografía muestra uno de los potenciómetros rotatorios B1K utilizados como entrada analógica.

El componente posee tres terminales conectados mediante cables con conectores hembra. Las conexiones están protegidas con termorretráctil.

El potenciómetro funciona como un dispositivo de entrada variable. Al girarlo, cambia el valor de la señal analógica que recibe Arduino.

En el contexto del proyecto, este tipo de entrada permite representar el movimiento de la paleta del jugador.

4. Segundo potenciómetro




La cuarta fotografía muestra el segundo potenciómetro B1K.

Se observa claramente el vástago metálico utilizado para girar físicamente el componente.

Este segundo potenciómetro corresponde a la entrada de movimiento del otro jugador, permitiendo que ambos jugadores dispongan de un control físico independiente.

5. Botón rojo




La quinta fotografía muestra el módulo del botón rojo.

El módulo presenta tres conexiones:

VCC
OUT
GND

Estas conexiones permiten alimentar el módulo y obtener una señal de salida cuando se acciona el botón.

En el sistema, este tipo de entrada se utiliza como una acción del jugador, asociada al disparo.

También se observa parte del cableado y una resistencia utilizada en el montaje.

6. Botón verde




El sexto registro muestra el segundo módulo de botón, identificado por su color verde.

Al igual que el botón rojo, dispone de:

VCC
OUT
GND

Este botón constituye la segunda entrada de acción del sistema y permite que el segundo jugador disponga de su propio control de disparo.

7. Arduino Uno




La séptima fotografía muestra el Arduino Uno, que funciona como el punto central de conexión del prototipo.

Se observan los grupos de pines:

Digitales 0–13.
Analógicos A0–A5.
Alimentación y conexiones auxiliares.

Los cables provenientes de los diferentes componentes convergen en la placa.

En la configuración documentada, Arduino recibe las señales correspondientes a los dos jugadores y posteriormente transmite los datos al ordenador mediante comunicación serie.

El cable USB todavía no está conectado en esta fotografía.

8. Distribución de componentes




La octava fotografía permite observar la distribución general de los componentes.

Se identifican:

LED rojo.
LED verde.
Botón rojo.
Potenciómetro.
Arduino Uno.
Cableado de interconexión.

Esta vista permite apreciar cómo los diferentes componentes están distribuidos físicamente sobre la base.

9. Vista general del montaje




En esta fotografía aparecen conjuntamente:

Los dos potenciómetros.
Los dos botones.
Los LEDs.
El Arduino Uno.
El cableado completo.

Los componentes se encuentran conectados mediante cables individuales que convergen hacia el Arduino.

Esta etapa corresponde al montaje físico del prototipo antes de su organización definitiva.

10. Vista cenital




La décima fotografía muestra el proyecto completo desde una vista superior.

El Arduino Uno se encuentra aproximadamente en el centro de la base de madera, mientras que los controles y LEDs están distribuidos alrededor de él.

La disposición permite identificar visualmente la separación entre los componentes correspondientes a cada parte del sistema.

En esta fotografía el USB todavía no está conectado, por lo que el Arduino no está recibiendo alimentación desde el ordenador.

11. Sistema energizado




La última fotografía muestra el prototipo con el cable USB conectado al Arduino Uno.

El LED de alimentación (Power) de la placa se encuentra encendido, indicando que el Arduino está recibiendo energía.

Esta fotografía documenta el estado del montaje una vez conectado físicamente al ordenador.

Es importante diferenciar esta evidencia de la prueba funcional completa: el LED de alimentación demuestra que la placa está energizada, mientras que el video del proyecto constituye la evidencia de la interacción funcional del sistema.

12. Distribución funcional

De acuerdo con el montaje y el código utilizado, los componentes se organizan conceptualmente de la siguiente manera:

Componente	Función
Potenciómetro 1	Movimiento Jugador 1
Botón 1	Acción Jugador 1
Potenciómetro 2	Movimiento Jugador 2
Botón 2	Acción Jugador 2
LED rojo	Indicador visual
LED verde	Indicador visual
Arduino Uno	Recepción y procesamiento de entradas

Las señales de los dos controles llegan al mismo Arduino Uno.

┌───────────────────┐
│    CONTROL J1     │
│ Potenciómetro     │
│ Botón             │
└─────────┬─────────┘
          │
          │
          ▼
     ┌───────────┐
     │           │
     │  ARDUINO  │
     │    UNO    │
     │           │
     └─────┬─────┘
           │
           │ USB / Serial
           ▼
      ┌──────────┐
      │ Processing│
      │   Pong   │
      └──────────┘
           
          ▲
          │
          │
┌─────────┴─────────┐
│    CONTROL J2     │
│ Potenciómetro     │
│ Botón             │
└───────────────────┘

Los LEDs funcionan como salidas visuales independientes del sistema y sirven como indicadores del estado o de determinadas acciones del prototipo.

13. Estado del montaje

Las fotografías corresponden a un prototipo físico funcional en proceso de documentación y replicación.

El montaje presenta un cableado provisional, con conexiones aéreas, termorretráctil y fijaciones mediante pegamento caliente. Esta construcción resulta apropiada para una etapa de prototipado, aunque no representa necesariamente una implementación final.

Para una futura revisión del hardware sería recomendable:

Organizar el cableado.
Utilizar una protoboard o PCB.
Asegurar las conexiones.
Evitar cables sometidos a tensión.
Proteger las uniones expuestas.
Mejorar la fijación mecánica de los componentes.

Estas mejoras reducirían la posibilidad de falsos contactos y facilitarían el mantenimiento del sistema.

14. Relación con el juego

El montaje físico constituye la interfaz de entrada del proyecto.

El funcionamiento completo es:

Jugador 1 ──┐
            │
            ▼
         Arduino Uno
            ▲
            │
Jugador 2 ──┘
            │
            ▼
      Comunicación serie
            │
            ▼
        Processing
            │
            ▼
       Juego de Pong

Los potenciómetros proporcionan los valores utilizados para controlar el movimiento de las paletas, mientras que los botones proporcionan las acciones de disparo.

De esta forma, el prototipo transforma controles físicos en entradas para el videojuego.

Evidencia

Las fotografías documentan principalmente:

Los componentes utilizados.
El cableado.
La distribución física.
La conexión de los controles al Arduino.
El estado energizado del prototipo.

El video de prueba complementa esta documentación al mostrar el funcionamiento del sistema durante una ejecución real del proyecto.
