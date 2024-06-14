import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/repositories/app_settings_repository.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final AppSettingsRepository _repo;
  ThemeCubit(AppSettingsRepository repo)
      : _repo = repo,
        super(ThemeMode.light) {
    _repo.appSettings.then((value) => themeMode = value!.themeMode);
  }

  bool get isDarkMode => state == ThemeMode.dark;

  ThemeMode get themeMode => state;
  set themeMode(ThemeMode themeMode) {
    _repo.updateThemeMode(themeMode);
    emit(themeMode);
  }

  void toggleTheme() {
    if (isDarkMode) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }
}
