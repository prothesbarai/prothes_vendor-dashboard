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
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.w),
                      decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12.r),),
                      child: Text("Featured", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold,)),
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
