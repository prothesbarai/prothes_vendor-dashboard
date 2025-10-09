import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prothesvendordashboard/pages/authentication/login_page.dart';
import 'package:prothesvendordashboard/pages/authentication/registration_page.dart';
import 'package:prothesvendordashboard/pages/dashboard/pro_dashboard.dart';
import 'package:prothesvendordashboard/providers/dashboard_settings_provider.dart';
import 'package:prothesvendordashboard/providers/items_provider.dart';
import 'package:prothesvendordashboard/utils/constant/app_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ItemsProvider(),),
          ChangeNotifierProvider(create: (context) => DashboardSettingsProvider(),),
        ],
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 869),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          appBarTheme: AppBarThemeData(backgroundColor: AppColors.primaryColor,centerTitle: true,foregroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.white)),
          drawerTheme: DrawerThemeData(backgroundColor: AppColors.primaryColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)))),
          elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),))
        ),
        home: RegistrationPage(),
      ),
    );
  }
}

