import 'package:hive/hive.dart';

class HiveService {
  HiveService._();

  static final HiveService shared = HiveService._();

  factory HiveService() {
    return shared;
  }

  final String dbName = 'secureHive';

  Future<void> write({required String key, required String value}) async {
    final box = await Hive.openBox(dbName);
    await box.put(key, value);
    await box.close();
  }

  Future<String?> read({required String key}) async {
    final box = await Hive.openBox(dbName);
    final value = box.get(key);
    await box.close();
    return value;
  }

  Future<bool> containsKey({required String key}) async {
    final box = await Hive.openBox(dbName);
    final contains = box.containsKey(key);
    await box.close();
    return contains;
  }

  Future<void> delete({required String key}) async {
    final box = await Hive.openBox(dbName);
    await box.delete(key);
    await box.close();
  }

}