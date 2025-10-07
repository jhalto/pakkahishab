import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/purchase/data/services/purchase_services.dart';


final purchaseRepositoryProvider = Provider<PurchaseRepository>((ref) {
     final service = ref.read(purchaseServiceProvider);
   return PurchaseRepository(service);
},);


class PurchaseRepository{
 final PurchaseServices _purchaseServices;
  PurchaseRepository(this._purchaseServices);
  
  Future<Map<String, dynamic>> getPurchases({
    required String phone,
    required String pin,
    required String offset,
    required String code,
  }) async {
    final purchaseData =await _purchaseServices.getPurchase(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code
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
    final purchaseData =await _purchaseServices.getPurchaseDetails(
      purchaseNo: purchaseNo,
      phone: phone,
      pin: pin,
      offset: offset,
      code: code
    );
    print(purchaseData.length);
    return purchaseData;
  }
}
