import 'package:aj_badminton/court.dart';
import 'package:aj_badminton/scoreBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  TextEditingController leftTeamFirstNameController = TextEditingController();
  TextEditingController leftTeamSecondNameController = TextEditingController();
  TextEditingController rightTeamFirstNameController = TextEditingController();
  TextEditingController rightTeamSecondNameController = TextEditingController();
  late String leftTeamName, rightTeamName;
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("AJ Badminton"),
          actions: [
            PopupMenuButton(
              onSelected: (item) => select(context, item),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Text(
                    "Scores",
                  ),
                ),
              ],
            ),
          ],
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
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/home.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    text(
                      team: "LEFT TEAM",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    textFormField(
                      controller: leftTeamFirstNameController,
                      check: 1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    textFormField(
                      controller: leftTeamSecondNameController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    text(
                      team: "RIGHT TEAM",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    textFormField(
                      controller: rightTeamFirstNameController,
                      check: 1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    textFormField(
                      controller: rightTeamSecondNameController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (leftTeamSecondNameController.text.isEmpty) {
                            leftTeamName = leftTeamFirstNameController.text;
                          } else {
                            leftTeamName =
                                "${leftTeamFirstNameController.text} & ${leftTeamSecondNameController.text}";
                          }
                          if (rightTeamSecondNameController.text.isEmpty) {
                            rightTeamName = rightTeamFirstNameController.text;
                          } else {
                            rightTeamName =
                                "${rightTeamFirstNameController.text} & ${rightTeamSecondNameController.text}";
                          }
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Court(
                                leftTeamName: leftTeamName,
                                rightTeamName: rightTeamName,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade700),
                      child: Text(
                        "START GAME",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void select(BuildContext context, var item) {
    switch (item) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ScoreBoard()));
        break;
    }
  }
}

Widget text({required String team}) {
  return Text(
    team,
    style: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w900,
      color: Colors.red.shade900,
    ),
  );
}

Widget textFormField({
  required TextEditingController controller,
  int check = 0,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    style: TextStyle(color: Colors.black87),
    decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hoverColor: Colors.red,
        errorStyle: TextStyle(
          color: Colors.red[700],
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        contentPadding: EdgeInsets.all(15)),
    validator: (value) {
      if (controller.text.length > 10) {
        return "Maximum 10 characters allowed";
      }
      if (check == 1) {
        if (value!.isEmpty) {
          return "Enter name";
        }
      }
    },
  );
}
