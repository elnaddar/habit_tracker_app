import 'package:habit_tracker_app/models/app_settings.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Isar isar;

  Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open(
      [AppSettingsSchema, HabitSchema],
      directory: dir.path,
    );
  }
}
