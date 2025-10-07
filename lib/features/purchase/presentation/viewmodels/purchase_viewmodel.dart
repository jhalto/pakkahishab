import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_detail_model.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';
import 'package:pakkahishab/features/purchase/presentation/views/purchase_details.dart';

// final purchaseViewModelProvider =
//     AsyncNotifierProvider<PurchaseNotifier, PurchaseState>(
//       () => PurchaseNotifier(),
//     );
final purchaseViewModelProvider =
    NotifierProvider<PurchaseNotifier, PurchaseState>(() => PurchaseNotifier());

final class PurchaseState {
  final PurchaseDetailsResponse? purchaseDetails;
  final bool loading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final String phone;
  final String pin;
  final String offset;
  final List<PurchaseItem> purchaseList;

  const PurchaseState({
    this.purchaseDetails,
    this.loading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 0,
    this.phone = '',
    this.pin = '',
    this.offset = '0',
    this.purchaseList = const [],
  });
  
  PurchaseState copyWith({
    PurchaseDetailsResponse? purchaseDetails,
    bool? loading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    String? phone,
    String? pin,
    String? offset,
    List<PurchaseItem>? purchaseList,
  }) {
    return PurchaseState(
      purchaseDetails: purchaseDetails ?? this.purchaseDetails,
      loading: loading ?? this.loading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,
      purchaseList: purchaseList ?? this.purchaseList,
    );
  }
}

class PurchaseNotifier extends Notifier<PurchaseState> {
  late final PurchaseRepository _repo;

  @override
  PurchaseState build() {
    _repo = ref.read(purchaseRepositoryProvider);
    fetchPurchases(); // call async stuff manually
    return const PurchaseState();
  }
   Future<void> fetchPurchases({bool loadMore = false, int? page}) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(loading: true);

      // if user taps a page number, use that page’s offset
      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final result = await _repo.getPurchases(
        phone: phone ?? '',
        pin: pin ??'',
        code: code ?? '',
        offset: newOffset.toString(),
      );

      final items = (result['data']['items'] ?? []) as List;
      final hasMore = result['data']['hasMore'] ?? false;
      final totalItem = result['data']['items'][0]['total_count']??0;
      print(totalItem);
      state = state.copyWith(totalPage: (totalItem/10).ceil());
      print(state.totalPage);
      final newItems = items
          .map<PurchaseItem>((e) => PurchaseItem.fromJson(e))
          .toList();

      state = state.copyWith(
        purchaseList: newItems,
        offset: newOffset.toString(),
        currentPage: newPage,
        hasMore: hasMore,
      );
    } catch (e) {
      debugPrint("Error fetching purchases: $e");
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void goToPage(int page) {
    fetchPurchases(page: page);
  }
  void refreshPurchases() {
    state = const PurchaseState();
    fetchPurchases();
  }

  Future<void> fetchPurchaseDetails(BuildContext context, {bool loadMore = false, int? page, required String purchaseNo}) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin')??'';
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(loading: true);
   
      // if user taps a page number, use that page’s offset
      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final response = await _repo.getPurchaseDetails(
        phone: phone ?? '',
        pin: pin,
        code: code ?? '',
        offset: newOffset.toString(),
        purchaseNo: purchaseNo
       );
       

            
       print("purchase details: $response");
      
       
       if(response['statusCode'] == 200){
        print("in 200");
           print(response['data']);
        final purchaseData =await PurchaseDetailsResponse.fromJson(response['data']);
        print("pasdflkj : $purchaseData");
         state = state.copyWith(purchaseDetails: purchaseData);
        
        // if(!context.mounted)return;
      
        // //  if(state.purchaseDetails != null){
        // //     print("Navigating to PurchaseDetails page...");
        // //   if(!context.mounted)return;
        // //     print("Navigating to PurchaseDetails page...");
        // //  Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseDetails(),)); 
          
        // //  }
         
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseDetails(),)); 
         
       }
     
    } catch (e) {
      debugPrint("Error fetching purchases: $e");
    } finally {
      state = state.copyWith(loading: false);
    }
  }
  

}
 