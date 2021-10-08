import 'package:flutter/material.dart';

class ContinueWithSocials extends StatelessWidget {
  const ContinueWithSocials({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.blue),
          child: const Center(
            child: Text(
              "Facebook",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )),
        const SizedBox(
          width: 30,
        ),
        Expanded(
            child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.blueGrey),
          child: const Center(
            child: Text(
              "Google",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )),
      ],
    );
  }
}
