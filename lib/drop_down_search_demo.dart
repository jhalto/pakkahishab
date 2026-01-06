import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropDownSearchDemo extends StatelessWidget {
  const DropDownSearchDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: DropdownSearch()),
    );
  }
}