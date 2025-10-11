import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/items_provider.dart';
import '../../../utils/constant/app_colors.dart';
import 'add_items.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ItemsProvider>(context).products;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text("My Products")),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => SizedBox(height: 8.h),
        itemBuilder: (context, index) {
          final product = products[index];


          return Card(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r),),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: Container(
                      color: product.isAvailable ? Colors.green.withValues(alpha: 0.2) : Colors.white,
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: product.imagePath.isNotEmpty ? Image.file(File(product.imagePath), width: 50.w, height: 50.h, fit: BoxFit.cover,) :
                            Container(
                              width: 50.w,
                              height: 50.h,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.image, color: Colors.grey),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                                SizedBox(height: 4.h),
                                Text("${product.category} - \$${product.price}", style: TextStyle(fontSize: 12.sp, color: Colors.grey[700])),
                              ],
                            ),
                          ),

                          // Popup menu
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => AddItems(editProduct: product),),);
                              } else if (value == 'make_featured' || value == 'remove_featured') {
                                Provider.of<ItemsProvider>(context, listen: false).toggleFeatured(product.id);
                              } else if (value == 'toggle_stock') {
                                product.isAvailable = !product.isAvailable;
                                Provider.of<ItemsProvider>(context, listen: false).updateProduct(product);
                              } else if (value == 'delete') {
                                Provider.of<ItemsProvider>(context, listen: false).deleteProduct(product.id);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'edit', child: Text("Edit")),
                              PopupMenuItem(value: product.isFeatured ? 'remove_featured' : 'make_featured',child: Text(product.isFeatured ? "Remove Featured" : "Make Featured"),),
                              PopupMenuItem(value: 'toggle_stock', child: Text(product.isAvailable ? "Out of Stock" : "In Stock"),),
                              const PopupMenuItem(value: 'delete', child: Text("Delete")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (product.isFeatured)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r),),
                        child: CustomPaint(
                          size: Size(35.w, 35.h),
                          painter: FeaturedTrianglePainter(),
                        ),
                      ),
                    ),
                ],
              ),
            );


        },
      ),
    );
  }
}




class FeaturedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.primaryColor;
    final path = Path();
    // Top Left Triangle
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
    // Featured Text
    final textSpan = TextSpan(text: "FEATURED", style: TextStyle(color: Colors.white, fontSize: 5.sp, fontWeight: FontWeight.bold,),);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr,);
    textPainter.layout();
    double approxHypo = (size.width + size.height) / 1.4;
    double offset = (approxHypo / 2) - (textPainter.width / 2);
    // Canvas Transform according to diagonal
    canvas.save();
    canvas.translate(0, size.height);
    canvas.rotate(-45 * 3.1416 / 180);
    // Text Center
    textPainter.paint(canvas, Offset(offset, -textPainter.height / 0.5));
    canvas.restore();
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

