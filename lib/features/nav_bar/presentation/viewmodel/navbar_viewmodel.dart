import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/features/purchase/presentation/views/purchase_view.dart';
import 'package:pakkahishab/features/sales/presentation/views/sale_view.dart';

final navbarProvider = ChangeNotifierProvider((ref) => NavbarViewmodel());

class NavbarViewmodel extends ChangeNotifier {
  int currentIndex = 0;

  final screens = const [
    PurchaseView(),
    SaleView(),
  ];
  

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}