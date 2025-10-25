import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../widgets/share_button_option_bottomshade.dart';

class ProfilePageTwo extends StatefulWidget {
  const ProfilePageTwo({super.key});

  @override
  State<ProfilePageTwo> createState() => _ProfilePageTwoState();
}

class _ProfilePageTwoState extends State<ProfilePageTwo> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(title: const Text("Profile Two"),elevation: 0,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// >>> Store Cover Photo + Logo Section
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider('https://img.freepik.com/premium-photo/young-woman-black-dress-holds-shopping-bags-emotionally-raised-up-hands-pink-background_136403-14012.jpg',),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 45.r,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 40.r,
                      backgroundImage: CachedNetworkImageProvider('https://cdn-icons-png.flaticon.com/512/3135/3135715.png',),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.h),

            /// >>> Store Information Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Text('Your Store', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.black87,),),
                  Text('Sub Title', style: TextStyle(fontSize: 15.sp, color: Colors.grey[700],),),
                  SizedBox(height: 10.h),

                  /// >>> Rating Section =======================================
                  RatingBarIndicator(
                    rating: 4.5,
                    itemCount: 5,
                    itemSize: 25,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                  ),
                  Text('4.5 (120 reviews)', style: TextStyle(color: Colors.grey[600]),),
                  SizedBox(height: 10.h),

                  /// >>> ================= Basic Info Cards ===================
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow(Icons.store, 'Store Type', 'Grocery'),
                          _infoRow(Icons.phone, 'Phone', '+880 1317 818826'),
                          _infoRow(Icons.email, 'Email', 'contact@abc.com'),
                          _infoRow(Icons.location_on, 'Address', 'Dhaka, Bangladesh'),
                          _infoRow(Icons.delivery_dining, 'Delivery Range', '5 km'),
                          _infoRow(Icons.currency_exchange, 'Min Order Amount', '৳200'),
                          _infoRow(Icons.attach_money, 'Delivery Charge', '৳30–৳70'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// >>> ==================== About Section ===================
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('About Store', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.teal,),),
                          SizedBox(height: 8.h),
                          Text('ABC Store is your one-stop grocery store delivering fresh essentials right to your doorstep. We focus on quality, fast delivery, and customer satisfaction.', style: TextStyle(fontSize: 14.sp, color: Colors.grey[800], height: 1.5,),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// >>> Trade License Info ===================================
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Trade License', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.teal,),),
                          SizedBox(height: 10.h),
                          _infoRow(Icons.description, 'License No.', 'TL-987654321'),
                          SizedBox(height: 8.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: 'https://imgv2-2-f.scribdassets.com/img/document/810500606/original/3402c8774e/1?v=1',
                              width: double.infinity,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  SizedBox(height: 30.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
                        child: Text("Quick Actions",textAlign: TextAlign.start,style: TextStyle(fontSize: 17.sp),),
                      ),
                      Row(
                        children: [
                          Expanded(child: _buildActionButton(icon: LucideIcons.edit3, label: "Edit Profile", color: const Color(0xFF6C63FF), onTap: () {},),),
                          const SizedBox(width: 15),
                          Expanded(child: _buildActionButton(icon: LucideIcons.share2, label: "Share", color: Colors.black87, onTap: () {showShareOptions(context);}, outlined: true,),),
                        ],
                      ),
                    ],
                  ),


                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// >>> Information Row Builder ==============================================
  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.teal),
          SizedBox(width: 10.w),
          Expanded(child: Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold),),),
          Expanded(flex: 2, child: Text(value, style: const TextStyle(color: Colors.black87),),),
        ],
      ),
    );
  }


  // >>> Action Button Section
  Widget _buildActionButton({required IconData icon, required String label, required Color color, required VoidCallback onTap, bool outlined = false,}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: outlined ? Colors.transparent : color, border: outlined ? Border.all(color: Colors.black26) : null, borderRadius: BorderRadius.circular(30),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: outlined ? Colors.black87 : Colors.white),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: outlined ? Colors.black87 : Colors.white, fontWeight: FontWeight.bold, fontSize: 14,),),
          ],
        ),
      ),
    );
  }

}