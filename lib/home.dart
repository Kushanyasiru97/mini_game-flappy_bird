import 'dart:async';
import 'package:flappybird_game/bird.dart';
import 'package:flappybird_game/coverscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'barrier.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static double flappyY = 0;
  double initialpos = flappyY;
  double height = 0;
  double time = 0;
  double gravity = -5.0;
  double velocity = 3.0;
  double birdWidth = 0.1;
  double birdHeight = 0.1;

  bool gameStart = false;

  static List barrierX = [2, 2+1.5];
  static double barrierWidth = 0.5;
  List <List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4 , 0.6],
  ];


  void startgame(){
    gameStart = true;
    Timer.periodic(Duration(milliseconds: 50),(timer){
      height = gravity * time * time + velocity * time;
      setState(() {
        flappyY = initialpos - height;
        print(flappyY);
    });
      if(BirdIsDead()){
        timer.cancel();
       // gameStart = false;
        _showDialog();
      }

      moveMap();

      time += 0.01;
    });
  }

  void moveMap(){
    for(int i=0;i<barrierX.length;i++){
      setState(() {
        barrierX[i] -= 0.005;
      });

      if(barrierX[i] < -1.5){
        barrierX[i] +=3;
      }
    }
  }

  void resetGame(){
    Navigator.pop(context);
    setState(() {
      flappyY =0;
      gameStart = false;
      time= 0;
      initialpos = flappyY;
      barrierX = [2, 2+1.5];
    });
  }

  void _showDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                'GAME OVER',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void jump(){
    setState(() {
      time = 0;
      initialpos = flappyY;
    });

  }

  bool BirdIsDead() {
    if(flappyY <-1 || flappyY >1){
      return true;
    }
    for(int i =0; i<barrierX.length; i++){
      if(barrierX[i] <= birdWidth && barrierX[i] + barrierWidth>= -birdWidth && (flappyY<= -1 + barrierHeight[i][0]
      || flappyY + birdHeight>= 1 -barrierHeight[i][1])){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameStart ? jump : startgame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
                child: Container(
                  color: Colors.lightBlueAccent,
                    child: Center(
                      child: Stack(
                        children: [
                          AngryBird(
                              flappyY: flappyY,
                            birdHeight:birdHeight,
                            birdWidth:0.20,
                          ),

                          MyCoverScreeen(gameStart:gameStart),

                          Mybarrier(
                            barrierX:barrierX[0],
                            barrierWidth:barrierWidth,
                            barrierHeight:barrierHeight[0][1],
                            isBottomBarrier:true,
                          ),
                          Mybarrier(
                            barrierX:barrierX[1],
                            barrierWidth:barrierWidth,
                            barrierHeight:barrierHeight[1][0],
                            isBottomBarrier:false,
                          ),

                          Mybarrier(
                            barrierX:barrierX[1],
                            barrierWidth:barrierWidth,
                            barrierHeight:barrierHeight[1][1],
                            isBottomBarrier:true,
                          ),
                          /*Container(
                            alignment: Alignment(0,-0.5),
                            child: Text(
                              gameStart ? '' : 'TAP TO PLAY',
                              style: TextStyle(color: Colors.white),
                            ),
                          )*/
                      ],
                      ),
                    ),
                ),
            ),
            Expanded(
                child: Container(
                  color: Colors.brown,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              style: TextStyle(color: Colors.white,fontSize: 40.0),
                            ),
                            SizedBox(height: 20.0,),
                            Text(
                              'SCORE',
                              style: TextStyle(color: Colors.white,fontSize: 20.0),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '10',
                              style: TextStyle(color: Colors.white,fontSize: 40.0),
                            ),
                            SizedBox(height: 20.0,),
                            Text(
                              'BEST',
                              style: TextStyle(color: Colors.white,fontSize: 20.0),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }


}
