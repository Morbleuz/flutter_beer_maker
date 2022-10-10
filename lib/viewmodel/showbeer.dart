import 'package:flutter/material.dart';

class ShowBeer extends StatelessWidget {
  final beer;

  const ShowBeer({
    super.key,
    required this.beer,
  });
  Future<void> _showInformationBeer(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Information sur la bière'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () => _showInformationBeer(context),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(1, 1),
                    blurRadius: 5,
                    spreadRadius: 0)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Nom de la bière'),
                  Text('10L'),
                  Text('9 degrès')
                ]),
          ),
        ),
      ),
    );
  }
}
