import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';

class PurchaseDetails extends StatelessWidget {
  const PurchaseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Purchase Details"),
      body: Consumer(
        builder: (context, ref, child) {
         
        if(ref.watch(purchaseViewModelProvider).detailLoading){
          return Center(child: loader,);
        }
          final data = ref.watch(purchaseViewModelProvider).purchaseDetails;
          final item = ref
              .watch(purchaseViewModelProvider)
              .purchaseDetails!
              .items
              .first;

          return Column(
            children: [
              Container(
                // decoration: BoxDecoration(
                //   boxShadow:
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bill No: ${item.purchaseNo}"),
                    Text(
                      "Date: ${DateFormat("dd:mm:yyyy").format(item.purchaseDate!)}",
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
