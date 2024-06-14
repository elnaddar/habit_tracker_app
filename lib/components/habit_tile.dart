import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/cubits/habits_cubit.dart';
import 'package:habit_tracker_app/models/habit.dart';

class HabitTile extends StatelessWidget {
  const HabitTile(
      {super.key,
      required this.habit,
      required this.isCompleted,
      required this.onChanged});

  final Habit habit;
  final bool isCompleted;
  final void Function(bool? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    final tileColor =
        isCompleted ? Colors.green : Theme.of(context).colorScheme.secondary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            const Flexible(child: SizedBox.expand()),
            SlidableAction(
              flex: 10,
              onPressed: _editTheHabit,
              icon: Icons.edit,
              backgroundColor: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            const Flexible(child: SizedBox.expand()),
            SlidableAction(
              flex: 10,
              onPressed: _deleteTheHabit,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12.0),
          duration: const Duration(milliseconds: 300),
          child: ListTile(
            title: Text(habit.name),
            onTap: () => onChanged!(false),
            leading: Checkbox(
              activeColor: Colors.green,
              onChanged: onChanged,
              value: isCompleted,
            ),
          ),
        ),
      ),
    );
  }

  void _editTheHabit(context) => {
        Navigator.of(context)
            .pushNamed("/add_habit", arguments: {"habit": habit})
      };

  void _deleteTheHabit(context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('Confirm Delete'),
        content: Text("Are you sure you want to delete '${habit.name}' habit?"),
        actions: [
          TextButton(
            onPressed: () {
              context.read<HabitsCubit>().deleteHabit(habit.id);
              Navigator.of(context).pop(); // Confirm dismissal
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Reject dismissal
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
