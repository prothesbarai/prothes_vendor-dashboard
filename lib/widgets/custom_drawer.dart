import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prothesvendordashboard/utils/constant/app_colors.dart';
import 'package:provider/provider.dart';

import '../pages/authentication/login_page.dart';
import '../pages/dashboard/pro_dashboard.dart';
import '../providers/dashboard_settings_provider.dart';

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

    return Drawer(
      backgroundColor: AppColors.primaryColor.withValues(alpha: 0.95),
      child: SafeArea(
        child: Column(
          children: [
            /// >>> =================== Drawer Header ==========================
            GestureDetector(
              onTap: () {},
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white24, width: 0.8.h),),),
                child: Row(
                  children: [
                    CircleAvatar(radius: 35.r, backgroundColor: Colors.white,),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Owner Name", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                          SizedBox(height: 6.h),
                          Text("prothes16@email.com", style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
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
                  _buildItem(context, "Orders", Icons.shopping_bag_outlined, onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProDashboard()), (Route<dynamic> route) => false,)),
                  _buildItem(context, "Products", Icons.inventory_2_outlined, onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProDashboard()), (Route<dynamic> route) => false,)),
                  _buildItem(context, "Messages", Icons.chat_outlined, onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProDashboard()), (Route<dynamic> route) => false,)),

                  // Switch Button Shop Open / Close
                  _buildItem(context, customSettings.isPlayOrPause ? "Play" : "Pause", customSettings.isPlayOrPause?Icons.play_circle_outline_outlined:Icons.pause_circle_outline, showSwitch: true, switchValue: customSettings.isPlayOrPause,onSwitchChanged :(val) => customSettings.togglePlayPauseStatus(),),
                  _buildItem(context, "Settings", Icons.settings_outlined, onTap: (){Navigator.pop(context);Navigator.push(context, MaterialPageRoute(builder: (context) => ProDashboard(),));}),
                  _buildItem(context, "Help & Support", Icons.help_outline, onTap: (){Navigator.pop(context);Navigator.push(context, MaterialPageRoute(builder: (context) => ProDashboard(),));}),
                ],
              ),
            ),
            /// <<< =================== Drawer Items ===========================


            /// >>> =================== Logout Bottom ==========================
            Divider(color: Colors.white24),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white, size: 30.sp),
              title: Text("Logout", style: TextStyle(color: Colors.white, fontSize: 15.sp),),
              onTap: () {
                // Logout logic
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      ElevatedButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: () async{
                            // Clear Hive >>>>>> Then
                            if(mounted) _navigateLoginPage();
                          },
                          child: const Text("Logout")
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
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 28.sp, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 15.sp)),
      trailing: showSwitch ? Switch(value: switchValue, onChanged: onSwitchChanged, activeThumbColor: Colors.white, inactiveThumbColor: Colors.grey,) : const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white38, size: 16),
    );
  }
  /// <<< ========================= Drawer Item Widget =========================

}
