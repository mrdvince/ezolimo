import 'package:flutter/material.dart';

class GptDavinciEngine extends StatelessWidget {
  const GptDavinciEngine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'About pathogen',
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        Text(
          'Causes of pathogen',
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        Text(
          'Treatment of pathogen',
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
