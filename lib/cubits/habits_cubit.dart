import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/repositories/habits_repository.dart';

import '/models/habit.dart';

class HabitsCubit extends Cubit<List<Habit>> {
  final HabitRepository _repo;
  List<Habit> _habits = [];
  HabitsCubit(HabitRepository repo)
      : _repo = repo,
        super([]) {
    _repo.habits.then((value) => habits = value);
  }

  List<Habit> get habits => state;

  set habits(List<Habit> newHabits) {
    _habits = newHabits;
    emit(_habits);
  }

  Future<void> addHabit(Habit habit) async {
    await _repo.addHabitObject(habit);
    await loadHabits();
  }

  Future<List<Habit>> loadHabits() async {
    habits = await _repo.habits;
    return habits;
  }

  Future<void> updateHabit(
    int id, {
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? dateTime,
    bool? isActive,
  }) async {
    await _repo.updateHabit(
      id,
      name: name,
      description: description,
      startDate: startDate,
      dateTime: dateTime,
      isActive: isActive,
    );
    await loadHabits();
  }

  Future<void> updateHabitFromMap(int id, Map<String, dynamic> map) async {
    await _repo.updateHabit(
      id,
      name: map['name'],
      description: map['description'],
      startDate: map['startDate'],
      dateTime: map['dateTime'],
      isActive: map['isActive'],
    );
    await loadHabits();
  }

  Future<void> deleteHabit(int id) async {
    await _repo.deleteHabit(id);
    await loadHabits();
  }
}
