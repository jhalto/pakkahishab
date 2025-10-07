import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';

// final purchaseViewModelProvider =
//     AsyncNotifierProvider<PurchaseNotifier, PurchaseState>(
//       () => PurchaseNotifier(),
//     );
final purchaseViewModelProvider =
    NotifierProvider<PurchaseNotifier, PurchaseState>(() => PurchaseNotifier());

final class PurchaseState {
  final bool loading;
  final String phone;
  final String pin;
  final String offset;
  final List<PurchaseItem> purchaseList;

  const PurchaseState({
    this.loading = false,
    this.phone = '',
    this.pin = '',
    this.offset = '0',
    this.purchaseList = const [],
  });

  PurchaseState copyWith({
    bool? loading,
    String? phone,
    String? pin,
    String? offset,
    List<PurchaseItem>? purchaseList,
  }) {
    return PurchaseState(
      loading: loading ?? this.loading,
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

  Future<void> fetchPurchases({bool loadMore = false}) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    print(phone);
    print(pin);
    try {
      state = state.copyWith(loading: true);
      final currentOffset = int.tryParse(state.offset) ?? 0;
      final newOffset = loadMore ? currentOffset + 10 : 0;
      final result = await _repo.getPurchases(
        phone: "01566026475",
        pin: '1234',
        offset: "0",
      );
     print(result);
      final items = result['data']['items'] ?? [];

      final data = items
          .map<PurchaseItem>((e) => PurchaseItem.fromJson(e))
          .toList();

      print("Fetched items: ${items.length}");
     
      state = state.copyWith(purchaseList: data, offset: newOffset.toString());
    } catch (e) {
      print("Error: $e");
    } finally {
      state = state.copyWith(loading: false);
    }
  }
}
