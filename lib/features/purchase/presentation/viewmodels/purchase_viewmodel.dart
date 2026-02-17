import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/global_widgets/file_saver.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_detail_model.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';
import 'package:pakkahishab/features/purchase/data/models/supplier_model.dart';
import 'package:pakkahishab/features/purchase/data/models/supplier_wise_purchase_model.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_supplier_wise_viewmodel.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

final purchaseViewModelProvider =
    NotifierProvider.autoDispose<PurchaseNotifier, PurchaseState>(
      () => PurchaseNotifier(),
    );

final class PurchaseState {
  final PurchaseDetailsResponse? purchaseDetails;
  final SupplierResponse? supplier;
  final List<Supplier>? filteredSuppliers;
  final bool loading;
  final bool detailLoading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;

  final String phone;
  final String pin;
  final String offset;

  final List<PurchaseItem> purchaseList;

  final String? supplierId;
  final String? paymentMethod;
  final String? totalPurchase;
  // final String purchaseDate;
  // final String supplierId;

  const PurchaseState({
    this.purchaseDetails,
    this.supplier,
    this.filteredSuppliers,
    this.loading = false,
    this.detailLoading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 0,

    this.phone = '',
    this.pin = '',
    this.offset = '0',

    this.purchaseList = const [],

    this.supplierId,
    this.paymentMethod,
    this.totalPurchase,
  });

  PurchaseState copyWith({
    PurchaseDetailsResponse? purchaseDetails,
    SupplierResponse? supplier,
    List<Supplier>? filteredSuppliers,
    bool? loading,
    bool? detailLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,

    String? phone,
    String? pin,
    String? offset,

    List<PurchaseItem>? purchaseList,
    List<SupplierPurchaseItem>? supplierPurchaseList,
    String? supplierId,
    String? paymentMethod,
    String? totalPurchase,
  }) {
    return PurchaseState(
      purchaseDetails: purchaseDetails ?? this.purchaseDetails,
      supplier: supplier ?? this.supplier,
      filteredSuppliers: filteredSuppliers ?? this.filteredSuppliers,
      loading: loading ?? this.loading,
      detailLoading: detailLoading ?? this.detailLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,

      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,

      purchaseList: purchaseList ?? this.purchaseList,

      supplierId: supplierId ?? this.supplierId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalPurchase: totalPurchase ?? this.totalPurchase,
    );
  }
}

class PurchaseNotifier extends Notifier<PurchaseState> {
  late final PurchaseRepository _repo;

  @override
  PurchaseState build() {
    _repo = ref.read(purchaseRepositoryProvider);

    return const PurchaseState();
  }

  // Search Controller
  TextEditingController searchSupplierController = TextEditingController();

  // Update state
  void updateSupplierId(String supplierId) async {
    state = state.copyWith(supplierId: supplierId);
    fetchPurchases();
  }

  void updatePaymentMethod(String value) {
    state = state.copyWith(paymentMethod: value);
  }

  // Refresh State

  Future<void> refreshPurchases() async {
    await fetchPurchases();
  }

  // Pagination Navigation
  void goToPage(int page) {
    fetchPurchases(page: page);
  }

  // Search Method

  void searchSupplier(String query) {
    final allSuppliers = state.supplier?.items ?? [];

    if (query.isEmpty) {
      // if query is empty, show all suppliers
      state = state.copyWith(filteredSuppliers: allSuppliers);
    } else {
      final filtered = allSuppliers
          .where(
            (supplier) => supplier.supplierName.toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
      state = state.copyWith(filteredSuppliers: filtered);
    }
  }

  // Api Call

  Future<void> fetchPurchases({
    bool loadMore = false,
    int? page,
    String? purchaseDate,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    if (!ref.mounted) return;
    try {
      state = state.copyWith(loading: true);

      // if user taps a page number, use that page’s offset
      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;
      if (!ref.mounted) return;
      final result = await _repo.getPurchases(
        phone: phone ?? '',
        pin: pin ?? '',
        code: code ?? '',
        offset: newOffset.toString(),
        purchaseDate: purchaseDate,
        supplierId: state.supplierId,
      );

      if (result['statusCode'] == 200) {
        if (!ref.mounted) return;
        final items = (result['data']['items'] ?? []) as List;
        final hasMore = result['data']['hasMore'] ?? false;
        print("has more");
        final totalItem = items.isNotEmpty
            ? items.first['total_count'] ?? 0
            : 0;
        print("total item");

        final newItems = items
            .map<PurchaseItem>((e) => PurchaseItem.fromJson(e))
            .toList();
        print('item');
        state = state.copyWith(
          loading: false,
          purchaseList: newItems,
          offset: newOffset.toString(),
          currentPage: newPage,
          hasMore: hasMore,
          totalPage: (totalItem / 10).ceil(),
        );
      } else {
        state = state.copyWith(loading: false);
      }
    } catch (e) {
      state = state.copyWith(loading: false);

      debugPrint("Error fetching purchases: $e");
    }
  }

  Future<bool> fetchPurchaseDetails({
    bool loadMore = false,
    int? page,
    required String purchaseNo,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin') ?? '';
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(detailLoading: true);

      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final response = await _repo.getPurchaseDetails(
        phone: phone ?? '',
        pin: pin,
        code: code ?? '',
        offset: newOffset.toString(),
        purchaseNo: purchaseNo,
      );

      if (response['statusCode'] == 200) {
        final purchaseData = PurchaseDetailsResponse.fromJson(response['data']);
        state = state.copyWith(purchaseDetails: purchaseData);
        return true; // ✅ signal success
      }
    } catch (e) {
      debugPrint("Error fetching purchases: $e");
    } finally {
      state = state.copyWith(detailLoading: false);
    }
    return false;
  }

  Future<void> getSupplier() async {
    state = state.copyWith(detailLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      final response = await _repo.getSupplier(
        phone: phone.toString(),
        pin: pin.toString(),
        code: code.toString(),
      );

      print(code.toString());
      if (response['statusCode'] == 200) {
        final responseData = SupplierResponse.fromJson(response['data']);
        state = state.copyWith(
          supplier: responseData,
          filteredSuppliers: responseData.items,
        );
        print("done");
      } else {
        print("error $response");
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(detailLoading: false);
    }
  }

  Future<void> deletePurchase(
    BuildContext context, {
    required String purchaseId,
  }) async {
    state = state.copyWith(loading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    print(purchaseId);
    print(phone);
    print(pin);
    print(code);

    final response = await _repo.deletePurchase(
      phone: phone.toString(),
      pin: pin.toString(),
      code: code.toString(),
      purchaseId: purchaseId,
    );

    if (response['status'] == 'success') {
      await fetchPurchases();
      if (!ref.mounted) return; //
      ref
          .read(purchaseSupplierWiseViewModel.notifier)
          .fetchSupplierWisePurchases();
      ref.read(homeProvider.notifier).fetchDashBoard('All');
      state = state.copyWith(loading: false);
      if (!context.mounted) return;
      showCustomSnackBar(
        context,
        "Purchase deleted successfully",
        type: SnackBarType.success,
      );
    } else {
      state = state.copyWith(loading: false);
      if (!context.mounted) return;
      showCustomSnackBar(context, response['message']);
    }
  }

  // download Pdf
  Future<void> downloadFile(BuildContext context, String pathOrUrl) async {
    try {
      if (!context.mounted) return;

      // ✅ CASE 1: Local file path (your PDF case)
      if (!pathOrUrl.startsWith('http')) {
        final file = File(pathOrUrl);

        if (!await file.exists()) {
          if (!context.mounted) return;
          showCustomSnackBar(context, "File not found");
          return;
        }

        final bytes = await file.readAsBytes();
        final fileName = pathOrUrl.split('/').last;

        final saved = await FileSaver.saveToDownloads(
          fileName,
          bytes,
          "application/pdf",
        );

        if (!context.mounted) return;

        if (saved) {
          showCustomSnackBar(
            context,
            "File saved to Downloads",
            type: SnackBarType.success,
          );
        } else {
          showCustomSnackBar(context, "Failed to save file");
        }

        return;
      }

      // ✅ CASE 2: Remote URL (future-proof)
      final dioClient = dio.Dio();
      final response = await dioClient.get<List<int>>(
        pathOrUrl,
        options: dio.Options(responseType: dio.ResponseType.bytes),
      );

      final bytes = Uint8List.fromList(response.data!);
      final fileName = pathOrUrl.split('/').last;

      final saved = await FileSaver.saveToDownloads(
        fileName,
        bytes,
        "application/octet-stream",
      );

      if (!context.mounted) return;

      if (saved) {
        showCustomSnackBar(
          context,
          "File saved to Downloads",
          type: SnackBarType.success,
        );
      } else {
        showCustomSnackBar(context, "Failed to save file");
      }
    } catch (e) {
      if (!context.mounted) return;
      showCustomSnackBar(context, "Download failed");

      if (kDebugMode) {
        print("❌ Download failed: $e");
      }
    }
  }

  Future<bool> requestStoragePermission(BuildContext context) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      final int sdkInt = androidInfo.version.sdkInt;

      if (sdkInt <= 29) {
        final status = await Permission.storage.status;
        if (!status.isGranted) {
          // Request permission if not granted
          final newStatus = await Permission.storage.request();
          if (newStatus.isGranted) {
            if (kDebugMode) print("Storage permission granted");

            showCustomSnackBar(
              context,
              "Storage permission granted",
              type: SnackBarType.success,
            );
            return true;
          } else {
            showCustomSnackBar(
              context,
              "Storage permission denied, it is required to download",
              type: SnackBarType.error,
            );
            if (kDebugMode) print("Storage permission denied");
            return false;
          }
        } else {
          // Permission already granted
          return true;
        }
      }
    }
    // For Android 11+ or other platforms, assume permission not needed
    return true;
  }
}
