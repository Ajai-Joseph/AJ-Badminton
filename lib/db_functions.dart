import 'package:aj_badminton/model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<ScoreModel>> scoreNotifier = ValueNotifier([]);
void addScore(ScoreModel value) async {
  final scoreDB = await Hive.openBox<ScoreModel>("score_db");
  await scoreDB.put(value.startDateTime, value);
  scoreNotifier.value.add(value);
  scoreNotifier.notifyListeners();
}

Future<void> getAllScores() async {
  final scoreDB = await Hive.openBox<ScoreModel>('score_db');
  scoreNotifier.value.clear();
  scoreNotifier.value.addAll(scoreDB.values);
  scoreNotifier.notifyListeners();
}

Future<void> deleteScore(String id) async {
  final scoreDB = await Hive.openBox<ScoreModel>('score_db');
  await scoreDB.delete(id);
  getAllScores();
}
