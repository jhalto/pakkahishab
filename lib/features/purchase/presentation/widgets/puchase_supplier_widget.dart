import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/global_widgets/custom_button.dart';
import 'package:pakkahishab/core/global_widgets/custom_pakka_form_field.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/purchase/data/models/all_supplier_model.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/update_purchase_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/views/update_supplier_view.dart';

class PurchaseSupplierWidget extends ConsumerStatefulWidget {
  const PurchaseSupplierWidget({super.key});

  @override
  ConsumerState<PurchaseSupplierWidget> createState() =>
      _PurchaseSupplierWidgetState();
}

class _PurchaseSupplierWidgetState
    extends ConsumerState<PurchaseSupplierWidget> {
  @override
  Widget build(BuildContext context) {
    final _vm = ref.watch(purchaseAddViewModelProvider);
    final _vmn = ref.watch(purchaseAddViewModelProvider.notifier);

    final supplierAsync = ref.watch(supplierListProvider);
    final purchaseUpdate = ref.watch(purchaseUpdateViewModel.notifier);
    return supplierAsync.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, st) => Text("Failed to load suppliers"),

      data: (allSuppliers) {
        return Row(
          children: [
            SizedBox(width: 10),

            // / ------------------ DROPDOWN ------------------
            Expanded(
              child: DropdownSearch<AllSupplier>(
                selectedItem: _vm.selectedSupplier,
                items: (filter, loadProps) async => allSuppliers,

                filterFn: (supplier, filter) => supplier.supplierName
                    .toLowerCase()
                    .contains(filter.toLowerCase()),

                itemAsString: (s) => s.supplierName,
                compareFn: (a, b) => a.supplierId == b.supplierId,

                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  disableFilter: false,
                  interceptCallBacks: true,
                  menuProps: MenuProps(
                    backgroundColor: Colors.white, // 🔥 popup background
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "সাপ্লায়ার খুঁজুন...",

                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      // fillColor: AppColors.whiteColor,
                      border: InputBorder.none,
                    ),
                  ),
                  itemBuilder: (context, supplier, isSelected, isDisabled) {
                    return ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        _vmn.selectSupplier(supplier);
                      },
                      title: Text(supplier.supplierName),
                      subtitle: Text(supplier.phone ?? ''),

                      trailing: InkWell(
                        // behavior: HitTestBehavior.opaque,
                        onTapDown: (_) {
                          // close dropdown first
                          Navigator.pop(context);
                          // navigate AFTER popup is closed

                          print("tapp");
                          purchaseUpdate.updateSupplierName.text =
                              supplier.supplierName;
                          purchaseUpdate.updateSupplierPhone.text =
                              supplier.phone ?? "Not given";
                          purchaseUpdate.updateSupplierEmail.text =
                              supplier.email ?? "Not given";
                          purchaseUpdate.updateSupplierAddress.text =
                              supplier.address ?? "Not given";

                          if (!context.mounted) return;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  UpdateSupplierView(supplier: supplier),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Material(
                            child: Ink(
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Icon(Icons.edit, size: 20),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  emptyBuilder: (context, searchEntry) {
                    // This shows when no item matches the search
                    return ListTile(
                      title: Text("No Supplier found"),
                      trailing: CustomButton(
                        title: "Add Supplier",
                        onTap: () {
                          _vmn.supplierNameController.text = searchEntry;
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (modalContext) {
                              return Consumer(
                                builder: (context, ref, _) {
                                  final _vm = ref.watch(
                                    purchaseAddViewModelProvider,
                                  );
                                  final _vmn = ref.watch(
                                    purchaseAddViewModelProvider.notifier,
                                  );

                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(
                                            context,
                                          ).viewInsets.bottom,
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
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                                    CustomPakkaFormField(
                                                      controller: _vmn
                                                          .supplierNameController,
                                                      label: "Supplier Name *",
                                                      validator: (value) =>
                                                          Validation.validateName(
                                                            value,
                                                            context,
                                                          ),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                    ),
                                                    SizedBox(height: 12),

                                                    CustomPakkaFormField(
                                                      controller: _vmn
                                                          .supplierPhoneController,
                                                      label: "Supplier Phone *",
                                                      validator: (value) =>
                                                          Validation.validatePhone(
                                                            value,
                                                            context,
                                                          ),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                    ),
                                                    SizedBox(height: 12),

                                                    CustomPakkaFormField(
                                                      controller: _vmn
                                                          .supplierEmailController,
                                                      label: "Supplier Email",
                                                      textInputAction:
                                                          TextInputAction.next,
                                                    ),
                                                    SizedBox(height: 12),

                                                    CustomPakkaFormField(
                                                      controller: _vmn
                                                          .supplierAddressController,
                                                      label: "Supplier Address",
                                                      textInputAction:
                                                          TextInputAction.next,
                                                    ),
                                                    SizedBox(height: 12),

                                                    CustomPakkaFormField(
                                                      controller: _vmn
                                                          .supplierOpeningBalanceController,
                                                      label:
                                                          "Supplier Opening Balance",
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      onComplete: () async {
                                                        if (_vmn
                                                            .customerAddFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          await _vmn
                                                              .addSupplier(
                                                                context,
                                                              );

                                                          /// refresh dropdown list
                                                          ref.invalidate(
                                                            supplierListProvider,
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              SizedBox(height: 20),

                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 14,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    if (_vmn
                                                        .customerAddFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      await _vmn.addSupplier(
                                                        context,
                                                      );

                                                      /// reload supplier list
                                                      ref.invalidate(
                                                        supplierListProvider,
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    "Save Supplier",
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
                                      ),
                                      if (_vm.isLoading)
                                        Positioned.fill(
                                          child: Container(
                                            color: Colors.black.withAlpha(25),
                                            child: Center(
                                              child:
                                                  loader, // your custom loader
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.add),
                      ),
                    );
                  },
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
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
            ),

            SizedBox(width: 10),

            /// ------------------ ADD SUPPLIER BUTTON ------------------
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (modalContext) {
                    return Consumer(
                      builder: (context, ref, _) {
                        final _vm = ref.watch(purchaseAddViewModelProvider);
                        final _vmn = ref.watch(
                          purchaseAddViewModelProvider.notifier,
                        );

                        return Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    10,
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
                                          CustomPakkaFormField(
                                            controller:
                                                _vmn.supplierNameController,
                                            label: "Supplier Name *",
                                            validator: (value) =>
                                                Validation.validateName(
                                                  value,
                                                  context,
                                                ),
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                          SizedBox(height: 12),

                                          CustomPakkaFormField(
                                            controller:
                                                _vmn.supplierPhoneController,
                                            label: "Supplier Phone *",
                                            validator: (value) =>
                                                Validation.validatePhone(
                                                  value,
                                                  context,
                                                ),
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                          SizedBox(height: 12),

                                          CustomPakkaFormField(
                                            controller:
                                                _vmn.supplierEmailController,
                                            label: "Supplier Email",
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                          SizedBox(height: 12),

                                          CustomPakkaFormField(
                                            controller:
                                                _vmn.supplierAddressController,
                                            label: "Supplier Address",
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                          SizedBox(height: 12),

                                          CustomPakkaFormField(
                                            controller: _vmn
                                                .supplierOpeningBalanceController,
                                            label: "Supplier Opening Balance",
                                            textInputAction:
                                                TextInputAction.done,
                                            onComplete: () async {
                                              if (_vmn
                                                  .customerAddFormKey
                                                  .currentState!
                                                  .validate()) {
                                                await _vmn.addSupplier(context);

                                                /// refresh dropdown list
                                                ref.invalidate(
                                                  supplierListProvider,
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 20),

                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (_vmn
                                              .customerAddFormKey
                                              .currentState!
                                              .validate()) {
                                            await _vmn.addSupplier(context);

                                            /// reload supplier list
                                            ref.invalidate(
                                              supplierListProvider,
                                            );
                                          }
                                        },
                                        child: Text(
                                          "Save Supplier",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            if (_vm.isLoading)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withAlpha(25),
                                  child: Center(
                                    child: loader, // your custom loader
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(14),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),

            SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
