//valores constantes y comunes de la app

import 'dart:ui';

int rowLength = 10; // fila
int collength = 15; // columna

//enumeracion de piezas
//para que puedas obtener una pieza o forma de i o s o j

//creamos enumeracion para las direcciones de las fichas, en este caso
// al lado derecho, al lado izquierdo, arriba , abajo

// serian formas de L O S y asi...

enum Direction {
  left,
  right,
  down,
}

enum Tetromino { L, J, I, O, S, Z, T }

//Estos son los colores para cada figura
const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500),
  Tetromino.J: Color.fromARGB(255, 0, 182, 255),
  Tetromino.I: Color.fromARGB(255, 242, 0, 255),
  Tetromino.O: Color(0xFFFFFF00),
  Tetromino.S: Color(0xFF008000),
  Tetromino.Z: Color(0xFFFF0000),
  Tetromino.T: Color.fromARGB(255, 144, 0, 255),
};
