import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';

final purchaseViewModelProvider =
    NotifierProvider<PurchaseNotifier, PurchaseState>(() => PurchaseNotifier());

final class PurchaseState {
  final String phone;
  final String pin;
  final String offset;

  const PurchaseState({this.phone = '', this.pin = '', this.offset = '0'});

  PurchaseState copyWith({String? phone, String? pin, String? offset}) {
    return PurchaseState(
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,
    );
  }
}

class PurchaseNotifier extends Notifier<PurchaseState> {
  late final PurchaseRepository _repo;

  @override
  PurchaseState build() {
    _repo = ref.read(purchaseRepositoryProvider);
    loadData();
    fetchPurchases();
    return const PurchaseState();
  }

  Future<void> loadData() async {
    Future<void> loadData() async {
      final phone = await SharedPreferencesHelper.getString('phone');
      state = state.copyWith(phone: phone);
    }
  }

  Future<void> fetchPurchases() async {
    final result = await _repo.getPurchases(
      phone: state.phone,
      pin: '1234',
      offset: state.offset,
    );

    print(result['statusCode']);
    // handle result, maybe update state later
  }
}
