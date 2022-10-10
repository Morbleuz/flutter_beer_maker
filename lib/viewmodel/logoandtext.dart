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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Image.asset('assets/images/beermakerlogo1000.png')),
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Container(
                child: Center(
                  child: Text(
                    '${text.toUpperCase()}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
        ],
      ),
      //Fin de la ligne
    );
  }
}
