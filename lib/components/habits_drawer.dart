import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/theme/theme_cubit.dart';

class HabitsDrawer extends StatelessWidget {
  const HabitsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Center(
        child: CupertinoSwitch(
          value: context.watch<ThemeCubit>().isDarkMode,
          onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
        ),
      ),
    );
  }
}
