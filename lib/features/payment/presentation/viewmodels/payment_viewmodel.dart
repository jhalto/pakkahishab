import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentProvider = NotifierProvider<PaymentNotifier, PaymentState>(
  () => PaymentNotifier(),
);

class PaymentState {
  final bool isLoading;
  final String totalDueAmount;

  PaymentState({this.totalDueAmount = '', this.isLoading = false});

  PaymentState copyWith({bool? isLoading, String? totalDueAmount}) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      totalDueAmount: totalDueAmount ?? this.totalDueAmount,
    );
  }
}

class PaymentNotifier extends Notifier<PaymentState> {
  @override
  build() {
    // TODO: implement build
    return PaymentState();
  }
}
