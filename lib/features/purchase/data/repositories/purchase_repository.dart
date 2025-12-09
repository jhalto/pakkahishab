import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/purchase/data/models/all_product_model.dart';
import 'package:pakkahishab/features/purchase/data/services/purchase_services.dart';

final purchaseRepositoryProvider = Provider<PurchaseRepository>((ref) {
  final service = ref.read(purchaseServiceProvider);
  return PurchaseRepository(service);
});

class PurchaseRepository {
  final PurchaseServices _purchaseServices;
  PurchaseRepository(this._purchaseServices);

  Future<Map<String, dynamic>> getPurchases({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? purchaseDate,
    String? supplierId,
  }) async {
    final purchaseData = await _purchaseServices.getPurchase(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
      purchasedate: purchaseDate,
      supplierId: supplierId,
    );
    print(purchaseData.length);
    return purchaseData;
  }

  Future<Map<String, dynamic>> getPurchaseDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String purchaseNo,
  }) async {
    final purchaseData = await _purchaseServices.getPurchaseDetails(
      purchaseNo: purchaseNo,
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    print(purchaseData.length);
    return purchaseData;
  }

  Future<Map<String, dynamic>> getSupplier({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _purchaseServices.getSupplier(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }
  Future<Map<String, dynamic>> getAllSupplier({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _purchaseServices.getAllSupplier(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  Future<Map<String, dynamic>> addSupplier({
    required String code,
    required String mobile,
    required String pin,
    required String customerName,
    required String customerPhone,
    String? customerAddress,
    String? customerEmail,
    int openingBalance = 0,
  }) async {
    final response = await _purchaseServices.addSupplier(
      code: code,
      mobile: mobile,
      pin: pin,
      customerName: customerName,
      customerPhone: customerPhone,
    );
    return response;    
  }

  Future<Map<String, dynamic>> getAllProduct({
    required String code,
    required String mobile,
    required String pin,
  }) async {
    final response = await _purchaseServices.getAllProduct(
      code: code,
      phone: mobile,
      pin: pin,
    );
    return response;    
  }

  Future<Map<String, dynamic>> addProduct({
    required String code,
    required String mobile,
    required String pin,
    required List<AddProductItem> product,
  }) async {
    final response = await _purchaseServices.addProduct(
      code: code,
      phone: mobile,
      pin: pin,
      products: product
    );
    return response;    
  }
}

