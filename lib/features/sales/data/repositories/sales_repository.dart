import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/sales/data/services/sales_services.dart';

final salesRepositoryProvider = Provider<SalesRepository>((ref) {
  final service = ref.read(salesServiceProvider);
  return SalesRepository(service);
});

class SalesRepository {
  final SalesServices _salesServices;
  SalesRepository(this._salesServices);

  Future<Map<String, dynamic>> getSales({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? saleDate,
    String? customerId,
  }) async {
    final purchaseData = await _salesServices.getSales(
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
    final purchaseData = await _salesServices.getSaleDetails(
      saleNo: saleNo,
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    print(purchaseData.length);
    return purchaseData;
  }

  Future<Map<String, dynamic>> getSaledCustomer({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _salesServices.getSaledCustomer(
      phone: phone,
      pin: pin,
      code: code,
    );
    return response;
  }
Future<Map<String, dynamic>> getAllCustomer({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _salesServices.getAllCustomer(
      phone: phone,
      pin: pin,
      code: code,
    );
    return response;
  }
  Future<Map<String, dynamic>> addSales({
    required String phone,
    required String pin,
    required String schoolCode,
    required String customerId,
    required int salesType,
    required double netAmount,
    required double due,
    required double paidPrice,
    DateTime? date,
  }) async {
    final response = await _salesServices.addSales(
      phone: phone,
      pin: pin,
      schoolCode: schoolCode,
      customerId: customerId,
      salesType: salesType,
      netAmount: netAmount,
      due: due,
      paidPrice: paidPrice,
      date: date,
    );

    // Standardize response
    return response;
  }

  Future<Map<String, dynamic>> addCustomer({
    required String code,
    required String mobile,
    required String pin,
    required String customerName,
    required String customerPhone,
    String? customerAddress,
    String? customerEmail,
    int openingBalance = 0,
  }) async {
    final response = await _salesServices.addCustomer(
      code: code,
      mobile: mobile,
      pin: pin,
      customerName: customerName,
      customerPhone: customerPhone,
    );
    return response;    
  }

}
