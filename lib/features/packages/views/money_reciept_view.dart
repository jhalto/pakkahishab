// import 'package:bd_tender/core/const/app_colors.dart';
// import 'package:bd_tender/core/const/app_text_style.dart';
// import 'package:bd_tender/core/global_widgets/custom_appbar_back.dart';
// import 'package:flutter/material.dart';

// class MoneyRecieptView extends StatelessWidget {
//   const MoneyRecieptView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbarBack(title: "Money Receipt"),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Text("Money Receipt #: ", style: titleSmall),
//                     Text("18103", style: bodyLarge),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text("Date: ", style: titleSmall),
//                     Text("03/08/2025", style: bodyLarge),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 10,),
//             Text(
//               "Received with thanks from: MOHAMMAD SOLAIMAN KHAN,",
//               style: titleSmall,
//               // textAlign: TextAlign.justify,
//               softWrap: true,
//             ),
//             SizedBox(height: 2,),
//             Text(
//               "Director,DIGITAL TECHNOLOGY CARE , +8801826206481 , dtc.",
//               style: bodyLarge,
//             ),
//             Text(
//               "zobayerarmannadim@gmail.com",
//               style: bodyMedium.copyWith(color: AppColors.accentTextColor),
//             ),
//             Divider(),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("The sum of taka: ", style: titleSmall),
//                 Expanded(
//                   child: Text(
//                     "12500 (Including VAT) (Twelve Thousand Five Hundred Taka Only)",
//                     style: bodyLarge,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Payment Method: ", style: titleSmall),
//                 Text("Bkash Merchant", style: bodyLarge),
//               ],
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("On purpose of: ", style: titleSmall),
//                 Expanded(
//                   child: Text(
//                     "Tender Information Service Bill [2025-08-03 to 2027-08-02]",
//                     style: bodyLarge,
//                   ),
//                 ),
//               ],
//             ),
//             Text("Sent by:", style: titleSmall),
//             Text("BDTender Team", style: bodyLarge),
//             Text("Phone: 01789772266", style: bodyLarge),
//             Row(
//               children: [
//                 Text("Email: ", style: bodyLarge),
//                 Text(
//                   "marketing@bdtender.com",
//                   style: bodyLarge.copyWith(
//                     color: AppColors.accentTextColor,
//                     decoration: TextDecoration.underline,
//                     decorationThickness: .8,
//                     decorationColor: AppColors.accentTextColor,
//                   ),
//                 ),
//               ],
//             ),
//             // Divider(),
//             // Text("BDTender.com", style: titleMedium),
//             // Text(
//             //   "House # 116, Road # 5, Mohammadia Housing Society, Mohammadpur, Dhaka-1207, Bangladesh.",
//             //   style: bodyLarge.copyWith(),
//             // ),
//             // Text(
//             //   "Phone: 01789-772266, 01553-651165, 01684-952340",
//             //   style: bodyLarge,
//             // ),
//             // Row(
//             //   children: [
//             //     Text("Email: ", style: bodyLarge),
//             //     Text(
//             //       "marketing@bdtender.com",
//             //       style: bodyLarge.copyWith(
//             //         color: AppColors.accentTextColor,
//             //         decoration: TextDecoration.underline,
//             //         decorationThickness: .8,
//             //         decorationColor: AppColors.accentTextColor,
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             // Row(
//             //   children: [
//             //     Text("Site: ", style: bodyLarge),
//             //     Text(
//             //       "https://www.bdtender.com",
//             //       style: bodyLarge.copyWith(
//             //         color: AppColors.accentTextColor,
//             //         decoration: TextDecoration.underline,
//             //         decorationThickness: .8,
//             //         decorationColor: AppColors.accentTextColor,
//             //       ),
//             //     ),
//             //   ],
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
