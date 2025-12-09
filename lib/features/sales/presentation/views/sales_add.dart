import 'package:flutter/material.dart';

import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/features/sales/presentation/widgets/invoice_name_date_widget.dart';
import 'package:pakkahishab/features/sales/presentation/widgets/sales_customer_widget.dart';
import 'package:pakkahishab/features/sales/presentation/widgets/sales_product_add.dart';


class SaleAdd extends StatelessWidget {
  const SaleAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Sales"),
      body: Column(
        children: [
            InvoiceNameDateWidget(),
            SizedBox(height: 10,),
            SalesCustomerWidget(),
            SalesProductAdd(),

        ],
      ),
    );
  }
}