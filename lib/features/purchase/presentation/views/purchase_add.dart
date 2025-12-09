import 'package:flutter/material.dart';

import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/puchase_supplier_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/invoice_name_date_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_product_widget.dart';




class PurchaseAdd extends StatelessWidget {
  const PurchaseAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Add Purchase"),
      body: Column(
        children: [
            InvoiceNameDateWidget(),
            SizedBox(height: 10,),
            PurchaseSupplierWidget(),
            SizedBox(height: 10,),
            PurchaseProductWidget(),

        ],
      ),
    );
  }
}