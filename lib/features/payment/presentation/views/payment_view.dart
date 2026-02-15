import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_fullwidth_button.dart';
import 'package:pakkahishab/features/payment/presentation/viewmodels/payment_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_add_widgets/add_purchase_payment_type_widget.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Payment"),
      body: Consumer(
        builder: (context, ref, child) {
          final vm = ref.watch(paymentProvider);
          final vmn = ref.watch(paymentProvider.notifier);
          final double totalDue = double.tryParse(vm.totalDueAmount) ?? 0;
          // final double purchaseAmount =
          //     double.tryParse(vm.purchaseTotalAmount ?? "0") ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 10),

                Row(
                  children: [
                    const Expanded(child: Text("Total Due")),
                    Expanded(
                      child: Text(
                        ": ${totalDue < 0 ? totalDue.abs().toStringAsFixed(0) : "0"}",
                      ),
                    ),
                  ],
                ),
                if (totalDue != 0)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              totalDue < 0 ? "Previous Due" : "Advance paid",
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ": $totalDue",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 10),

               
                AddPurchasePaymentTypeWidget(),

                SizedBox(height: 20),
                CustomFullwidthButton(
                  onTap: () async {
                    
                  },
                  title: "Pay",
                  isLoading: vm.isLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
