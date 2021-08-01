import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AngryBird extends StatelessWidget {

  final flappyY;
  final double birdWidth;
  final double birdHeight;

  AngryBird({this.flappyY, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,(2 * flappyY+ birdHeight) / (2-birdHeight)),
      child: Image.asset(
          'images/angry.png',
        width: MediaQuery.of(context).size.height * birdWidth/2,
        height: MediaQuery.of(context).size.height *3/4 * birdWidth/2,
        fit: BoxFit.fill,
      ),
    );
  }

}

