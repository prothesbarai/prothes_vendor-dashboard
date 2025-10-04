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
            child: ListTile(
              leading: product.imagePath.isNotEmpty ? Image.file(File(product.imagePath), width: 50.w, height: 50.h, fit: BoxFit.cover) : const Icon(Icons.image),
              title: Text(product.name),
              subtitle: Text("${product.category} - \$${product.price}"),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AddItems(editProduct: product),),);
                  } else if (value == 'delete') {
                    Provider.of<ItemsProvider>(context, listen: false).deleteProduct(product.id);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text("Edit")),
                  const PopupMenuItem(value: 'delete', child: Text("Delete")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
