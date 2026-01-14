import 'package:flutter/material.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';

class EditPurchaseSupplierWidget extends StatelessWidget {
  final PurchaseItem purchaseHead;
  const EditPurchaseSupplierWidget({super.key, required this.purchaseHead});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 15),
            Text(purchaseHead.supplierName.toString()),
          ],
        ),
      ),
    );
  }
}
