import 'package:flutter/material.dart';

class SaleAdd extends StatelessWidget {
  const SaleAdd({super.key});

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