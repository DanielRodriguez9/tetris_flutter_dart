//interfaz de usuario

import 'dart:async';
import 'dart:math';



import 'package:flutter/material.dart';
import 'package:tetris/Piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  collength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.L);

  // current score

  int currentScore = 0;

  // game over status

  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();
    Duration frameRate = const Duration(
        milliseconds:
            750); //esto es para el tiempo en que dura en caer la pieza, entre menos numero mas lennto por eso el Duration
    gameloop(frameRate);
  }

  // game loop

  void gameloop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          // clear
          clearLines();

          // check landing

          // si es game over
          if (gameOver == true) {
            timer.cancel();
            showGameOverDialog();
          }

          checkLanding();
          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('Your score is : $currentScore'),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();

              Navigator.pop(context);
            },
            child: Text("Play Again"),
          )
        ],
      ),
    );
  }

  // reset game

  void resetGame() {
    gameBoard = List.generate(
      collength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    gameOver = false;
    currentScore = 0;

    createNewPiece();

    startGame();
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= collength || col < 0 || col >= rowLength) {
        return true;
      }

      /**La condición adicional que mencionas en el código if (row >= 0 && gameBoard[row][col] != null) es necesaria para asegurar que las piezas se coloquen una sobre otra correctamente en el tablero.

Sin esa condición, el código solo verificaría si la posición de la pieza actual está fuera de los límites del tablero, pero no tomaría en cuenta si hay otra pieza ya colocada en esa posición.

Al agregar la condición gameBoard[row][col] != null, estás verificando si en la posición calculada del tablero ya existe una pieza. Si la condición se 
cumple, significa que hay una colisión entre la pieza actual y otra pieza ya colocada en el tablero, y por lo tanto, se devuelve true indicando que hay una colisión. */

      //estas lineas de codigo son fundamentales ya que hace la accion de que se sumen las piezas una sobre otra
      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }

    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] ??= currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    // si es game over

    if (isGameOver()) {
      gameOver = true;
    }
  }

  // llamamos a move left en este caso que creamos en onclick al final

  // move left

  //esto e spara mover las fichas en el celular con el teclado digamoslo asi o las flechas del celular

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // move right

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // rotate piece
  void rotatePiece() {
    //llamamos nuestro metodo de rotar la pieza que creamos en piece.dart
    currentPiece.rotatePiece();
  }

  //metodo para crear lineas claras

  //clear lineas
  void clearLines() {
    //step 1 , paso 1

    for (int row = collength - 1; row >= 0; row--) {
      //step 2 , paso 2

      bool rowIsFull = true;

      //step 3 , paso 3

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      //step 4 , paso 4 :

      if (rowIsFull) {
        //Step5

        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // step 6, paso 6
        gameBoard[0] = List.generate(row, (index) => null);

        // step 7 , paso 7
        currentScore++;
      }
    }
  }

  // GAME OVER METHOD

  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //GAME GRID
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * collength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowLength,
              ),
              itemBuilder: (context, index) {
                int row = (index / rowLength).floor();
                int col = index % rowLength;

                //current piece

                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece
                        .color, // aca llamamos nuestra funcion de colors donde cada figura tiene un color
                    // child: index,
                  );
                }

                //landed pieces
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                    color: tetrominoColors[
                        tetrominoType], //como arriba aca tambien tenemos la funcion de los colores de las figuras
                    // child: '',
                  );
                }

                //blanc pixel
                else {
                  return Pixel(
                    color: Colors.grey[900],
                    //child: index,
                  );
                }
              },
            ),
          ),

          // SCORE

          /**TextSpan es un widget utilizado en Flutter para definir segmentos de texto con diferentes estilos
           *  dentro de un widget Text.rich() o RichText. Proporciona una forma más flexible de personalizar el estilo y la apariencia del texto.

En el código que te proporcioné, utilicé TextSpan para crear dos segmentos de texto dentro del widget Text.rich().
El primer segmento muestra el puntaje con un estilo de color blanco, mientras que el segundo segmento muestra el nombre con un estilo de color azul claro.

Al utilizar Text.rich() y TextSpan, puedes combinar diferentes estilos de texto en un solo widget y personalizarlos según tus necesidades. En este caso,
se utilizó para lograr el resultado deseado de tener el nombre "Daniel Rodriguez (cryptocode)" debajo del puntaje con un color de texto diferente. */

          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Score: $currentScore\n',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: 'Created by Daniel Rodriguez (cryptocode)',
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                ],
              ),
            ),
          ),

          //  GAME CONTROLS

          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.red[500], // colores para el icono izquiera
                  icon: Icon(Icons.arrow_back_ios),
                ),

                // rotate
                IconButton(
                  onPressed: rotatePiece,
                  color: Colors.red[500], // colores para el icono de rotar
                  icon: Icon(Icons.rotate_left),
                ),

                // right
                IconButton(
                  onPressed: moveRight,
                  color: Colors.red[500], // color para el icono de derecha
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
