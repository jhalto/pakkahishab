
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pakkahishab/core/const/app_colors.dart';
// import 'package:pakkahishab/core/const/app_text_style.dart';
// import 'package:pakkahishab/core/global_widgets/custom_back_button.dart';
// import 'package:pakkahishab/core/global_widgets/custom_button.dart';

// class PackagesView extends StatelessWidget {
//   const PackagesView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           leading: CustomBackButton(),
//           title: Text(
//             'Packages',
//             style: AppTextStyle.titleMedium
//           ),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [AppColors.primaryColor2, AppColors.primaryColor],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//         ),
//         body: Consumer(builder: (context, ref, child) {
//           if (controller.packageLoading.value) {
//             return Center(child: spinkit);
//           }

//           return Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).padding.bottom,
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: 6.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     PopupMenuButton<String>(
//                       color: AppColors.whiteColor,
//                       child: Row(
//                         children: [
//                           Obx(() => Text("Sort by ${controller.sortBy.value}")),
//                           Icon(Icons.arrow_drop_down),
//                         ],
//                       ),
//                       onSelected: (value) {
//                         controller.sortBy.value = value;
//                         controller.sortPackages();

//                         // Sort your packages list
//                         if (value == 'price') {
//                           controller.sortPackages();
//                         } else if (value == 'duration') {
//                           controller.sortPackages();
//                         }

//                         // If using GetX and UI depends on list, call update
//                         controller.update();
//                       },
//                       itemBuilder: (context) => [
//                         PopupMenuItem(
//                           value: 'price',
//                           child: Text('Sort by Price'),
//                         ),
//                         PopupMenuItem(
//                           value: 'duration',
//                           child: Text('Sort by Duration'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: Obx(
//                     () => ListView.builder(
//                       padding: const EdgeInsets.all(12),
//                       itemCount: controller.packages.length,
//                       itemBuilder: (context, index) {
//                         final pkg = controller.packages[index];
//                         return Padding(
//                           padding: EdgeInsets.only(bottom: 10.h),
//                           child: Stack(
//                             children: [
//                               InkWell(
//                                 borderRadius: BorderRadius.circular(10.r),
//                                 onTap: () {
//                                   Get.toNamed(
//                                     Routes.paymentDetail,
//                                     arguments: pkg,
//                                   );
//                                 },
//                                 splashColor: Colors.black.withValues(
//                                   alpha: 0.2,
//                                 ),
//                                 child: Ink(
//                                   padding: EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.whiteColor,
//                                     borderRadius: BorderRadius.circular(10.r),
//                                     boxShadow: <BoxShadow>[
//                                       BoxShadow(
//                                         color: Colors.black.withValues(
//                                           alpha: 0.15,
//                                         ), // Soft and subtle
//                                         offset: Offset(0, 0),
//                                         blurRadius: 6, // Smoothen the shadow
//                                         spreadRadius: 0,
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         pkg.title,
//                                         style: globalTextStyle(
//                                           fontSize: 16.sp,
//                                           fontWeight: FontWeight.w500,
//                                           color: AppColors.primaryColor5,
//                                         ),
//                                       ),
//                                       SizedBox(height: 6.h),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.schedule,
//                                             color: AppColors.secondaryTextColor,
//                                             size: 16.sp,
//                                           ),
//                                           SizedBox(width: 6.w),
//                                           Text(pkg.duration),
//                                         ],
//                                       ),

//                                       SizedBox(height: 6.h),
//                                       Text(
//                                         "Features:",
//                                         style: globalTextStyle(),
//                                       ),
//                                       SizedBox(height: 4.h),
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Expanded(
//                                             flex: 24,
//                                             child: Column(
//                                               children: pkg.features
//                                                   .take(1)
//                                                   .map(
//                                                     (feature) => Padding(
//                                                       padding: EdgeInsets.only(
//                                                         bottom: 4.h,
//                                                       ),
//                                                       child: Row(
//                                                         children: [
//                                                           Icon(
//                                                             Icons.check,
//                                                             size: 16.sp,
//                                                             color: AppColors
//                                                                 .primaryColor,
//                                                           ),
//                                                           SizedBox(width: 6.w),
//                                                           Expanded(
//                                                             child: Text(
//                                                               feature,
//                                                               style:
//                                                                   globalTextStyle(
//                                                                     fontSize:
//                                                                         14,
//                                                                   ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   )
//                                                   .toList(),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 bottom: 10,
//                                 right: 10,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(bottom: 2),
//                                       child: pkg.discountValue != 0
//                                           ? Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 // Original price with strikethrough
//                                                 Text(
//                                                   "Tk ${double.parse(pkg.price).toInt()}",
//                                                   style: globalTextStyle(
//                                                     fontSize: 12.sp,
//                                                     fontWeight: FontWeight.w500,
//                                                     decoration: TextDecoration
//                                                         .lineThrough,
//                                                     color: Colors.red,
//                                                   ),
//                                                 ),
//                                                 SizedBox(width: 8.w),
//                                                 // Discounted price
//                                                 Text(
//                                                   "Tk ${_discountedPrice(double.parse(pkg.price), pkg.discountValue ?? 0.0)}",
//                                                   style: globalTextStyle(
//                                                     fontSize: 18.sp,
//                                                     fontWeight: FontWeight.w600,
//                                                     color:
//                                                         AppColors.primaryColor,
//                                                   ),
//                                                 ),
//                                               ],
//                                             )
//                                           : Text(
//                                               "Tk ${double.parse(pkg.price).toInt()}",
//                                               // style: globalTextStyle(
//                                               //   fontSize: 18.sp,
//                                               //   fontWeight: FontWeight.w600,
//                                               // ),
//                                               style: AppTextStyle.titleMedium,
//                                             ),
//                                     ),
//                                     Material(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: CustomButton(
//                                         onTap: () {
//                                           // Get.toNamed(Routes.paymentDetail, arguments:  pkg);
//                                         },
//                                         title: "Supports",
//                                         paddingVertical: 4,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               pkg.tag != null
//                                   ? Positioned(
//                                       top: 10,
//                                       right: 10,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(
//                                             10,
//                                           ),
//                                           color: AppColors.primaryColor,
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                           vertical: 4,
//                                           horizontal: 10,
//                                         ),
//                                         child: Text(
//                                           pkg.tag ?? "",
                                          
//                                           style: AppTextStyle.bodyMediumWhite,
//                                         ),
//                                       ),
//                                     )
//                                   : SizedBox(),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },)

//       ),
//     );
//   }
// }

// String _discountedPrice(double price, double discountValue) {
//   final double discounted = price - (price * discountValue);
//   return discounted.toInt().toString();
// }
