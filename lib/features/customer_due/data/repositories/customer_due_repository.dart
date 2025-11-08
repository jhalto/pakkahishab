import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/customer_due/data/services/customer_due_services.dart';

final customerDueRepositoryProvider = Provider<CustomerDueRepository>((ref) {
  final service = ref.read(customerDueServiceProvider);
  return CustomerDueRepository(service);
});

class CustomerDueRepository {
  final CustomerDueServices _services;
  CustomerDueRepository(this._services);

  Future<Map<String, dynamic>> getCustomerDues({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? dueDate,
    String? supplierId,
  }) async {
    final dueData = await _services.getCustomerDues(
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
    final purchaseData = await _services.getSupplierDueDetails(
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
    final response = await _services.getDueSupplier(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }
}
