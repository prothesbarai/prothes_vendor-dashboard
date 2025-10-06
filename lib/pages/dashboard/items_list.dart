import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/items_provider.dart';
import 'add_items.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ItemsProvider>(context).products;
    return Scaffold(
      appBar: AppBar(title: const Text("My Products")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            margin: const EdgeInsets.all(8),
            child: Stack(
              children: [
                ListTile(
                  leading: product.imagePath.isNotEmpty ? Image.file(File(product.imagePath), width: 50.w, height: 50.h, fit: BoxFit.cover) : const Icon(Icons.image),
                  title: Text(product.name),
                  subtitle: Text("${product.category} - \$${product.price}"),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => AddItems(editProduct: product)),);
                      } else if (value == 'make_featured') {
                        Provider.of<ItemsProvider>(context, listen: false).toggleFeatured(product.id);
                      }else if (value == 'remove_featured') {
                        Provider.of<ItemsProvider>(context, listen: false).toggleFeatured(product.id);
                      } else if (value == 'delete') {
                        Provider.of<ItemsProvider>(context, listen: false).deleteProduct(product.id);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text("Edit")),
                      PopupMenuItem(value: product.isFeatured ? 'remove_featured' : 'make_featured', child: Text(product.isFeatured ? "Remove Featured" : "Make Featured")),
                      const PopupMenuItem(value: 'delete', child: Text("Delete")),
                    ],
                  ),
                ),


                if (product.isFeatured)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: CustomPaint(
                      size: Size(40.w, 40.h), // Triangle Size
                      painter: FeaturedTrianglePainter(),
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
    final paint = Paint()..color = Colors.orange;
    final path = Path();
    // Top Left Triangle
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
    // Featured Text
    final textSpan = TextSpan(text: "FEATURED", style: TextStyle(color: Colors.white, fontSize: 6.sp, fontWeight: FontWeight.bold,),);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr,);
    textPainter.layout();
    double approxHypo = (size.width + size.height) / 1.4;
    double offset = (approxHypo / 2) - (textPainter.width / 2);
    // Canvas Transform according to diagonal
    canvas.save();
    canvas.translate(0, size.height);
    canvas.rotate(-45 * 3.1416 / 180);
    // Text Center
    textPainter.paint(canvas, Offset(offset, -textPainter.height / 0.6));
    canvas.restore();
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
