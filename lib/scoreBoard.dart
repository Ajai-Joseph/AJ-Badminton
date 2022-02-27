import 'package:aj_badminton/db_functions.dart';
import 'package:aj_badminton/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllScores();

    return SafeArea(
      child: Scaffold(
        drawer: drawer(context),
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            "SCOREBOARD",
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.blue,
                  Colors.purple,
                ])),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/lee.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: scoreNotifier,
            builder: (context, List<ScoreModel> scoreList, Widget? child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final data = scoreList[scoreList.length - index - 1];
                  return Slidable(
                    key: Key(data.startDateTime),
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            deleteScore(data.startDateTime);
                          },
                          icon: Icons.delete,
                          label: "Delete",
                        )
                      ],
                    ),
                    child: Card(
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data.startDateTime.substring(0, 10)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              "Start at : ${data.startDateTime.substring(11, 16)}\nEnd at   : ${data.endDateTime.substring(11, 16)}",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                data.winner == "left"
                                    ? "${data.leftTeamName}"
                                    : "${data.rightTeamName}",
                                style: TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                data.winner == "right"
                                    ? "${data.leftTeamName}"
                                    : "${data.rightTeamName}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.close_rounded,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        trailing: Text(int.parse(data.leftTeamScore) >
                                int.parse(data.rightTeamScore)
                            ? int.parse(data.rightTeamScore) < 10
                                ? "${data.leftTeamScore}-0${data.rightTeamScore}"
                                : "${data.leftTeamScore}-${data.rightTeamScore}"
                            : int.parse(data.leftTeamScore) < 10
                                ? "${data.rightTeamScore}-0${data.leftTeamScore}"
                                : "${data.rightTeamScore}-${data.leftTeamScore}"),
                      ),
                    ),
                  );
                },
                itemCount: scoreList.length,
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget drawer(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.6,
    child: Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 80,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.blue,
                  Colors.purple,
                ])),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Developer Contact",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  horizontalTitleGap: 0,
                  leading: Icon(Icons.email),
                  title: Text("ajaijoseph363@gmail.com"),
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  leading: Icon(Icons.phone),
                  title: Text("+91 9497308477"),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
