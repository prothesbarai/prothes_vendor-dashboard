import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prothesvendordashboard/pages/dashboard/dashborad_item_pages/items_list.dart';
import 'package:prothesvendordashboard/providers/items_provider.dart';
import 'package:prothesvendordashboard/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/constant/app_colors.dart';
import '../../widgets/exit_app_alert_dialogue.dart';
import 'dashborad_item_pages/add_items.dart';
import 'dashborad_item_pages/order_pages.dart';
import 'dashborad_item_pages/publish_items_page.dart';
import 'dashborad_item_pages/settings_page.dart';

class ProDashboard extends StatelessWidget {
  const ProDashboard({super.key});

  @override
  Widget build(BuildContext context) {

    final itemCount = Provider.of<ItemsProvider>(context).totaItems;

    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, dynamic) {  if (didPop) {return;}  BasicAlertDialogue.willPopScope(context);},
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Pro Dashboard"),
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              ),
              drawer: CustomDrawer(),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(height: 20.h,),

                      Expanded(
                        child: GridView(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.3,),
                          children: [
                            _dashboard(title: "Add Items", icon: Icons.add_box_outlined, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const AddItems()),);},),
                            _dashboard(title: "View Items", icon: Icons.list_alt_outlined, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const ItemsList()),);},qty: itemCount.toString()),

                            _dashboard(title: "Publish Items", icon: Icons.publish_sharp, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const PublishItemsPage()),);},qty: "0"),
                            _dashboard(title: "View Orders", icon: Icons.list_alt_outlined, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderPages()),);},qty: "0"),
                            _dashboard(title: "Settings", icon: Icons.settings, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()),);},),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          );
        },
    );
  }





  /// >>> Dashboard Item Builder Start Here ====================================
  Widget _dashboard({required String title, required IconData icon, required VoidCallback onTap, String? qty,}) {
    return Consumer(
        builder: (context, themeProvider, child) {
          return GestureDetector(
            onTap: onTap,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              color: Theme.of(context).cardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon and Badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(icon, size: 48.sp, color: AppColors.primaryColor),
                      if (qty != null && qty.isNotEmpty)
                        Positioned(
                          right: -6.w,
                          top: -6.h,
                          child: Container(
                            padding: EdgeInsets.all(6.sp),
                            decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5),),
                            child: Text(qty, style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold,),),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.primaryColor,),textAlign: TextAlign.center,),
                ],
              ),
            ),
          );
        },
    );
  }
  /// <<< Dashboard Item Builder End Here ======================================

}
