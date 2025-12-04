import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/advance/data/services/advance_services.dart';



final advanceRepositoryProvider = Provider<AdvanceRepository>((ref) {
  final service = ref.read(advanceServiceProvider);
  return AdvanceRepository(service);
});

class AdvanceRepository {
  final AdvanceServices _services;
  AdvanceRepository(this._services);

  Future<Map<String, dynamic>> getBankAmountItem({
    required String phone,
    required String pin,
    required String offset,
    required String code,

    String? productId,
  }) async {
    final purchaseData = await _services.getAdvanceItem(
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

  Future<Map<String, dynamic>> getAdvanceHead({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _services.getAdvanceHead(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  
}
