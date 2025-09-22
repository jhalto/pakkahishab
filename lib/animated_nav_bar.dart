// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:bd_tender/features/animated_nav_bar_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // Adjust path

// class AnimatedNavBar extends StatelessWidget {
//   const AnimatedNavBar({super.key});

//   final List<IconData> iconList = const [
//     Icons.home,
//     Icons.favorite_border,
//     Icons.settings,
//     Icons.more_horiz,
//   ];

//   @override
//   Widget build(BuildContext context) {
  

//     return Obx(
//       () => Scaffold(
//         body: PageView(
//           controller: controller.pageController,
//           onPageChanged: controller.onPageChanged,

//           physics: const NeverScrollableScrollPhysics(), // optional
//           children: controller.pages,
//         ),
//         floatingActionButton: FloatingActionButton(
//           shape: const CircleBorder(),
//           onPressed: () {
//             // You can handle central FAB action
//           },
//           child: const Icon(Icons.add),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: AnimatedBottomNavigationBar(
//           icons: iconList,
//           activeIndex: controller.selectedIndex.value,
//           gapLocation: GapLocation.center,
//           notchSmoothness: NotchSmoothness.softEdge,
//           onTap: controller.onItemTapped,
//           activeColor: Colors.blue,
//           inactiveColor: Colors.grey,
//           iconSize: 24,
//           backgroundColor: Colors.black,
//           splashColor: Colors.blueAccent,
//           elevation: 10,
//         ),
//       ),
//     );
//   }
// }
