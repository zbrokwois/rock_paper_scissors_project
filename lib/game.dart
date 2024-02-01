// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  String userChoice = '';
  String compChoice = '';
  String message = '';
  double myPoints = 0.0;
  double compPoints = 0.0;
  bool hasChosen = false;
  final List<String> _choices = ['paper', 'rock', 'scissors'];
  Widget iPicked = Container(), compPicked = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            HSLColor.fromAHSL(1, 170, 0.6, 0.5).toColor(),
            HSLColor.fromAHSL(1, 170, 0.5, 0.4).toColor(),
          ]),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Scoreboard(
                  title: 'Player',
                  points: myPoints,
                ),
                Scoreboard(
                  title: 'Computer',
                  points: compPoints,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            hasChosen
                ? Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              iPicked,
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'You',
                                style: GoogleFonts.barlowSemiCondensed(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              compPicked,
                              SizedBox(height: 10.0),
                              Text('Computer',
                                  style: GoogleFonts.barlowSemiCondensed(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60.0, vertical: 10.0)),
                          onPressed: () {
                            setState(() {
                              hasChosen = false;
                            });
                          },
                          child: Text('PLAY AGAIN',
                              style: GoogleFonts.barlowSemiCondensed(
                                  color: HSLColor.fromAHSL(1, 239, 0.49, 0.15)
                                      .toColor(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0)))
                    ],
                  )
                : Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            userChoice = 'paper';
                            userClicking();
                          },
                          child: BigCircle(
                              SvgPicture.asset('images/icon-paper.svg'),
                              HSLColor.fromAHSL(1, 230, 0.89, 0.62).toColor(),
                              HSLColor.fromAHSL(1, 230, 0.49, 0.65).toColor(),
                              HSLColor.fromAHSL(1, 229, 0.64, 0.49).toColor()),
                        ),
                        InkWell(
                          onTap: () {
                            userChoice = 'scissors';
                            userClicking();
                          },
                          child: BigCircle(
                              SvgPicture.asset('images/icon-scissors.svg'),
                              HSLColor.fromAHSL(1, 39, 0.89, 0.49).toColor(),
                              HSLColor.fromAHSL(1, 40, 0.84, 0.53).toColor(),
                              HSLColor.fromAHSL(1, 39, 0.64, 0.46).toColor()),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    InkWell(
                      onTap: () {
                        userChoice = 'rock';
                        userClicking();
                      },
                      child: BigCircle(
                          SvgPicture.asset('images/icon-rock.svg'),
                          HSLColor.fromAHSL(1, 349, 0.71, 0.52).toColor(),
                          HSLColor.fromAHSL(1, 349, 0.70, 0.56).toColor(),
                          HSLColor.fromAHSL(1, 349, 0.64, 0.46).toColor()),
                    )
                  ]),
          ],
        ),
      ),
    );
  }

  userClicking() {
    compChoices();
    whoWon(userChoice, compChoice);
    setState(() {
      hasChosen = true;
      if (myPoints == 10.0 || compPoints == 10.0) {
        showWinMessage();
      }
    });
  }

  void compChoices() {
    Random random = Random();
    int randomNumber = random.nextInt(3);
    compChoice = _choices[randomNumber];
  }

  whoWon(userC, compC) {
    var rpsChoices = {
      'rock': {'scissors': 1, 'rock': 0.5, 'paper': 0},
      'paper': {'scissors': 0, 'rock': 1, 'paper': 0.5},
      'scissors': {'scissors': 0.5, 'rock': 0, 'paper': 1},
    };

    var myscore = rpsChoices[userC]?[compC];
    updateScore(myscore);
    picked();
  }

  updateScore(myScore) {
    if (myScore == 0) {
      compPoints += 1.0;
      message = 'You lost';
    } else if (myScore == 0.5) {
      myPoints += 0.5;
      compPoints += 0.5;
      message = 'You tied';
    } else {
      myPoints += 1.0;
      message = 'You won';
    }
  }

  picked() {
    if (userChoice == 'paper') {
      iPicked = BigCircle(
          SvgPicture.asset('images/icon-paper.svg'),
          HSLColor.fromAHSL(1, 230, 0.89, 0.62).toColor(),
          HSLColor.fromAHSL(1, 230, 0.49, 0.65).toColor(),
          HSLColor.fromAHSL(1, 229, 0.64, 0.49).toColor());
    } else if (userChoice == 'rock') {
      iPicked = BigCircle(
          SvgPicture.asset('images/icon-rock.svg'),
          HSLColor.fromAHSL(1, 349, 0.71, 0.52).toColor(),
          HSLColor.fromAHSL(1, 349, 0.70, 0.56).toColor(),
          HSLColor.fromAHSL(1, 349, 0.64, 0.46).toColor());
    } else {
      iPicked = BigCircle(
          SvgPicture.asset('images/icon-scissors.svg'),
          HSLColor.fromAHSL(1, 39, 0.89, 0.49).toColor(),
          HSLColor.fromAHSL(1, 40, 0.84, 0.53).toColor(),
          HSLColor.fromAHSL(1, 39, 0.64, 0.46).toColor());
    }

    // computer choices
    if (compChoice == 'paper') {
      compPicked = BigCircle(
          SvgPicture.asset('images/icon-paper.svg'),
          HSLColor.fromAHSL(1, 230, 0.89, 0.62).toColor(),
          HSLColor.fromAHSL(1, 230, 0.49, 0.65).toColor(),
          HSLColor.fromAHSL(1, 229, 0.64, 0.49).toColor());
    } else if (compChoice == 'rock') {
      compPicked = BigCircle(
          SvgPicture.asset('images/icon-rock.svg'),
          HSLColor.fromAHSL(1, 349, 0.71, 0.52).toColor(),
          HSLColor.fromAHSL(1, 349, 0.70, 0.56).toColor(),
          HSLColor.fromAHSL(1, 349, 0.64, 0.46).toColor());
    } else {
      compPicked = BigCircle(
          SvgPicture.asset('images/icon-scissors.svg'),
          HSLColor.fromAHSL(1, 39, 0.89, 0.49).toColor(),
          HSLColor.fromAHSL(1, 40, 0.84, 0.53).toColor(),
          HSLColor.fromAHSL(1, 39, 0.64, 0.46).toColor());
    }
  }

  showWinMessage() {
    String winner = (myPoints == 10.0) ? 'Player' : 'Computer';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('$winner wins with 10 points!'),
          actions: [
            TextButton(
              onPressed: () {
                resetGame();
                Navigator.of(context).pop();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  resetGame() {
    setState(() {
      myPoints = 0.0;
      compPoints = 0.0;
      hasChosen = false;
    });
  }
}

class Scoreboard extends StatelessWidget {
  final String title;
  final double points;

  const Scoreboard({
    required this.title,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(
              width: 3.0,
              color: HSLColor.fromAHSL(1, 217, 0.16, 0.45).toColor()),
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.barlowSemiCondensed(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(100, 80)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: null,
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontWeight: FontWeight.w700),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Score\n',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: 15.0,
                      color: HSLColor.fromAHSL(1, 229, 0.64, 0.46).toColor(),
                    ),
                  ),
                  TextSpan(
                    text: points.toString(),
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: 40.0,
                      color: HSLColor.fromAHSL(1, 229, 0.25, 0.31).toColor(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BigCircle extends StatelessWidget {
  final Widget innerChild;
  final Color gradientColor1;
  final Color gradientColor2;
  final Color shadowColor;

  const BigCircle(
    this.innerChild,
    this.gradientColor1,
    this.gradientColor2,
    this.shadowColor,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [gradientColor1, gradientColor2]),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor,
            spreadRadius: 1,
            offset: Offset(1.0, 4),
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0.6,
              blurRadius: 7.0,
              offset: Offset(4, -6),
            ),
          ],
        ),
        child: innerChild,
      ),
    );
  }
}
