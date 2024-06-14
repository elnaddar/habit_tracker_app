import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/app_settings.dart';
import 'package:habit_tracker_app/services/isar_service.dart';
import 'package:isar/isar.dart';

class AppSettingsRepository {
  final Isar _isar;
  AppSettingsRepository(IsarService isarService) : _isar = isarService.isar;

  Future<void> saveFirstAppSettings() async {
    final existingSettings = await appSettings;
    if (existingSettings == null) {
      final settings = AppSettings();
      await _isar.writeTxn(() => _isar.appSettings.put(settings));
    }
  }

  Future<AppSettings?> get appSettings async {
    return await _isar.appSettings.where().findFirst();
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    final existingSettings = await appSettings;
    if (existingSettings != null) {
      existingSettings.themeMode = themeMode;
      await _isar.writeTxn(() => _isar.appSettings.put(existingSettings));
    }
  }
}
