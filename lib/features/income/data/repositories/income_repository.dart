import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/income/data/services/income_services.dart';

final incomeRepositoryProvider = Provider<IncomeRepository>((ref) {
  final service = ref.read(incomeServiceProvider);
  return IncomeRepository(service);
});

class IncomeRepository {
  final IncomeServices _incomeServices;
  IncomeRepository(this._incomeServices);

  Future<Map<String, dynamic>> getIncome({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? voucherDate,
    String? catagoryId,
  }) async {
    final purchaseData = await _incomeServices.getIncomes(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
      voucherdate: voucherDate,
      catagoryId: catagoryId,
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

  Future<Map<String, dynamic>> getIncomeCatagory({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _incomeServices.getIncomeCatagory(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  
}
