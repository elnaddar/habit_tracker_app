import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/components/habit_tile.dart';
import 'package:habit_tracker_app/components/habits_drawer.dart';
import 'package:habit_tracker_app/cubits/habits_cubit.dart';
import 'package:habit_tracker_app/extensions/habit_extensions.dart';
import 'package:habit_tracker_app/models/habit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Habit",
        onPressed: () => Navigator.of(context).pushNamed("/add_habit"),
        child: const Icon(Icons.add),
      ),
      drawer: const HabitsDrawer(),
      body: BlocBuilder<HabitsCubit, List<Habit>>(
        bloc: BlocProvider.of<HabitsCubit>(context),
        builder: (context, state) {
          if (state.isEmpty) {
            return const Center(
              child: Text("No habits till now, try to add some."),
            );
          } else {
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                final habit = state[index];
                return HabitTile(
                  habit: habit,
                  isCompleted: habit.isCompletedToday(),
                  onChanged: (bool? value) {
                    context
                        .read<HabitsCubit>()
                        .updateHabit(habit.id, dateTime: DateTime.now());
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
