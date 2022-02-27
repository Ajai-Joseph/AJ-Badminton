import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class ScoreModel {
  @HiveField(0)
  String leftTeamName;
  @HiveField(1)
  String rightTeamName;
  @HiveField(2)
  String leftTeamScore;
  @HiveField(3)
  String rightTeamScore;
  @HiveField(4)
  String startDateTime;
  @HiveField(5)
  String endDateTime;
  @HiveField(6)
  String winner;

  ScoreModel({
    required this.leftTeamName,
    required this.rightTeamName,
    required this.leftTeamScore,
    required this.rightTeamScore,
    required this.startDateTime,
    required this.endDateTime,
    required this.winner,
  });
}
