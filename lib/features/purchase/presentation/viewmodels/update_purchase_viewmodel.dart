import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';

final purchaseUpdateViewModel =
    NotifierProvider<PurchaseUpdateNotifier, PurchaseUpdateState>(
      () => PurchaseUpdateNotifier(),
    );

class PurchaseUpdateState {
  final bool isLoading;

  const PurchaseUpdateState({this.isLoading = false});

  PurchaseUpdateState copyWith({bool? isLoading}) {
    return PurchaseUpdateState(isLoading: isLoading ?? this.isLoading);
  }
}

class PurchaseUpdateNotifier extends Notifier<PurchaseUpdateState> {
  late final PurchaseRepository _repo;

  @override
  build() {
   
    _repo = ref.read(purchaseRepositoryProvider);
    return PurchaseUpdateState();
  }

  final TextEditingController updateSupplierName = TextEditingController();
  final TextEditingController updateSupplierPhone = TextEditingController();
  final TextEditingController updateSupplierEmail = TextEditingController();
  final TextEditingController updateSupplierAddress = TextEditingController();
  final TextEditingController updateSupplierOpeningBalance =
      TextEditingController();

  Future<void> updateSupplier(
    BuildContext context, {
    required String supplierId,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    final supplier = {
      "supplier_id": supplierId,
      "supplier_name": updateSupplierName.text.trim(),
      "phone": updateSupplierPhone.text.trim(),
      "address": updateSupplierAddress.text.trim(),
      "email": updateSupplierEmail.text.trim(),
      "godown_no": "1",
      "opening_balance": updateSupplierOpeningBalance.text.trim(),
    };

    final response = await _repo.updateSupplier(
      code: code.toString(),
      mobile: phone.toString(),
      pin: pin.toString(),
      supplier: supplier,
    );
    print(response);

    if (response['status'] == 'success') {
      if (!context.mounted) return;
      Navigator.pop(context);
      if (!context.mounted) return;
      showCustomSnackBar(context, "Suppliers updated successfully", type: SnackBarType.success);

      ref.invalidate(supplierListProvider);
    } else {
      if (!context.mounted) return;
      showCustomSnackBar(context, response['message']);
    }
  }
}
