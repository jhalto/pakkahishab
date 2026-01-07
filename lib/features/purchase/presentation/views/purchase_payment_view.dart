import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_fullwidth_button.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/add_purchase_payment_type_widget.dart';

class PurchasePaymentView extends StatelessWidget {
  const PurchasePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Make Payment"),
      body: Consumer(
        builder: (context, ref, child) {
          final vm = ref.watch(purchaseAddViewModelProvider);
          final vmn = ref.watch(purchaseAddViewModelProvider.notifier);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(child: Text("Total Due")),
                    Expanded(child: Text(": ${vm.totalDueAmount ?? 0}")),
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(child: Text("Previous Due")),
                    Expanded(
                      child: Text(
                        ": ${((double.tryParse(vm.totalDueAmount ?? '0') ?? 0) - (double.tryParse(vm.purchaseTotalAmount ?? '0') ?? 0)).toStringAsFixed(0)}",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Text("Present purchase")),
                    Expanded(child: Text(": ${vm.purchaseTotalAmount}")),
                  ],
                ),
                SizedBox(height: 20),
                AddPurchasePaymentTypeWidget(),

                SizedBox(height: 20),
                CustomFullwidthButton(
                  onTap: () async {
                    vmn.makePayment(context);
                  },
                  title: "Pay",
                ),
               
              ],
            ),
          );
        },
      ),
    );
  }
}

