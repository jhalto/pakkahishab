import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_fullwidth_button.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/update_purchase_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_add_widgets/add_purchase_payment_type_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_invoice_name_date_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_purchase_product_item_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_purchase_product_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_purchase_summary.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_purchase_supplier_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_add_widgets/puchase_supplier_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_add_widgets/purchase_product_item_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_add_widgets/purchase_product_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_return_widgets/return_invoice_name_date_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_return_widgets/return_purchase_product_item_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_return_widgets/return_purchase_product_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_return_widgets/return_purchase_summary.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_return_widgets/return_purchase_supplier_widget.dart';

class PurchaseReturnAddView extends StatelessWidget {
  final PurchaseItem purchaseHead;
  const PurchaseReturnAddView({super.key, required this.purchaseHead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Edit Purchase"),
      body: Column(
        children: [
          ReturnInvoiceNameDateWidget(purchaseHead: purchaseHead,),
          SizedBox(height: 10),
          ReturnPurchaseSupplierWidget(purchaseHead: purchaseHead,),
          SizedBox(height: 10),
          ReturnPurchaseProductWidget(),
          SizedBox(height: 10),
          ReturnPurchaseProductItemWidget(),
          SizedBox(height: 10), 
          ReturnPurchaseSummury(),

          SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Consumer(
              builder: (context, ref, child) {
                return CustomFullwidthButton(
                  onTap: () async {
                    ref
                        .read(purchaseUpdateViewModel.notifier)
                        .updatePurchase(context, purchaseId: purchaseHead.purchaseId.toString());
                  },
                  title: "Update",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
