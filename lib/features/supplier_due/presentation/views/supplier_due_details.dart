import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/utils/custom_box_shadow.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';
import 'package:pakkahishab/features/supplier_due/presentation/viewmodels/supplier_due_viewmodel.dart';

class SupplierDueDetails extends StatelessWidget {

 const SupplierDueDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Supplier Due Details"),
      body: Consumer(
        builder: (context, ref, child) {
          if (ref.watch(customerDueViewModelProvider).loading) {
            return Center(child: loader);
          }
          final data = ref.watch(customerDueViewModelProvider).supplierDueDetails;
          
          final purchaseMaseter = ref.watch(customerDueViewModelProvider).purchaseList.first;
          final item = ref
              .watch(customerDueViewModelProvider)
              .purchaseDetails!.items.first;
            

          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [CustomBoxShadow.defaultShadow],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bill No: ${item.purchaseNo}"),
                    Text(
                      "Date: ${DateFormat("dd:MM:yyyy").format(item.purchaseDate!)}",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [CustomBoxShadow.defaultShadow],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("Total Payable: ${purchaseMaseter.due.toStringAsFixed(0)}"),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text("Party", style: AppTextStyle.labelLarge),
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: AppColors.dotColor),
                      ),
                      child: Text(
                        item.supplierName,
                        style: AppTextStyle.titleSmall,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Products",
                          style: AppTextStyle.labelLarge,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Quantity",
                          style: AppTextStyle.labelLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Unit Price",
                          style: AppTextStyle.labelLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Total",
                          style: AppTextStyle.labelLarge,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer(
                  builder: (context, ref, child) {
                    final vm = ref.watch(customerDueViewModelProvider);
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: vm.purchaseDetails!.items.length,
                      itemBuilder: (context, index) {
                        final product = vm.purchaseDetails!.items[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.product,
                                      
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      product.quantity.toString(),
                                      
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      product.unitPrice.toString(),
                                      
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      product.subTotal.toString(),
                                      
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.edit, size: 20),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.fillColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Net Amount",
                                  style: AppTextStyle.bodyLarge,
                                ),
                                Icon(
                                  FontAwesomeIcons.bangladeshiTakaSign,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.dotColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                purchaseMaseter.netAmount.toString(),
                                
                                style: AppTextStyle.titleSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: AppTextStyle.bodyLarge,
                                ),
                                Icon(
                                  FontAwesomeIcons.bangladeshiTakaSign,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.dotColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                purchaseMaseter.netAmount.toString(),
                              
                                style: AppTextStyle.titleSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Paid Price",
                                  style: AppTextStyle.bodyLarge,
                                ),
                                Icon(
                                  FontAwesomeIcons.bangladeshiTakaSign,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.dotColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                purchaseMaseter.paidPrice.toString(),
                                
                                style: AppTextStyle.titleSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Due", style: AppTextStyle.bodyLarge),
                                Icon(
                                  FontAwesomeIcons.bangladeshiTakaSign,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.dotColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                purchaseMaseter.due.toString(),
                              
                                style: AppTextStyle.titleSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Payment Method",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Consumer(
                        builder: (context, ref, child) {
                          final vm = ref.watch(purchaseViewModelProvider);
                          final vmn = ref.watch(
                            purchaseViewModelProvider.notifier,
                          );
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Container(
                                         padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade400,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: DropdownButton<String>(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          dropdownColor: AppColors.whiteColor,

                                          iconSize: 28,
                                          iconEnabledColor:
                                              AppColors.primaryColor,
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          value: vm.paymentMethod,
                                          hint: const Text("Choose method"),
                                          items: const [
                                            DropdownMenuItem(
                                              value: "Cash",
                                              child: Text("Cash"),
                                            ),
                                            DropdownMenuItem(
                                              value: "Bkash",
                                              child: Text("Bkash"),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            vmn.updatePaymentMethod(value!);
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      TextField(
                                        
                                        decoration: InputDecoration(
                                        
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                          
                                            ),
                                            borderSide: BorderSide(
                                              color: AppColors.dotColor
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                               
                                            ),
                                            borderSide: BorderSide(
                                              color: AppColors.primaryColor
                                            )
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,)
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: AppColors.dotColor,
                                      ),
                                    ),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.add))
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                   padding: EdgeInsets.all(10),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                     color: AppColors.dotColor
                    )
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Description"
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
