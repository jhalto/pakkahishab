import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/expenses/data/services/expenses_services.dart';

final expensesRepositoryProvider = Provider<expensesRepository>((ref) {
  final service = ref.read(expensesServiceProvider);
  return expensesRepository(service);
});

class expensesRepository {
  final ExpensesServices _expensesServices;
  expensesRepository(this._expensesServices);

  Future<Map<String, dynamic>> getExpenses({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? saleDate,
    String? customerId,
  }) async {
    final purchaseData = await _expensesServices.getExpenses(
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

  Future<Map<String, dynamic>> getSaleDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String saleNo,
  }) async {
    final purchaseData = await _expensesServices.getSaleDetails(
      saleNo: saleNo,
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    print(purchaseData.length);
    return purchaseData;
  }

  Future<Map<String, dynamic>> getCustomer({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _expensesServices.getCustomer(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  
}
