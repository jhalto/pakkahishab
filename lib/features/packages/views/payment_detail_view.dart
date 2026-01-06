// import 'package:bd_tender/core/const/app_colors.dart';
// import 'package:bd_tender/core/const/app_text_style.dart';
// import 'package:bd_tender/core/global_widgets/custom_appbar_back.dart';
// import 'package:bd_tender/core/global_widgets/custom_button.dart';
// import 'package:bd_tender/features/packages/controllers/packages_controller.dart';
// import 'package:bd_tender/models/package_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class PaymentDetailView extends GetView<PackagesController> {
//   PaymentDetailView({super.key});
//   final Package pkg = Get.arguments;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbarBack(title: "Payment Details"),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10.h),

//             Text(
//               "Order summary",
//               style: globalTextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(height: 15.h),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                     children: [
//                       Text(
//                         "Title:",
//                         style: globalTextStyle(
//                           color: AppColors.secondaryTextColor,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Text(
//                         pkg.title,
//                         style: globalTextStyle(
//                           color: AppColors.secondaryTextColor,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                     children: [
//                       Text(
//                         "Order:",
//                         style: globalTextStyle(
//                           color: AppColors.secondaryTextColor,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Text(
//                         "৳ ${double.parse(pkg.price).toInt()}",
//                         style: globalTextStyle(
//                           color: AppColors.secondaryTextColor,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
                
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                     children: [
//                       Text(
//                         "Discount:",
//                         style: globalTextStyle(
//                           color: AppColors.secondaryTextColor,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Text(
//                         "৳ ${double.parse(pkg.discountValue.toString()).toInt()}",
//                         style: globalTextStyle(
//                           color: AppColors.secondaryTextColor,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 24.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                     children: [
//                       Text(
//                         "Total:",
//                         style: globalTextStyle(
//                           color: AppColors.blackColor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         "৳ ${controller.discountedPrice(double.parse(pkg.price), double.parse(pkg.discountValue.toString()))}",
//                         style: globalTextStyle(
//                           color: AppColors.blackColor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 30),
//             Text(
//               "Payment methods",
//               style: globalTextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: 20.h),
//             InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: () {
//                 controller.paymentselection.value = 1;
//               },
//               child: Obx(
//                 () => Ink(
//                   padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: controller.paymentselection.value == 1
//                         ?Color(0xffCBCBED): Colors.grey.shade300, // selected background, // normal background
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Image.asset("assets/images/shurjoPay.png"),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           controller.paymentselection.value = 1;
//                         },
//                         icon: CircleAvatar(
//                           radius: 10,
//                           backgroundColor: Colors.white,
//                           child: Obx(
//                             () => Container(
//                               height: 12,
//                               width: 12,
//                               decoration: BoxDecoration(
//                                 color: controller.paymentselection.value == 1
//                                     ? Colors.black54
//                                     : Colors.white,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             InkWell(
//               onTap: () {
//                 controller.paymentselection.value = 2;
//               },
//               child: Obx(
//                 () => Ink(
//                   padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: controller.paymentselection.value == 2
//                         ?Color(0xffE2136E): Colors.grey.shade300,
                         
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Image.asset(
//                           "assets/images/1656235654bkash-logo-white.png",
//                           width: 120,
//                           height: 50,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           controller.paymentselection.value = 2;
//                         },
//                         icon: CircleAvatar(
//                           radius: 10,
//                           backgroundColor: Colors.white,
//                           child: Obx(
//                             () => Container(
//                               height: 12,
//                               width: 12,
//                               decoration: BoxDecoration(
//                                 color: controller.paymentselection.value == 2
//                                     ? Colors.black54
//                                     : Colors.white,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),

//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Total Price",
//                       style: globalTextStyle(color: AppColors.primaryTextColor),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "৳ ",
//                           style: globalTextStyle(
//                             color: AppColors.primaryColor,
//                             fontSize: 28,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         Text(
//                           controller.discountedPrice(
//                             double.parse(pkg.price),
//                             double.parse(pkg.discountValue.toString()),
//                           ),
//                           style: globalTextStyle(
//                             color: AppColors.blackColor,
//                             fontSize: 28,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 CustomButton(
//                   paddingHorizontal: 50.w,
//                   paddingVertical: 18.h,
//                   radius: 20,
//                   onTap: () {
                   
                  
//                   },
//                   title: "Pay Now",
//                   fontSize: 20,
//                 ),
//               ],
//             ),
//             SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }
