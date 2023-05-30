//necesitamos saber cual es el tipo de la pieza

import 'dart:ui';

import 'package:tetris/board.dart';

import 'values.dart';

class Piece {
  Tetromino type;

  Piece({required this.type});

  //las piezas seran una lista de numeros enteros

  List<int> position = [];

  //MI CLASE DE COLOR DE CADA PIEZA
  //cualquier motivo volveremos al blanco

  Color get color {
    return tetrominoColors[type] ??
        const Color(0xFFFFFFFF); // default to white if no color is found
  }

  //generamos los numeros
  //creare un metodo
  void initializePiece() {
    //si la pieza es L
    //entonces dibujamos la L digamos en el tablero de numeros
    //en este caso es 4 14 24 25 y hacemos una L

    switch (type) {
      case Tetromino.L:
        position = [
          -26, //para que caigan y se vea el efecto que vienen como de arriba utilizamos el -, hacer pruebas
          -16,
          -6,
          -5,
        ];
        break;

      //figura J

      case Tetromino.J:
        position = [
          -25, //para que caigan y se vea el efecto que vienen como de arriba utilizamos el -, hacer pruebas
          -15,
          -5,
          -6,
        ];
        break;

      // figura I

      case Tetromino.I:
        position = [
          -4, //para que caigan y se vea el efecto que vienen como de arriba utilizamos el -, hacer pruebas
          -5,
          -6,
          -7,
        ];
        break;

      //figura O CUADRADO

      case Tetromino.O:
        position = [
          -15, //para que caigan y se vea el efecto que vienen como de arriba utilizamos el -, hacer pruebas
          -16,
          -5,
          -6,
        ];
        break;

      //figura S

      case Tetromino.S:
        position = [
          -15, //para que caigan y se vea el efecto que vienen como de arriba utilizamos el -, hacer pruebas
          -14,
          -6,
          -5,
        ];
        break;

      case Tetromino.O:
        position = [
          -15, //para que caigan y se vea el efecto que vienen como de arriba utilizamos el -, hacer pruebas
          -16,
          -5,
          -6,
        ];
        break;

      case Tetromino.O:
        position = [
          -15, //para que caigan y se vea el efecto que vienen como de arriba utilizamos el -, hacer pruebas
          -16,
          -5,
          -6,
        ];
        break;

      case Tetromino.Z:
        position = [
          -17, //para que caigan y se vea el efecto que vienen como de arriba utilizamos el -, hacer pruebas
          -16,
          -6,
          -5,
        ];
        break;

      case Tetromino.T:
        position = [
          -26, //para que caigan y se vea el efecto que vienen como de arriba utilizamos el -, hacer pruebas
          -16,
          -6,
          -15,
        ];
        break;

      default:
    }
  }

  //nuestro metodo para las piezas que se moveran, movimiento de las  fichas

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down: //el primer caso es si baja
        for (int i = 0; i < position.length; i++) {
          //un bucle a traves de todos los enteros de nuestra lista
          position[i] += rowLength;
        }
        break;

      case Direction.left: //en este caso si va a la izquierda
        for (int i = 0; i < position.length; i++) {
          //un bucle a traves de todos los enteros de nuestra lista como se mueve a la izquiera lo vamos a restar
          position[i] -= 1;
        }
        break;

      case Direction.right: //el primer caso es si baja
        for (int i = 0; i < position.length; i++) {
          //un bucle a traves de todos los enteros de nuestra lista
          position[i] += 1;
        }
        break;

      default:
    }
  }

  //rotate piece, rotacion   vamos a hacer que se mueva en los cuatrossentidos como si fuera las agujas del reloj

  int rotationState = 1;

  void rotatePiece() {
    List<int> newPosition = [];

    // rotate the piece based on its type

    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:

            //obtenemos la nueva position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 1

          case 1:

            //obtenemos la nueva position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 2

          case 2:

            //obtenemos la nueva position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:

            //obtenemos la nueva position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = 0;
            }
            break;
        }
        break;

      // letra J

      case Tetromino.J:
        switch (rotationState) {
          case 0:

            //obtenemos la nueva position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 1

          case 1:

            //obtenemos la nueva position
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 2

          case 2:

            //obtenemos la nueva position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:

            //obtenemos la nueva position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = 0;
            }
            break;
        }

        break;

      //FIGURA I

      case Tetromino.I:
        switch (rotationState) {
          case 0:

            //obtenemos la nueva position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 1

          case 1:

            //obtenemos la nueva position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 2

          case 2:

            //obtenemos la nueva position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:

            //obtenemos la nueva position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = 0;
            }
            break;
        }

        break;

      case Tetromino.S:
        switch (rotationState) {
          case 0:

            //obtenemos la nueva position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 1

          case 1:

            //obtenemos la nueva position
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 2

          case 2:

            //obtenemos la nueva position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] - rowLength
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:

            //obtenemos la nueva position
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = 0;
            }
            break;
        }

        break;

      //figura  Z

      case Tetromino.Z:
        switch (rotationState) {
          case 0:

            //obtenemos la nueva position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 1

          case 1:

            //obtenemos la nueva position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 2

          case 2:

            //obtenemos la nueva position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:

            //obtenemos la nueva position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = 0;
            }
            break;
        }

        break;

      // figura T

      case Tetromino.T:
        switch (rotationState) {
          case 0:

            //obtenemos la nueva position
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 1

          case 1:

            //obtenemos la nueva position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          //case 2

          case 2:

            //obtenemos la nueva position
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:

            //obtenemos la nueva position
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];

            //update position cargamos la posision
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              //update rotate state
              rotationState = 0;
            }
            break;
        }

        break;

      //aca va el tetromino I TERMINARLO

      default:
    }
  }

  //METODO PARA VERIFICAR LA POSICION SI ESTA VALIDA
  //obtenemos la fila y la columna la posicion

  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    //si la posicion esta tomada devolvemos false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }

    //si la posicion es valida retornamos true
    else {
      return true;
    }
  }

  // check if piece is valid position

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      //return false if any position is already taken

      if (!positionIsValid(pos)) {
        return false;
      }

      //obtenemos la posicion de las columnas

      int col = pos % rowLength;

      //verificamos si la cutlima columna esta ocupada

      if (col == 0) {
        firstColOccupied = true;
      }

      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    return !(firstColOccupied && lastColOccupied);
  }
}
