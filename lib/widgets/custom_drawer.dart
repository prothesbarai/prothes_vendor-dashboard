import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prothesvendordashboard/utils/constant/app_colors.dart';
import 'package:provider/provider.dart';

import '../providers/dashboard_settings_provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {

    final customSettings = Provider.of<DashboardSettingsProvider>(context);

    return Drawer(
      child: Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            children: [

              /// >>> =================================== Drawer Header Start Here =================================
              GestureDetector(
                onTap: (){},
                child: DrawerHeader(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.primaryColor,width: 1.h)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35.r,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(width: 15.w,),
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.h,),
                              ],
                            )
                        )
                      ],
                    )
                ),
              ),
              /// <<< ===================================================== Drawer Header End Here ==================


              _buildDrawerItems(context, customSettings.isPlayOrPause ? "Play" : "Pause", customSettings.isPlayOrPause?Icons.play_circle_outline_outlined:Icons.pause_circle_outline, showSwitch: true, switchValue: customSettings.isPlayOrPause,onSwitchChanged :(val) => customSettings.togglePlayPauseStatus(),),
            ],
          )

        ],
      ),


    );
  }



  Widget _buildDrawerItems(BuildContext context,String title,IconData icon,  {bool showSwitch = false, bool switchValue = false, ValueChanged<bool>? onSwitchChanged,}){
    return ListTile(
      title: Text(title,style: TextStyle(color: Colors.white),),
      leading: Icon(icon,size: 20.sp,color: Colors.white,),
      trailing: showSwitch ? Switch(value: switchValue, onChanged: onSwitchChanged, activeThumbColor: Colors.white,) : null,
    );
  }

}
