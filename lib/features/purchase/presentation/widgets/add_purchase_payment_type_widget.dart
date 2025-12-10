import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';

class AddPurchasePaymentTypeWidget extends StatelessWidget {
  const AddPurchasePaymentTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Consumer(
          builder: (context, ref, child) {
            final _vmn = ref.watch(purchaseAddViewModelProvider.notifier);
            final _vm = ref.watch(purchaseAddViewModelProvider);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Payment",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        
                         borderRadius: BorderRadius.all(Radius.circular(10)),
                         dropdownColor: AppColors.whiteColor,
                        value: _vm.purchaseType, // Shows selected value
                        onChanged: (value) {
                          if (value != null) {
                            _vmn.updatePurchaseType(value);
                          }
                        },
                        items: const [
                          DropdownMenuItem(value: "Cash", child: Text("Cash")),
                          DropdownMenuItem(
                            value: "Credit",
                            child: Text("Credit"),
                          ),
                          // DropdownMenuItem(value: "Due", child: Text("Due")),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (_vm.purchaseType == 'Cash')
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  dropdownColor: AppColors.whiteColor,

                                  iconSize: 28,
                                  iconEnabledColor: AppColors.primaryColor,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  value: _vm.paymentMethod,
                                  hint: const Text("Choose method"),
                                  items: const [
                                    DropdownMenuItem(
                                      value: "Cash",
                                      child: Text("Cash"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Bkash",
                                      child: Text("Bkash"),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    _vmn.updatePaymentMethod(value!);
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: AppColors.dotColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete_outline,
                                color: AppColors.dotColor,
                              ),
                            ),
                            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
