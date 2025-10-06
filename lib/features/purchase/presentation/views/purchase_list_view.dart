import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';

class PurchaseListView extends StatelessWidget {
  const PurchaseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          final vm = ref.watch(purchaseRepositoryProvider);
          return Text("asdf");
        },),
      ),
    );
  }
}