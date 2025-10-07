import 'package:flutter/material.dart';

class PurchaseAdd extends StatelessWidget {
  const PurchaseAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: (){}, child: Text("Product")),
          TextButton(onPressed: (){}, child: Text("Supplier")),
        ],
      ),
    );
  }
}