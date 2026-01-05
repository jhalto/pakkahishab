import 'package:flutter_riverpod/flutter_riverpod.dart';

final packagesViewModel = NotifierProvider<PackagesNotifier, PackagesState>(
  () => PackagesNotifier(),
);

class PackagesState {}

class PackagesNotifier extends Notifier<PackagesState> {
  @override
  build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
