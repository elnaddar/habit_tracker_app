import 'package:habit_tracker_app/models/habit.dart';
import 'package:habit_tracker_app/utils/methods.dart';

extension HabitExtension on Habit {
  bool isCompletedToday() {
    final today = DateTime.now();
    return completedDays.any((date) => compareDates(date, today));
  }

  Map<String, dynamic> forForm() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toString(),
      'isActive': isActive,
      'completedDays': completedDays,
    };
  }
}
