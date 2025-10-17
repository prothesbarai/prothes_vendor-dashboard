import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prothesvendordashboard/pages/dashboard/dashborad_item_pages/items_list.dart';
import 'package:prothesvendordashboard/pages/dashboard/dashborad_item_pages/order_pages.dart';
import 'package:prothesvendordashboard/pages/dashboard/dashborad_item_pages/settings_page.dart';
import 'package:prothesvendordashboard/utils/constant/app_colors.dart';
import 'package:provider/provider.dart';

import '../pages/authentication/login_page.dart';
import '../pages/dashboard/pro_dashboard.dart';
import '../pages/drawer_pages/help_support_page.dart';
import '../providers/dashboard_settings_provider.dart';
import '../providers/theme_provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {


  /// >>> After Logout Remove Hive And Show Login Page =========================
  void _navigateLoginPage(){
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false,);
  }
  /// <<< After Logout Remove Hive And Show Login Page =========================






  @override
  Widget build(BuildContext context) {

    final customSettings = Provider.of<DashboardSettingsProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark ? Colors.grey[900] : AppColors.primaryColor,
      child: SafeArea(
        child: Column(
          children: [
            /// >>> =================== Drawer Header ==========================
            GestureDetector(
              onTap: () {},
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: themeProvider.themeMode == ThemeMode.dark? Colors.grey[700]!: Colors.white24, width: 0.8.h),),),
                child: Row(
                  children: [
                    CircleAvatar(radius: 35.r, backgroundColor: Colors.white,),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Owner Name", style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ?AppColors.primaryColor:Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                          SizedBox(height: 6.h),
                          Text("prothes16@email.com", style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ?AppColors.primaryColor:Colors.white, fontSize: 13.sp)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            /// <<< =================== Drawer Header ==========================


            /// >>> =================== Drawer Items ===========================
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  _buildItem(context, "Dashboard", Icons.dashboard_outlined, onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProDashboard()), (Route<dynamic> route) => false,)),
                  _buildItem(context, "Orders", Icons.shopping_bag_outlined, onTap: (){Navigator.pop(context);Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPages(),));}),
                  _buildItem(context, "Products", Icons.inventory_2_outlined, onTap: (){Navigator.pop(context);Navigator.push(context, MaterialPageRoute(builder: (context) => ItemsList(),));}),
                  _buildItem(context, "Messages", Icons.chat_outlined, onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProDashboard()), (Route<dynamic> route) => false,)),

                  // Switch Button Shop Open / Close
                  _buildItem(context, customSettings.isPlayOrPause ? "Play" : "Pause", customSettings.isPlayOrPause?Icons.play_circle_outline_outlined:Icons.pause_circle_outline, showSwitch: true, switchValue: customSettings.isPlayOrPause,onSwitchChanged :(val) => customSettings.togglePlayPauseStatus(),),
                  _buildItem(context, "Settings", Icons.settings_outlined, onTap: (){Navigator.pop(context);Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),));}),
                  _buildItem(context, "Help & Support", Icons.help_outline, onTap: (){Navigator.pop(context);Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportPage(),));}),
                ],
              ),
            ),
            /// <<< =================== Drawer Items ===========================


            /// >>> =================== Logout Bottom ==========================
            Divider(color: Colors.white24),
            ListTile(
              leading: Icon(Icons.logout, color: themeProvider.themeMode == ThemeMode.dark ?AppColors.primaryColor:Colors.white, size: 30.sp),
              title: Text("Logout", style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ?AppColors.primaryColor:Colors.white, fontSize: 15.sp),),
              onTap: () {
                // Logout logic
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
                    title: Text("Logout",style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ? AppColors.primaryColor : Colors.black,),),
                    content: Text("Are you sure you want to logout?",style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ? AppColors.primaryColor : Colors.black,),),
                    actions: [
                      ElevatedButton(onPressed: () => Navigator.pop(ctx), child: Text("Cancel",style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black,),)),
                      ElevatedButton(
                          onPressed: () async{
                            // Clear Hive >>>>>> Then
                            if(mounted) _navigateLoginPage();
                          },
                          child: Text("Logout",style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black,),)
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 10.h),
            /// <<< =================== Logout Bottom ==========================
          ],
        ),
      ),
    );
  }


  /// >>> ========================= Drawer Item Widget =========================
  Widget _buildItem(BuildContext context, String title, IconData icon, {bool showSwitch = false, bool switchValue = false, ValueChanged<bool>? onSwitchChanged, VoidCallback? onTap,}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 28.sp, color: themeProvider.themeMode == ThemeMode.dark ? AppColors.primaryColor : Colors.white),
      title: Text(title, style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ? AppColors.primaryColor : Colors.white, fontSize: 15.sp)),
      trailing: showSwitch ? Switch(value: switchValue, onChanged: onSwitchChanged, activeThumbColor: Colors.white, inactiveThumbColor: Colors.grey,) : const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white38, size: 16),
    );
  }
  /// <<< ========================= Drawer Item Widget =========================

}
