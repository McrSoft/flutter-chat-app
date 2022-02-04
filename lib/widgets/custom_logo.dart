import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final AssetImage imagen;
  final String titulo;

  const CustomLogo({Key? key, required this.imagen, required this.titulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Image(image: this.imagen),
            SizedBox(height: 5),
            Text(this.titulo, style: TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}
