import 'package:flutter/material.dart';

class ButonAzul extends StatelessWidget {
  final String text;
  final Function() onPressed;

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.blue,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );

  ButonAzul({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: raisedButtonStyle,
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        child: Center(
          child: Text(this.text),
        ),
      ),
    );
  }
}
