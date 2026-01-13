import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_fullwidth_button.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/add_purchase_payment_type_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/edit_widgets/edit_invoice_name_date_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/edit_widgets/edit_purchase_product_item_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/edit_widgets/edit_purchase_product_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/edit_widgets/edit_purchase_summary.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/edit_widgets/edit_purchase_supplier_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/puchase_supplier_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_product_item_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_product_widget.dart';

class EditPurchaseView extends StatelessWidget {
  final PurchaseItem purchaseHead;
  const EditPurchaseView({super.key, required this.purchaseHead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Edit Purchase"),
      body: Column(
        children: [
          EditInvoiceNameDateWidget(purchaseHead: purchaseHead,),
          SizedBox(height: 10),
          EditPurchaseSupplierWidget(purchaseHead: purchaseHead,),
          SizedBox(height: 10),
          EditPurchaseProductWidget(),
          SizedBox(height: 10),
          EditPurchaseProductItemWidget(),
          SizedBox(height: 10),
          EditPurchaseSummury(),

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
