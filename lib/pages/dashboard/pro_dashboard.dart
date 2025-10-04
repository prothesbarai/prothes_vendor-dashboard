import 'package:flutter/material.dart';
import 'package:prothesvendordashboard/pages/dashboard/items_list.dart';
import 'package:prothesvendordashboard/widgets/custom_drawer.dart';
import 'add_items.dart';

class ProDashboard extends StatelessWidget {
  const ProDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pro Dashboard"),),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddItems()),),
              child: const Text("Add Items"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ItemsList()),),
              child: const Text("View Items"),
            ),
          ],
        ),
      ),
    );
  }
}
