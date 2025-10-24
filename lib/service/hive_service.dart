import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import '../models/hive_models/theme_selected_model/theme_selected_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


/// >>> Only APP er Jonno
/*class HiveService {
  static Future<void> initHive() async{
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(AppThemeAdapter());

    await Future.wait([
      Hive.openBox('themeSettings'),
    ]);
  }
}*/


/// >>> Web / Chrome e Run Korar Jonno....
class HiveService {
  static Future<void> initHive() async {
    if (kIsWeb) {
      // Initialize Hive for Web
      await Hive.initFlutter();
    } else {
      // Initialize Hive for Android/iOS/Desktop
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }

    // Register your adapter
    Hive.registerAdapter(AppThemeAdapter());

    // Open boxes
    await Hive.openBox('themeSettings');
  }
}
