import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_fullwidth_button.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/views/purchase_payment_view.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/add_purchase_payment_type_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/add_purchase_summury.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/puchase_supplier_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/invoice_name_date_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_product_item_widget.dart';
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
          SizedBox(height: 10),
          PurchaseSupplierWidget(),
          SizedBox(height: 10),
          PurchaseProductWidget(),
          SizedBox(height: 10),
          PurchaseProductItemWidget(),
          SizedBox(height: 10),
          AddPurchaseSummury(),
          // SizedBox(height: 20),
          // AddPurchasePaymentTypeWidget(),

          SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Consumer(
              builder: (context, ref, child) {
                return CustomFullwidthButton(
                  onTap: () async {
                    ref
                        .read(purchaseAddViewModelProvider.notifier)
                        .addPurchase(context);
                    
                  },
                  title: "Add",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
