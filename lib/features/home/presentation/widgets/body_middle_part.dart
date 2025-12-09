import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/advance/presentation/views/advance_view.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/features/home/presentation/widgets/custom_feature_widget.dart';
import 'package:pakkahishab/features/stock/presentation/views/stock_view.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/routes/app_routes.dart';

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
                onTap: () {
                  Navigator.pushNamed(context, Routes.expenses);
                },  
                title: Text(AppLocalizations.of(context)!.expenses),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).expenses),
                ),
              ),
              const SizedBox(width: 10),
              CustomFeatureWidget(
                onTap: () {
                  Navigator.pushNamed(context, Routes.income);
                },
                title: Text(AppLocalizations.of(context)!.income),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).income),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CustomFeatureWidget(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StockView()));
                },
                title: Text(AppLocalizations.of(context)!.stock),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).stock),
                ),
              ),
              const SizedBox(width: 10),
              CustomFeatureWidget(
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => AdvanceView()));
                },
                title: Text(AppLocalizations.of(context)!.advance),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).advance),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CustomFeatureWidget(
                onTap: () {
                  Navigator.pushNamed(context, Routes.loan);
                },
                title: Text(AppLocalizations.of(context)!.loan),
                consumer: Consumer(
                  builder: (context, ref, child) =>
                      Text(ref.watch(homeProvider).loan),
                ),
              ),
              const SizedBox(width: 10),
              CustomFeatureWidget(
                onTap: () {
                  Navigator.pushNamed(context, Routes.mobileBank);
                },
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
