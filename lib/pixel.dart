//esto sera cada cuadrado en vez de cada numero que aparece

import 'package:flutter/material.dart';

//nuestra variable color

// ignore: must_be_immutable
class Pixel extends StatelessWidget {
  var color;
  //var child;  esto era para la cuadricula

  Pixel({
    super.key,
    required this.color,
    //required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
              4)), //el border raiduus cirular es para que aprezca un cirtulo en las quinas
      //la margen de las cuadriculas
      margin: EdgeInsets.all(1),
      // child: Center(

      //cuadricula de los numeros en color blanco
      // child: Text(
      // child.toString(),
      // style: TextStyle(color: Colors.white),
      // ),
      //),
    );
  }
}
