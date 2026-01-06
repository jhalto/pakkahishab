import 'package:flutter/material.dart';

import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_fullwidth_button.dart';
import 'package:pakkahishab/features/sales/presentation/widgets/add_sales_summury.dart';
import 'package:pakkahishab/features/sales/presentation/widgets/invoice_name_date_widget.dart';
import 'package:pakkahishab/features/sales/presentation/widgets/sales_customer_widget.dart';
import 'package:pakkahishab/features/sales/presentation/widgets/sales_product_widget.dart';
import 'package:pakkahishab/features/sales/presentation/widgets/sales_product_item_widget.dart';


class SaleAdd extends StatelessWidget {
  const SaleAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Sales"),
      body: Column(
        children: [
            InvoiceNameDateWidget(),
            SizedBox(height: 10,),
            SalesCustomerWidget(),
            SizedBox(height: 10,),
            SalesProductWidget(),
            SizedBox(height: 10,),
            SalesProductItemWidget(),
            SizedBox(height: 10,),
            AddSalesSummury(),
            SizedBox(height: 20,),  
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
              child: CustomFullwidthButton(onTap: ()async{}, title: "Add Sales"))
        
   
        ],
      ),
    );
  }
}