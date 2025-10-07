import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pakkahishab/features/home/presentation/widgets/body_middle_part.dart';
import 'package:pakkahishab/features/home/presentation/widgets/body_top_part.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BodyTopPart(),
        SizedBox(height: 8),
        BodyMiddlePart(),
        
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: Consumer(
        //       builder: (context, ref, child) {
        //         final vm = ref.watch(homeProvider); // use watch instead of read

        //         return GridView.builder(
        //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2,
        //             childAspectRatio: 2.5,
        //             crossAxisSpacing: 10,
        //           ),

        //           itemCount: vm.items.length,
        //           itemBuilder: (context, index) {
        //             return Padding(
        //               padding: const EdgeInsets.only(bottom: 10),
        //               child: InkWell(
        //                 onTap: () {},
        //                 child: Ink(
        //                   padding: const EdgeInsets.all(10),
        //                   decoration: BoxDecoration(
        //                     border: Border.all(
        //                       color: AppColors.primaryColor4.withAlpha(50),
        //                       width: 3,
        //                       strokeAlign: .3,
        //                     ),
        //                     borderRadius: BorderRadius.circular(8),
        //                   ),
        //                   child: Row(
        //                     children: [
        //                       Container(
        //                         padding: EdgeInsets.all(8),
        //                         decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(8),
        //                           color: AppColors.primaryColor2,
        //                         ),

        //                         child: Icon(
        //                           vm.icons[index],
        //                           color: AppColors.whiteColor,
        //                         ),
        //                       ),
        //                       SizedBox(width: 20),
        //                       Expanded(
        //                         child: Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             Text(
        //                               AppLocalizations.of(
        //                                 context,
        //                               )!.translate(vm.items[index]),
        //                             ),
        //                             Text("50"),
        //                           ],
        //                         ),
        //                       ),
        //                       Icon(
        //                         CupertinoIcons.forward,
        //                         color: AppColors.primaryColor2,
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             );
        //           },
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
