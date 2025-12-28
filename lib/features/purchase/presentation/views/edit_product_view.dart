import 'package:flutter/material.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Edit Product"),
    );
  }
}