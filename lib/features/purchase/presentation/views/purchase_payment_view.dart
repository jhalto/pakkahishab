import 'package:flutter/material.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/add_purchase_payment_type_widget.dart';

class PurchasePaymentView extends StatelessWidget {
  
  const PurchasePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Make Payment"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(child: Text("Total Due:")),
                Expanded(child: Text("1241255")),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: Text("Present purchase:")),
                Expanded(child: Text("2500")),
              ],
            ),
            SizedBox(height: 20),
            AddPurchasePaymentTypeWidget(),
          ],
        ),
      ),
    );
  }
}
