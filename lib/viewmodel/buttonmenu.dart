import 'package:flutter/material.dart';

class ButtonMenu extends StatelessWidget {
  final VoidCallback? action;
  final String text;
  const ButtonMenu({super.key, required this.text, required this.action});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: action,
        child: Text(text),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.only(
            top: 30,
            bottom: 30,
            left: MediaQuery.of(context).size.height * 0.20,
            right: MediaQuery.of(context).size.height * 0.20,
          )),
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
        ),
      ),
    );
  }
}
