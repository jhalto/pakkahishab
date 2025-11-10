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
    String? customerId,
  }) async {
    final dueData = await _services.getCustomerDues(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
      dueDate: dueDate,
      customerId: customerId,
    );
    print(dueData.length);
    return dueData;
  }

  Future<Map<String, dynamic>> getCustomerDueDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String customerId,
  }) async {
    final purchaseData = await _services.getCustomerDueDetails(
      customerId: customerId,
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    return purchaseData;
  }

  Future<Map<String, dynamic>> getDueCustomer({
    required String phone,
    required String pin,
    required String code,
  }) async {
    print("supplier_repository");
    final response = await _services.getDueCustomer(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }
   Future<Map<String, dynamic>> getCustomerSales({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? saleDate,
    String? customerId,
  }) async {
    final purchaseData = await _services.getCustomerSales(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
      saledate: saleDate,
      customerId: customerId,
    );
    print(purchaseData.length);
    return purchaseData;
  }

  Future<Map<String, dynamic>> getCustomerSaleDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String saleNo,
  }) async {
    final purchaseData = await _services.getCustomerSaleDetails(
      saleNo: saleNo,
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    print(purchaseData.length);
    return purchaseData;
  }
}
