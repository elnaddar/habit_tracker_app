import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/cubits/habits_cubit.dart';
import 'package:habit_tracker_app/repositories/app_settings_repository.dart';
import 'package:habit_tracker_app/repositories/habits_repository.dart';
import 'package:habit_tracker_app/services/isar_service.dart';
import 'package:habit_tracker_app/theme/src/dark_mode.dart';
import 'package:habit_tracker_app/theme/src/light_mode.dart';
import 'package:habit_tracker_app/utils/routes.dart';

import 'theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isarService = IsarService();
  await isarService.initialize();

  final appSettingsRepository = AppSettingsRepository(isarService);
  final habitsRepository = HabitRepository(isarService);

  await appSettingsRepository.saveFirstAppSettings();

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(value: appSettingsRepository),
      RepositoryProvider.value(value: habitsRepository),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => HabitsCubit(context.read()),
        ),
      ],
      child: const MainApp(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      onGenerateRoute: onGenerateRoute,
      themeMode: context.watch<ThemeCubit>().themeMode,
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
