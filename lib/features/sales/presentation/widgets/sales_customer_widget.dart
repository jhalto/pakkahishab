import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/global_widgets/custom_pakka_form_field.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/features/sales/data/models/all_customer_model.dart';
import 'package:pakkahishab/features/sales/presentation/viewmodels/sales_add_viewmodel.dart';

class SalesCustomerWidget extends StatelessWidget {
  const SalesCustomerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final addViewModel = ref.watch(saleAddViewModelProvider);
        final vmn = ref.watch(saleAddViewModelProvider.notifier);
        final allCustomers = addViewModel.customer?.items ?? [];

        if (allCustomers.isEmpty) {
          return CircularProgressIndicator();
        }
        print("customer $allCustomers");

        return Row(
          children: [
            SizedBox(width: 10),
            Expanded(
              child: DropdownSearch<AllCustomer>(
                // REQUIRED: Return Future<List<Customer>>
                items: (filter, loadProps) async {
                  return allCustomers;
                },

                // SEARCH FUNCTION - Filter based on user input
                filterFn: (customer, filter) {
                  return customer.supplierName.toLowerCase().contains(
                    filter.toLowerCase(),
                  );
                },

                // Show customer name
                itemAsString: (AllCustomer c) => c.supplierName,

                // Selected item - uncomment when ready
                // selectedItem: addViewModel.selectedCustomer,

                // Compare function
                compareFn: (AllCustomer a, AllCustomer b) =>
                    a.supplierId == b.supplierId,

                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "কাস্টমার খুঁজুন...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: InputBorder.none,
                    ),
                  ),
                ),

                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: "কাস্টমার নির্বাচন করুন",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),

                onChanged: (AllCustomer? value) {
                  vmn.updateCustomerId(value!.supplierId);
                },
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: AppColors.whiteColor,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewPadding.bottom,
                        left: 18,
                        right: 18,
                        top: 20,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            SizedBox(height: 20),

                            Text(
                              "Add New Customer",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 20),

                            Form(
                              key: vmn.customerAddFormKey,
                              child: Column(
                                children: [
                                  /// NAME REQUIRED
                                  CustomPakkaFormField(
                                    controller: vmn.customerNameController,

                                    label: "Customer Name *",

                                    validator: (value) =>
                                        Validation.validateName(value, context),
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 12),

                                  /// PHONE REQUIRED
                                  CustomPakkaFormField(
                                    controller: vmn.customerPhoneController,
                                    label: "Customer Phone *",
                                    validator: (value) =>
                                        Validation.validatePhone(
                                          value,
                                          context,
                                        ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 12),

                                  CustomPakkaFormField(
                                    controller: vmn.customerEmailController,
                                    label: "Customer Email",
                                    textInputAction: TextInputAction.next,
                                  ),

                                  SizedBox(height: 12),

                                  CustomPakkaFormField(
                                    controller: vmn.customerAddressController,
                                    label: "Customer Address",
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 12),

                                  CustomPakkaFormField(
                                    controller:
                                        vmn.customerOpeningBalanceController,
                                    label: "Opening Balance",
                                    textInputAction: TextInputAction.done,
                                    onComplete: () async {
                                      if (vmn.customerAddFormKey.currentState!
                                          .validate()) {
                                        await vmn.addCustomer(context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20),

                            /// SUBMIT BUTTON
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  if (vmn.customerAddFormKey.currentState!
                                      .validate()) {
                                    await vmn.addCustomer(context);
                                  }
                                },
                                child: Text(
                                  "Save Customer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.all(14),
                child: Icon(Icons.add, color: AppColors.whiteColor),
              ),
            ),
            SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
