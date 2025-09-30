import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/features/home/presentation/widgets/custom_feature_widget.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';

class BodyMiddlePart extends StatelessWidget {
  const BodyMiddlePart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              CustomFeatureWidget(
                title: Text(AppLocalizations.of(context)!.expenses),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).expenses),
                ),
              ),
              SizedBox(width: 10),
              CustomFeatureWidget(
                title: Text(AppLocalizations.of(context)!.income),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).income),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CustomFeatureWidget(
                title: Text(AppLocalizations.of(context)!.stock),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).stock),
                ),
              ),
              SizedBox(width: 10),
              CustomFeatureWidget(
                title: Text(AppLocalizations.of(context)!.advance),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).advance),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CustomFeatureWidget(
                title: Text(AppLocalizations.of(context)!.loan),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).loan),
                ),
              ),
              SizedBox(width: 10),
              CustomFeatureWidget(
                title: Text(AppLocalizations.of(context)!.mobileBanking),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).mobileBanking),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
