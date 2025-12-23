



import 'package:flutter_riverpod/flutter_riverpod.dart';

final purchaseUpdateViewModel = NotifierProvider<PurchaseUpdateNotifier, PurchaseUpdateState >(() => PurchaseUpdateNotifier());


class PurchaseUpdateState{
}


class PurchaseUpdateNotifier extends Notifier<PurchaseUpdateState>{
  @override
  build() {
    // TODO: implement build
    return PurchaseUpdateState();
  }

}