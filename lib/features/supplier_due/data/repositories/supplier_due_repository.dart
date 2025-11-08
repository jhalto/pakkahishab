import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/supplier_due/data/services/supplier_due_services.dart';

final supplierDueRepositoryProvider = Provider<SupplierDueRepository>((ref) {
  final service = ref.read(supplierDueServiceProvider);
  return SupplierDueRepository(service);
});

class SupplierDueRepository {
  final SupplierDueServices _supplierDueServices;
  SupplierDueRepository(this._supplierDueServices);

  Future<Map<String, dynamic>> getSupplierDues({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? dueDate,
    String? supplierId,
  }) async {
    final dueData = await _supplierDueServices.getSupplierDues(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
      dueDate: dueDate,
      supplierId: supplierId,
    );
    print(dueData.length);
    return dueData;
  }

  Future<Map<String, dynamic>> getSupplierDueDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String supplierId,
  }) async {
    final purchaseData = await _supplierDueServices.getSupplierDueDetails(
      supplierId: supplierId,
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    print(purchaseData.length);
    return purchaseData;
  }

  Future<Map<String, dynamic>> getDueSupplier({
    required String phone,
    required String pin,
    required String code,
  }) async {
    print("supplier_repository");
    final response = await _supplierDueServices.getDueSupplier(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

   Future<Map<String, dynamic>> getSupplierDuePurchaseDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String purchaseNo,
  }) async {
    final purchaseData = await _supplierDueServices.getSupplierDuePurchaseDetails(
      purchaseNo: purchaseNo,
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    print(purchaseData.length);
    return purchaseData;
  }
  Future<Map<String, dynamic>> getSupplierPurchase({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? purchaseNo,

  
    
  }) async {
    final purchaseData = await _supplierDueServices.getSupplierPurchase(
      purchaseNo: purchaseNo,
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    print(purchaseData.length);
    return purchaseData;
  }
}
