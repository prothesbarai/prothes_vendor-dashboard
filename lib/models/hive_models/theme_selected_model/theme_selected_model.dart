import 'package:hive/hive.dart';
part 'theme_selected_model.g.dart';

@HiveType(typeId: 0)
enum AppTheme {
  @HiveField(0)
  system,

  @HiveField(1)
  light,

  @HiveField(2)
  dark
}