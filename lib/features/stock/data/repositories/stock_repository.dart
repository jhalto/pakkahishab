import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pakkahishab/features/stock/data/services/stock_services.dart';

final stockRepositoryProvider = Provider<StockRepository>((ref) {
  final service = ref.read(stockServiceProvider);
  return StockRepository(service);
});

class StockRepository {
  final StockServices _stockServices;
  StockRepository(this._stockServices);

  Future<Map<String, dynamic>> getStocks({
    required String phone,
    required String pin,
    required String offset,
    required String code,

    String? productId,
  }) async {
    final purchaseData = await _stockServices.getStocks(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
      productId: productId,
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
    final response = await _stockServices.getStockProductName(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  
}
