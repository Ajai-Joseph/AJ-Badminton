import 'package:aj_badminton/db_functions.dart';
import 'package:aj_badminton/home.dart';
import 'package:aj_badminton/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Court extends StatefulWidget {
  String leftTeamName, rightTeamName;
  Court({
    required this.leftTeamName,
    required this.rightTeamName,
  });

  @override
  State<Court> createState() => _CourtState();
}

class _CourtState extends State<Court> {
  int leftTeamScore = 0,
      rightTeamScore = 0,
      leftService = 0,
      rightService = 0,
      leftServiceChange = 0,
      rightServiceChange = 0;
  DateTime startDateTime = DateTime.now();
  late DateTime endDateTime;
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    speak(
        "on my left ${widget.leftTeamName} and on my right ${widget.rightTeamName}, love all play");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/c4c.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 65,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            widget.leftTeamName.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    speak("sorry, mistaken");
                                    setState(
                                      () {
                                        if (leftTeamScore > 0) {
                                          if (leftTeamScore > 20 ||
                                              rightTeamScore > 20) {
                                            if (leftTeamScore <
                                                rightTeamScore - 1) {
                                            } else {
                                              leftTeamScore = leftTeamScore - 1;
                                            }
                                          } else {
                                            leftTeamScore = leftTeamScore - 1;
                                          }
                                        }
                                      },
                                    );
                                  },
                                  child: Text(
                                    "-",
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.29,
                                  width: 60,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          rightServiceChange = 1;
                                          leftService = 1;
                                          rightService = 0;
                                          if ((leftTeamScore >= 20) &&
                                              (leftTeamScore >
                                                  (rightTeamScore))) {
                                            if (leftTeamScore == 20 &&
                                                rightTeamScore < 20) {
                                              leftTeamScore = leftTeamScore + 1;
                                            } else if ((leftTeamScore >= 21) &&
                                                (leftTeamScore >=
                                                    (rightTeamScore + 2))) {
                                            } else {
                                              leftTeamScore = leftTeamScore + 1;
                                            }
                                            win(context, "left");
                                          } else {
                                            //   if ((leftTeamScore >= 21) &&
                                            //       (leftTeamScore >=
                                            //           (rightTeamScore + 2))) {
                                            //   } else {
                                            leftTeamScore = leftTeamScore + 1;
                                            if (leftTeamScore ==
                                                rightTeamScore) {
                                              if (leftServiceChange == 1) {
                                                speak(
                                                    "service change, $leftTeamScore, all");
                                                leftServiceChange = 0;
                                              } else {
                                                speak("$leftTeamScore, all");
                                              }
                                            } else {
                                              if (leftTeamScore >= 20 &&
                                                  leftTeamScore >
                                                      rightTeamScore) {
                                                if (leftServiceChange == 1) {
                                                  speak(
                                                      "service change, $leftTeamScore, $rightTeamScore, Gamepoint");
                                                  leftServiceChange = 0;
                                                } else {
                                                  speak(
                                                      "$leftTeamScore, $rightTeamScore, Gamepoint");
                                                }
                                              } else {
                                                if (rightTeamScore == 0) {
                                                  speak("$leftTeamScore, love");
                                                } else {
                                                  if (leftServiceChange == 1) {
                                                    speak(
                                                        "service change, $leftTeamScore, $rightTeamScore");
                                                    leftServiceChange = 0;
                                                  } else {
                                                    speak(
                                                        "$leftTeamScore, $rightTeamScore");
                                                  }
                                                }
                                              }
                                            }
                                            // }
                                          }
                                        },
                                      );
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 1.75,
                              width: MediaQuery.of(context).size.height / 1.75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: leftService == 0
                                    ? Colors.grey
                                    : Colors.green,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Left Team",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      leftTeamScore.toString(),
                                      style: TextStyle(
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Score",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.rightTeamName.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 1.75,
                              width: MediaQuery.of(context).size.height / 1.75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: rightService == 0
                                    ? Colors.grey
                                    : Colors.green,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Right Team",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      rightTeamScore.toString(),
                                      style: TextStyle(
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Score",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    speak("sorry, mistaken");
                                    setState(
                                      () {
                                        if (rightTeamScore > 0) {
                                          if (leftTeamScore > 20 ||
                                              rightTeamScore > 20) {
                                            if (rightTeamScore <
                                                leftTeamScore - 1) {
                                            } else {
                                              rightTeamScore =
                                                  rightTeamScore - 1;
                                            }
                                          } else {
                                            rightTeamScore = rightTeamScore - 1;
                                          }
                                        }
                                      },
                                    );
                                  },
                                  child: Text(
                                    "-",
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.29,
                                  width: 60,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          leftServiceChange = 1;
                                          rightService = 1;
                                          leftService = 0;
                                          if ((rightTeamScore >= 20) &&
                                              (rightTeamScore >
                                                  (leftTeamScore))) {
                                            if (rightTeamScore == 20 &&
                                                leftTeamScore < 20) {
                                              rightTeamScore =
                                                  rightTeamScore + 1;
                                            } else if ((rightTeamScore >= 21) &&
                                                (rightTeamScore >=
                                                    (leftTeamScore + 2))) {
                                            } else {
                                              rightTeamScore =
                                                  rightTeamScore + 1;
                                            }
                                            win(context, "right");
                                          } else {
                                            if ((rightTeamScore >= 21) &&
                                                (rightTeamScore >=
                                                    (leftTeamScore + 2))) {
                                            } else {
                                              rightTeamScore =
                                                  rightTeamScore + 1;
                                              if (leftTeamScore ==
                                                  rightTeamScore) {
                                                if (rightServiceChange == 1) {
                                                  speak(
                                                      "service change, $rightTeamScore, all");
                                                  rightServiceChange = 0;
                                                } else {
                                                  speak("$rightTeamScore, all");
                                                }
                                              } else {
                                                if (rightTeamScore >= 20 &&
                                                    rightTeamScore >
                                                        leftTeamScore) {
                                                  if (rightServiceChange == 1) {
                                                    speak(
                                                        "service change, $rightTeamScore, $leftTeamScore, Gamepoint");
                                                    rightServiceChange = 0;
                                                  } else {
                                                    speak(
                                                        "$rightTeamScore, $leftTeamScore, Gamepoint");
                                                  }
                                                } else {
                                                  if (leftTeamScore == 0) {
                                                    speak(
                                                        "$rightTeamScore, love");
                                                  } else {
                                                    if (rightServiceChange ==
                                                        1) {
                                                      speak(
                                                          "service change, $rightTeamScore, $leftTeamScore");
                                                      rightServiceChange = 0;
                                                    } else {
                                                      speak(
                                                          "$rightTeamScore, $leftTeamScore");
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        },
                                      );
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    speak("Game reseted, started new game, love all, play");
                    setState(() {
                      leftTeamScore = 0;
                      rightTeamScore = 0;
                      leftService = 0;
                      rightService = 0;
                    });
                  },
                  child: Text(
                    "RESET GAME",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void win(BuildContext context, String winner) {
    if (winner == "left") {
      speak(
          "${widget.leftTeamName} won the match for ${leftTeamScore - rightTeamScore} points, congratulations");
    } else {
      speak(
          "${widget.rightTeamName} won the match for ${rightTeamScore - leftTeamScore} points, congratulations");
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Congratulations!",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          content: Text(winner == "left"
              ? "${widget.leftTeamName} won the match \nfor ${leftTeamScore - rightTeamScore} points ($leftTeamScore-$rightTeamScore)"
              : "${widget.rightTeamName} win for ${rightTeamScore - leftTeamScore} points\n($rightTeamScore-$leftTeamScore)"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Go back",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    finish(context, winner);
                  },
                  child: Text(
                    "Continue",
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void finish(BuildContext context, String winner) {
    endDateTime = DateTime.now();
    final match = ScoreModel(
        leftTeamName: widget.leftTeamName,
        rightTeamName: widget.rightTeamName,
        leftTeamScore: leftTeamScore.toString(),
        rightTeamScore: rightTeamScore.toString(),
        startDateTime: startDateTime.toString(),
        endDateTime: endDateTime.toString(),
        winner: winner);
    addScore(match);
    Navigator.of(context).pop();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }

  void speak(String text) async {
    flutterTts.setLanguage("en-US");

    // flutterTts.setSpeechRate(0.3);
    await flutterTts.speak(text);
  }
}
