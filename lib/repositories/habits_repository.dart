import 'package:habit_tracker_app/models/habit.dart';
import 'package:habit_tracker_app/services/isar_service.dart';
import 'package:habit_tracker_app/utils/methods.dart';
import 'package:isar/isar.dart';

class HabitRepository {
  final Isar _isar;
  HabitRepository(IsarService isarService) : _isar = isarService.isar;

  Future<List<Habit>> get habits async {
    return await _isar.habits.where().findAll();
  }

  Future<Habit?> getHabitById(int id) async => await _isar.habits.get(id);

  Future<void> addHabit({
    required String name,
    String? description,
    DateTime? startDate,
  }) async {
    final newHabit = Habit()
      ..name = name
      ..description = description;
    if (startDate != null) {
      newHabit.startDate = startDate;
    }

    await addHabitObject(newHabit);
  }

  Future<void> addHabitObject(Habit newHabit) async {
    await _isar.writeTxn(() => _isar.habits.put(newHabit));
  }

  Future<void> updateHabit(
    int id, {
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? dateTime,
    bool? isActive,
  }) async {
    final habit = await getHabitById(id);
    if (habit != null) {
      if (name != null) {
        habit.name = name;
      }
      if (description != null) {
        habit.description = description;
      }
      if (startDate != null) {
        habit.startDate = startDate;
      }
      if (description != null) {
        habit.description = description;
      }
      if (dateTime != null) {
        _updateHabitCompletion(habit, dateTime);
      }
      if (isActive != null) {
        habit.isActive = isActive;
      }
      await _isar.writeTxn(() => _isar.habits.put(habit));
    }
  }

  void _updateHabitCompletion(Habit habit, DateTime dateTime) {
    if (habit.completedDays.any((element) => compareDates(element, dateTime))) {
      habit.completedDays
          .removeWhere((element) => compareDates(element, dateTime));
    } else {
      habit.completedDays.add(dateTime);
    }
  }

  Future<void> deleteHabit(int id) async {
    await _isar.writeTxn(() async => await _isar.habits.delete(id));
  }
}
