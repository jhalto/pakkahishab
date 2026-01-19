import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/global_widgets/custom_back_button.dart';

import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/features/purchase/data/models/all_product_model.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';

import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchse_update_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/views/edit_purchase_view.dart';

class PurchaseDetailsAppbarBack extends StatelessWidget
    implements PreferredSizeWidget {
  final PurchaseItem purchase;
  final String title;
  const PurchaseDetailsAppbarBack({
    super.key,
    required this.title,
    required this.purchase,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: CustomBackButton(),
      centerTitle: false,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
      ),
      actions: [
        Consumer(
          builder: (context, ref, child) {
            return IconButton(
              onPressed: () {
                final items = ref
                    .read(purchaseViewModelProvider)
                    .purchaseDetails!
                    .items;

                final editProducts = items
                    .map((e) => e.toEditProduct())
                    .toList();

                ref
                    .read(purchaseUpdateViewModel.notifier)
                    .loadPurchaseEditProduct(editProducts);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditPurchaseView(purchaseHead: purchase),
                  ),
                );
              },
              icon: Icon(Icons.edit, color: AppColors.whiteColor),
            );
          },
        ),
        // Consumer(
        //   builder: (context, ref, child) {

        //     return IconButton(
        //       onPressed: () {
        //         final items = ref
        //             .read(purchaseViewModelProvider)
        //             .purchaseDetails!
        //             .items;

        //         final returnProducts = items
        //             .map((e) => e.toEditProduct())
        //             .toList();

        //         ref
        //             .read(purchaseReturnViewModel.notifier)
        //             .loadPurchaseEditProduct(returnProducts);
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) =>
        //                 PurchaseReturnAddView(purchaseHead: purchase),
        //           ),
        //         );
        //       },
        //       icon: Icon(Icons.rotate_left, color: AppColors.whiteColor),
        //     );
        //   },
        // ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor2, AppColors.primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
