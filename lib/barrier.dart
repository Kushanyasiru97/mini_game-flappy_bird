import 'package:flutter/material.dart';

class Mybarrier extends StatelessWidget {
  const Mybarrier({Key? key, this.barrierWidth, this.barrierHeight, this.barrierX, required this.isBottomBarrier}) : super(key: key);

  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final bool isBottomBarrier;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth)/(2-barrierWidth),isBottomBarrier ? -1: 1),
      child: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width * barrierWidth/2,
        height: MediaQuery.of(context).size.height *3/4 * barrierHeight/2,
      ),
    );
  }
}
