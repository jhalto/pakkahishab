import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/loan/data/services/loan_services.dart';



final loanRepositoryProvider = Provider<LoanRepository>((ref) {
  final service = ref.read(loanServiceProvider);
  return LoanRepository(service);
});

class LoanRepository {
  final LoanServices _services;
  LoanRepository(this._services);

  Future<Map<String, dynamic>> getLoanItem({
    required String phone,
    required String pin,
    required String offset,
    required String code,

    String? productId,
  }) async {
    final purchaseData = await _services.getLoanItem(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    print(purchaseData.length);
    return purchaseData;
  }

  // Future<Map<String, dynamic>> getSaleDetails({
  //   required String phone,
  //   required String pin,
  //   required String offset,
  //   required String code,
  //   required String saleNo,
  // }) async {
  //   final purchaseData = await _incomeServices.getSaleDetails(
  //     saleNo: saleNo,
  //     phone: phone,
  //     pin: pin,
  //     offset: offset,
  //     code: code,
  //   );
  //   print(purchaseData.length);
  //   return purchaseData;
  // }

  Future<Map<String, dynamic>> getStockProductName({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _services.getStockProductName(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  
}
