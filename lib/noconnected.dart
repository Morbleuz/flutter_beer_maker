import 'package:flutter/material.dart';

class NoConnected extends StatelessWidget {
  const NoConnected({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text('Impossible d\'établir une communication avec l\'api')
        ],
      ),
    );
  }
}
