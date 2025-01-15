import 'package:hive_flutter/adapters.dart';

class HiveService {
  static const String authBox = 'authBox';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(authBox);
  }

  Future<void> save(String key, dynamic value) async {
    final box = Hive.box(authBox);
    await box.put(key, value);
  }

  dynamic get(String key) {
    final box = Hive.box(authBox);
    return box.get(key);
  }

  Future<void> delete(String key) async {
    final box = Hive.box(authBox);
    await box.delete(key);
  }
}
