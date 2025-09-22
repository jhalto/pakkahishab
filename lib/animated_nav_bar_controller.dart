// import 'package:bd_tender/features/services/views/service_view.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:bd_tender/features/home/views/home_view.dart';

// class AnimatedNavBarController extends GetxController {
//   final RxInt selectedIndex = 0.obs;

//   final PageController pageController = PageController();

//   final List<Widget> pages = <Widget>[
//     HomeView(),
//     // FavouriteView(),
//     ServiceView(),
//     Center(child: Text("More")),
//   ];

//   void onPageChanged(int index) {
//     selectedIndex.value = index;
//   }

//   void onItemTapped(int index) {
//     selectedIndex.value = index;
//     pageController.jumpToPage(index);
//   }

//   @override
//   void onClose() {
//     pageController.dispose();
//     super.onClose();
//   }
// }