import 'package:flutter/material.dart';

class MyCoverScreeen extends StatelessWidget {

  final bool gameStart;
  MyCoverScreeen({required this.gameStart});


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, -0.5),
      child: Text(
        gameStart ? '' : 'TAP TO PLAY',
        style: TextStyle(color: Colors.white,fontSize: 30.0),
      ),
    );
  }
}
