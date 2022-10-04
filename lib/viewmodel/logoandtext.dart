import 'package:flutter/material.dart';

class LogoAndText extends StatelessWidget {
  String text;

  LogoAndText({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
                width: 400,
                child: Image.asset('assets/images/beermakerlogo1000.png')),
          ),
          Expanded(
            flex: 2,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  '$text',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
      //Fin de la ligne
    );
  }
}
