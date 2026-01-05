// // ignore_for_file: avoid_print

// import 'dart:convert';

// import 'package:bd_tender/core/const/app_colors.dart';
// import 'package:bd_tender/core/const/app_text_style.dart';
// import 'package:bd_tender/core/const/urls.dart';
// import 'package:bd_tender/core/global_widgets/custom_button.dart';
// import 'package:bd_tender/core/utils/show_snackbar.dart';
// import 'package:bd_tender/models/package_model.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;


// class PackagesController extends GetxController {
//   String? ip;
//   @override
//   void onInit() {
//     super.onInit();
//     fetchPackages();
//     sortPackages();
//     getPublicIpAddress();
//   }

//   RxInt paymentselection = 1.obs;

//   RxString sortBy = "price".obs;

//   void showSuccesDialog(BuildContext context) {
//     showAdaptiveDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog.adaptive(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadiusGeometry.circular(10),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,

//             children: [
//               CircleAvatar(
//                 radius: 30,
//                 backgroundColor: AppColors.primaryColor,
//                 child: Icon(Icons.done, size: 30, color: Colors.white),
//               ),
//               const SizedBox(height: 18),
//               const Text("Success !", style: titleExtraLarge),
//               SizedBox(height: 5.h),
//               const Text("Your payment was successful.", style: bodyMedium),
//               const Text("A receipt for this purchase has", style: bodyMedium),
//               const Text("been sent to your email", style: bodyMedium),
//               const SizedBox(height: 30),
//               CustomButton(
//                 paddingVertical: 10,
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 title: "Go Back",
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void sortPackages() {
//     // Separate the "Jitaw" package
//     final jitaw = packages.firstWhereOrNull(
//       (p) => p.title.toLowerCase() == 'jitaw',
//     );
//     final filteredPackages = packages
//         .where((p) => p.title.toLowerCase() != 'jitaw')
//         .toList();

//     if (sortBy.value == 'price') {
//       filteredPackages.sort((a, b) {
//         int priceA =
//             int.tryParse(a.price.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
//         int priceB =
//             int.tryParse(b.price.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
//         return priceA.compareTo(priceB);
//       });
//     } else if (sortBy.value == 'duration') {
//       filteredPackages.sort((a, b) {
//         int daysA = _durationInDays(a.duration);
//         int daysB = _durationInDays(b.duration);
//         return daysA.compareTo(daysB);
//       });
//     }

//     // Rebuild the observable list
//     packages.value = [...filteredPackages, if (jitaw != null) jitaw];
//   }

//   int _durationInDays(String duration) {
//     duration = duration.toLowerCase();
//     if (duration.contains('day')) {
//       return int.tryParse(duration.split(' ')[0]) ?? 0;
//     } else if (duration.contains('month')) {
//       return (int.tryParse(duration.split(' ')[0]) ?? 0) * 30;
//     } else if (duration.contains('year')) {
//       return (int.tryParse(duration.split(' ')[0]) ?? 0) * 365;
//     }
//     return 0;
//   }

//   final RxList<Package> packages = <Package>[].obs;

//   RxBool packageLoading = false.obs;
//   String discountedPrice(double price, double discountValue) {
//     final double discounted = price - (price * discountValue);
//     return discounted.toInt().toString();
//   }

//   Future<void> fetchPackages() async {
//     const String url = "https://bdtender.com/api/app-plans";

//     try {
//       packageLoading.value = true;
//       var response = await http.post(
//         Uri.parse(url),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"auth_token": Urls.auth}),
//       );

//       if (response.statusCode == 200) {
//         var responseData = jsonDecode(response.body);
//         if (kDebugMode) {
//           print(responseData);
//         }
//         var planList = responseData['pricing_plans'] as List;

//         // Convert to List<Package>
//         List<Package> fetchedPackages = planList
//             .map((e) => Package.fromJson(e))
//             .toList();

//         // Replace the packages list
//         packages.value = fetchedPackages;

//         // Now apply sorting
//         sortPackages();
//         packageLoading.value = false;
//       } else {
//         packageLoading.value = false;

//         if (kDebugMode) {
//           print("Failed with status code: ${response.statusCode}");
//         }
//         if (kDebugMode) {
//           print(response.body);
//         }
//       }
//     } catch (e) {
//       packageLoading.value = false;

//       if (kDebugMode) {
//         print("Error: $e");
//       }
//     }
//   }

  
 

//   Future<void> getPublicIpAddress() async {
    
//     try {
//       final response = await http.get(Uri.parse(Urls.ip));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         ip = data['ip'];
//         if (kDebugMode) {
//           print("dsjfa $ip");
//         }
//       } else {
//         showCustomSnackBar("Failed to get IP address");
//       }
//     } catch (e) {
//       print("Error fetching IP: $e");
//     }
//   }
// }
