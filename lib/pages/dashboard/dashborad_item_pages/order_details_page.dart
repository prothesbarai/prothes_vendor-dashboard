import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helper/date_time_helper.dart';
import '../../../utils/constant/app_colors.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {

    final products = order["products"] as List;

    return Scaffold(
      appBar: AppBar(title: const Text("Order Details"), elevation: 0,),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// >>> Order Information Section ==================================
            _sectionTitle("Order Information"),
            _infoRow("Order ID", order["orderId"]),
            _infoRow("Status", order["status"]),
            _infoRow("Total", "৳${order["total"]}"),
            _infoRow("Date", DateTimeHelper.formatDate(order['date'] as DateTime)),
            /// <<< Order Information Section ==================================

            SizedBox(height: 20.h),

            /// >>> Customer Information Section ===============================
            _sectionTitle("Customer Information"),
            _infoRow("Name", order["customerName"]),
            _infoRow("Phone", "+8801787654321"),
            _infoRow("Address", "Dhaka, Bangladesh"),
            /// <<< Customer Information Section ===============================

            SizedBox(height: 20.h),

            /// >>> Ordered Products Section ===================================
            _sectionTitle("Ordered Products"),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final totalPrice = (product["price"] as num) * (product["qty"] as num);
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),),
                  elevation: 1,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network("${product["image"]}", width: 50.w, height: 50.w, fit: BoxFit.cover,),
                    ),
                    title: Text("${product["name"]}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),),
                    subtitle: Text("৳${product["price"]} × ${product["qty"]} = ৳$totalPrice", style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),),
                  ),
                );
              },
            ),
            /// <<< Ordered Products Section ===================================

            SizedBox(height: 20.h),

            /// >>> Action Buttons Section =====================================
            _sectionTitle("Actions"),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {_showMessage(context, "Order marked as delivered");},
                    icon: const Icon(Icons.check_circle),
                    label: const Text("Mark as Delivered"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r),), padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w,),),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {_showMessage(context, "Order cancelled");},
                    icon: const Icon(Icons.cancel),
                    label: const Text("Cancel Order"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r),), padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w,),),
                  ),
                ),
              ],
            ),

            SizedBox(height: 100.h,),
          ],
        ),
      ),
    );
  }

  /// >>> Section Title Widget =================================================
  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.primaryColor,),),
    );
  }
  /// <<< Section Title Widget =================================================

  /// >>> Info Row Widget ======================================================
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),),
          Flexible(child: Text(value, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87), textAlign: TextAlign.right,),),
        ],
      ),
    );
  }
  /// <<< Info Row Widget ======================================================


  /// >>> Helper: Show Snack-bar Message =======================================
  void _showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.black87, behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 2),),);
  }
  /// <<< Helper: Show Snack-bar Message =======================================

}
