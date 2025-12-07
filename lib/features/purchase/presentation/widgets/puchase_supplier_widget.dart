import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/global_widgets/custom_pakka_form_field.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/features/purchase/data/models/all_supplier_model.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';

class PurchaseSupplierWidget extends StatelessWidget {
  const PurchaseSupplierWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final _vm = ref.watch(purchaseAddViewModelProvider);
        final _vmn = ref.watch(purchaseAddViewModelProvider.notifier);
        final allCustomers = _vm.filteredSupplier ?? [];

        if (allCustomers.isEmpty) {
          return CircularProgressIndicator();
        }
        print("customer $allCustomers");

        return Row(
          children: [
            SizedBox(width: 10),
            Expanded(
              child: DropdownSearch<AllSupplier>(
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
                itemAsString: (AllSupplier c) => c.supplierName,

                // Selected item - uncomment when ready
                // selectedItem: addViewModel.selectedCustomer,

                // Compare function
                compareFn: (AllSupplier a, AllSupplier b) =>
                    a.supplierId == b.supplierId,

                popupProps: PopupProps.menu(
                  menuProps: MenuProps(
                    backgroundColor: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // 👈 popup border radius
                  ),

                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "সাপ্লায়ার খুঁজুন...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                       contentPadding: EdgeInsets.zero,
                      fillColor: Colors.grey.shade100,
                      border: InputBorder.none,
                    ),
                  ),
                ),

                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: "সাপ্লায়ার নির্বাচন করুন",
                    filled: true,
                     contentPadding: EdgeInsets.zero,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),

                onChanged: (AllSupplier? value) {
                  _vmn.updateSupplierId(value!.supplierId);
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
                              "Add New Supplier",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 20),

                            Form(
                              key: _vmn.customerAddFormKey,
                              child: Column(
                                children: [
                                  /// NAME REQUIRED
                                  CustomPakkaFormField(
                                    controller: _vmn.customerNameController,

                                    label: "Customer Name *",

                                    validator: (value) =>
                                        Validation.validateName(value, context),
                                  ),
                                  SizedBox(height: 12),

                                  /// PHONE REQUIRED
                                  CustomPakkaFormField(
                                    controller: _vmn.customerPhoneController,
                                    label: "Customer Phone *",
                                    validator: (value) =>
                                        Validation.validatePhone(
                                          value,
                                          context,
                                        ),
                                  ),
                                  SizedBox(height: 12),

                                  CustomPakkaFormField(
                                    controller: _vmn.customerEmailController,
                                    label: "Customer Email",
                                  ),
                                  SizedBox(height: 12),

                                  CustomPakkaFormField(
                                    controller: _vmn.customerAddressController,
                                    label: "Customer Address",
                                  ),
                                  SizedBox(height: 12),

                                  CustomPakkaFormField(
                                    controller:
                                        _vmn.customerOpeningBalanceController,
                                    label: "Opening Balance",
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
                                  if (_vmn.customerAddFormKey.currentState!
                                      .validate()) {
                                    await _vmn.addSupplier();

                                    Navigator.pop(context);
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
