import 'package:flutter/material.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/features/purchase/data/models/all_supplier_model.dart';

class UpdateSupplierView extends StatelessWidget {

  final AllSupplier supplier;
  const UpdateSupplierView({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Update Supplier"),
    );
  }
}