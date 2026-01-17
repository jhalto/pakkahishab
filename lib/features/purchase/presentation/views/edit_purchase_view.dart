import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_fullwidth_button.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchse_update_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_invoice_name_date_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_purchase_product_item_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_purchase_product_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_purchase_summary.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_purchase_supplier_widget.dart';

class EditPurchaseView extends StatelessWidget {
  final PurchaseItem purchaseHead;
  const EditPurchaseView({super.key, required this.purchaseHead});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => ModalProgressHUD(
        inAsyncCall: ref.watch(purchaseUpdateViewModel).editLoading,
        progressIndicator: loader,
        child: Scaffold(
          appBar: CustomAppbarBack(title: "Edit Purchase"),
          body: Consumer(
            builder: (context, ref, child) {
              if (ref.watch(purchaseUpdateViewModel).isLoading) {
                return Center(child: loader);
              }
        
              return Column(
                children: [
                  EditInvoiceNameDateWidget(purchaseHead: purchaseHead),
                  SizedBox(height: 10),
                  EditPurchaseSupplierWidget(purchaseHead: purchaseHead),
                  SizedBox(height: 10),
                  EditPurchaseProductWidget(),
                  SizedBox(height: 10),
                  EditPurchaseProductItemWidget(purchaseHead: purchaseHead),
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
                                .read(purchaseUpdateViewModel.notifier) 
                                .updatePurchase(
                                  context,
                                  purchaseId: purchaseHead.purchaseId.toString(),
                                  purchaseNo: purchaseHead.purchaseNo.toString(),
                                );
                          },
                          title: "Update",
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
