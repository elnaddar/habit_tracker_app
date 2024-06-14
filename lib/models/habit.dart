import 'package:isar/isar.dart';

part 'habit.g.dart';

@collection
class Habit {
  Id id = Isar.autoIncrement;
  late String name;
  String? description;
  DateTime startDate = DateTime.now();
  List<DateTime> completedDays = [];
  bool isActive = true;

  Habit();

  factory Habit.fromForm(Map<String, dynamic> formMap) {
    final habit = Habit();
    habit.name = formMap['name'];
    habit.description = formMap['description'];
    habit.startDate = formMap['startDate'];
    return habit;
  }
}
