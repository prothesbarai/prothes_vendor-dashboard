import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helper/date_time_helper.dart';
import 'order_details_page.dart';

class OrderPages extends StatelessWidget {
  const OrderPages({super.key});

  /// >>> Delivery Badge Status Color ==========================================
  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Processing":
        return Colors.blue;
      case "Delivered":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
  /// <<< Delivery Badge Status Color ==========================================

  @override
  Widget build(BuildContext context) {
    /// >>> Relational Orders
    final orders = [
      {
        "orderId": "ORD1001",
        "customerName": "Prothes Barai",
        "status": "Pending",
        "total": 2450.0,
        "date": DateTime.now().subtract(const Duration(hours: 3)),
        "products": [
          {"name": "Bluetooth Headphone", "price": 950.0, "qty": 1, "image": "https://www.ryans.com/storage/products/main/havit-h2590bt-pro-bluetooth-black-11714304039.webp"},
          {"name": "Power Bank 10000mAh", "price": 1500.0, "qty": 1, "image": "https://www.startech.com.bd/image/cache/catalog/power-bank/joyroom/jr-pbf12/jr-pbf12-01-500x500.webp"},
        ],
      },
      {
        "orderId": "ORD1002",
        "customerName": "Prothes Barai",
        "status": "Delivered",
        "total": 75000.0,
        "date": DateTime.now().subtract(const Duration(days: 1)),
        "products": [
          {"name": "Computer", "price": 65000.0, "qty": 1, "image": "https://www.startech.com.bd/image/cache/catalog/desktop-pc/desktop-offer/39241-500x500.webp"},
          {"name": "Smartphone", "price": 10000.0, "qty": 1, "image": "https://www.mobiledokan.co/wp-content/uploads/2025/10/Samsung-W26-Black.webp"},
        ],
      },
      {
        "orderId": "ORD1003",
        "customerName": "Hemel Barai",
        "status": "Processing",
        "total": 66500.0,
        "date": DateTime.now().subtract(const Duration(hours: 6)),
        "products": [
          {"name": "Laptop", "price": 65000.0, "qty": 1, "image": "https://www.startech.com.bd/image/cache/catalog/laptop/chuwi/herobook/herobook-pro/herobook-pro-1-500x500.jpg"},
          {"name": "Power Bank 10000mAh", "price": 1500.0, "qty": 1, "image": "https://www.startech.com.bd/image/cache/catalog/power-bank/joyroom/jr-pbf12/jr-pbf12-01-500x500.webp"},
        ],
      },
      {
        "orderId": "ORD1004",
        "customerName": "Shreyasi Madhu",
        "status": "Pending",
        "total": 75950.0,
        "date": DateTime.now().subtract(const Duration(hours: 2)),
        "products": [
          {"name": "Computer", "price": 65000.0, "qty": 1, "image": "https://www.startech.com.bd/image/cache/catalog/desktop-pc/desktop-offer/39241-500x500.webp"},
          {"name": "Smartphone", "price": 10000.0, "qty": 1, "image": "https://www.mobiledokan.co/wp-content/uploads/2025/10/Samsung-W26-Black.webp"},
          {"name": "Bluetooth Headphone", "price": 950.0, "qty": 1, "image": "https://www.ryans.com/storage/products/main/havit-h2590bt-pro-bluetooth-black-11714304039.webp"},
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: ListView.separated(
        padding: EdgeInsets.all(8.w),
        itemCount: orders.length,
        separatorBuilder: (_, _) => SizedBox(height: 4.h),
        itemBuilder: (context, index) {
          final order = orders[index];
          return InkWell(
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailsPage(order: order),),);},
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r),),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${order["orderId"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(color: _getStatusColor("${order["status"]}"), borderRadius: BorderRadius.circular(20.r),),
                          child: Text("${order["status"]}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12.sp),),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text("Customer: ${order["customerName"]}", style: TextStyle(fontSize: 14.sp)),
                    SizedBox(height: 4.h),
                    Text("Total: ৳${(order["total"] as num).toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),),
                    SizedBox(height: 4.h),
                    Text("Date: ${DateTimeHelper.formatDate(order['date'] as DateTime)}", style: TextStyle(color: Colors.grey, fontSize: 12.sp),),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
