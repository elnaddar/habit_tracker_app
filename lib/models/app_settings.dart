import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'app_settings.g.dart';

@collection
class AppSettings {
  Id? id;
  DateTime firstLaunchDate = DateTime.now();
  @enumerated
  ThemeMode themeMode = ThemeMode.light;
}
