import 'package:flutter/material.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';

class PurchaseProductAdd extends StatelessWidget {
  const PurchaseProductAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          showBottomSheet(
            
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                  left: 18,
                  right: 18,
                  top: 20,
                ),

                child: Column(),
              );
            },
          );
        },
        child: Container(
        
          decoration: BoxDecoration(color: AppColors.fillColor2,
          borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ),

          child: Row(
            mainAxisAlignment: .center,
            children: [
              Icon(Icons.add_circle_outline_rounded ,color: AppColors.koraNeel,),
              SizedBox(width: 10,),
              Text("Add Items (Optional)",style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.koraNeel
              ), )
            ],
          ),
        ),
      ),
    );
  }
}
