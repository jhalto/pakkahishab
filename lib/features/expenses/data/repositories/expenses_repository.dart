import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/expenses/data/services/expenses_services.dart';

final expensesRepositoryProvider = Provider<ExpensesRepository>((ref) {
  final service = ref.read(expensesServiceProvider);
  return ExpensesRepository(service);
});

class ExpensesRepository {
  final ExpensesServices _expensesServices;
  ExpensesRepository(this._expensesServices);

  Future<Map<String, dynamic>> getExpenses({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String?  voucherDate,
    String? catagoryId,
  }) async {
    final purchaseData = await _expensesServices.getExpenses(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
      voucherDate: voucherDate,
      catagoryId: catagoryId,
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

  Future<Map<String, dynamic>> getExpenseCatagory({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _expensesServices.getExpenseCatagory(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  
}
