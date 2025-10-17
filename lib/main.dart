import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prothesvendordashboard/pages/dashboard/pro_dashboard.dart';
import 'package:prothesvendordashboard/providers/dashboard_settings_provider.dart';
import 'package:prothesvendordashboard/providers/items_provider.dart';
import 'package:prothesvendordashboard/providers/theme_provider.dart';
import 'package:prothesvendordashboard/service/hive_service.dart';
import 'package:prothesvendordashboard/utils/constant/app_colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive Initialization
  await HiveService.initHive();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItemsProvider()),
        ChangeNotifierProvider(create: (context) => DashboardSettingsProvider()),
        // This Provider Only Theme Change Provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(411, 869),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: themeProvider.themeMode,
            home: ProDashboard(),
          ),
        );
      },
    );
  }


  /// >>>>>>>> NB :  Theme Customization For, Need Theme Model + Theme Provider & Settings
  /// >>> Customization For Light Theme
  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryColor, centerTitle: true, foregroundColor: Colors.white, iconTheme: IconThemeData(color: Colors.white),),
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20),),),),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),),),
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      dialogTheme: DialogThemeData(backgroundColor: Colors.white),
    );
  }
  /// >>> Customization For Dark Theme
  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900], centerTitle: true, foregroundColor: Colors.white, iconTheme: IconThemeData(color: Colors.white),),
      drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[900], shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20),),),),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),),),
      scaffoldBackgroundColor: Colors.grey[850],
      cardColor: Colors.grey[800],
      dialogTheme: DialogThemeData(backgroundColor: Colors.grey[800]),
      dividerColor: Colors.grey[700],
    );
  }
}