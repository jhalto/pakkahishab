import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .85,
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final vm = ref.watch(homeProvider);
              return DrawerHeader(
                // currentAccountPictureSize: Size(70, 70),
                margin: const EdgeInsets.only(bottom: 0),
                decoration: const BoxDecoration(color: AppColors.primaryColor),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(vm.company, style: AppTextStyle.bodyMediumWhite),

                      Text(vm.name, style: AppTextStyle.bodyMediumWhite),
                    ],
                  ),
                ),
                // accountName: Padding(
                //   padding: EdgeInsets.only(top: 25.0),
                //   child: Text(
                //     vm.company, // Fallback while loading
                //     style: titleLarge(context),
                //   ),
                // ),
                // accountEmail: Text(
                //   vm.name, // Fallback while loading
                //   style: TextStyle(fontSize: 16),
                // ),
                // currentAccountPicture: null,
                // // currentAccountPicture: CircleAvatar(
                // //   backgroundImage: AssetImage("lib/images/lorem.png"),
                // // ),
              );
            },
          ),

          Expanded(
            child: Container(
              color: AppColors.primaryColor.withAlpha(10),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.shopping_cart), // 🛒 Purchase
                      title: Text(
                        AppLocalizations.of(context)!.purchase,
                        style: AppTextStyle.bodyLarge,
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.newPurchase,
                          ),
                          leading: const Icon(FontAwesomeIcons.cartShopping),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.purchaseReturn,
                          ),
                          leading: const Icon(FontAwesomeIcons.arrowRotateLeft),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.point_of_sale), // 💰 Sales
                      title: Text(
                        AppLocalizations.of(context)!.sales,
                        style: AppTextStyle.bodyLarge,
                      ),
                      children: [
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.newSales),
                          leading: const Icon(FontAwesomeIcons.cashRegister),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.salesReturn,
                          ),
                          leading: const Icon(FontAwesomeIcons.arrowRotateLeft),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.money_off), // 💸 Expenses
                      title: Text(
                        AppLocalizations.of(context)!.expenses,
                        style: AppTextStyle.bodyLarge,
                      ),
                      children: [
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.head),
                          leading: const Icon(Icons.category),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.addExpenses,
                          ),
                          leading: const Icon(Icons.add_circle_outline),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.editExpenses,
                          ),
                          leading: const Icon(Icons.edit),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.attach_money), // 💵 Income
                      title: Text(
                        AppLocalizations.of(context)!.income,
                        style: AppTextStyle.bodyLarge,
                      ),
                      children: [
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.head),
                          leading: const Icon(Icons.category),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.addIncome),
                          leading: const Icon(Icons.add_circle_outline),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.editIncome),
                          leading: const Icon(Icons.edit),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.payment), // 📑 Due
                      title: Text(
                        AppLocalizations.of(context)!.due,
                        style: AppTextStyle.bodyLarge,
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.supplierDue,
                          ),
                          leading: const Icon(Icons.store),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.customerDue,
                          ),
                          leading: const Icon(Icons.person),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.savings), // 💳 Advance
                      title: Text(
                        AppLocalizations.of(context)!.advance,
                        style: AppTextStyle.bodyLarge,
                      ),
                      children: [
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.head),
                          leading: const Icon(Icons.category),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.addAdvance),
                          leading: const Icon(Icons.add_circle_outline),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.editAdvance,
                          ),
                          leading: const Icon(Icons.edit),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.advanceRefund,
                          ),
                          leading: const Icon(Icons.undo),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.account_balance), // 🏦 Loan
                      title: Text(
                        AppLocalizations.of(context)!.loan,
                        style: AppTextStyle.bodyLarge,
                      ),
                      children: [
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.head),
                          leading: const Icon(Icons.category),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.addLoan),
                          leading: const Icon(Icons.add_circle_outline),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.editLoan),
                          leading: const Icon(Icons.edit),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.loanPay),
                          leading: const Icon(Icons.payments),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.insert_chart), // 📊 Reports
                      title: Text(
                        AppLocalizations.of(context)!.reports,
                        style: AppTextStyle.bodyLarge,
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.transactionReports,
                          ),
                          leading: const Icon(Icons.receipt_long),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.stockReports,
                          ),
                          leading: const Icon(Icons.inventory),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.settings), // ⚙️ Settings
                      title: Text(
                        AppLocalizations.of(context)!.settings,
                        style: AppTextStyle.bodyLarge,
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.companyInfo,
                          ),
                          leading: const Icon(Icons.business),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.chartOfAccounts,
                          ),
                          leading: const Icon(Icons.account_tree),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.supplier),
                          leading: const Icon(Icons.store),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.customer),
                          leading: const Icon(Icons.people),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.product),
                          leading: const Icon(Icons.shopping_bag),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.editProfile,
                          ),
                          leading: const Icon(Icons.edit),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.openingBalance,
                          ),
                          leading: const Icon(Icons.account_balance_wallet),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(
                              context,
                            )!.supplierOpeningBalance,
                          ),
                          leading: const Icon(Icons.store_mall_directory),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(
                              context,
                            )!.customerOpeningBalance,
                          ),
                          leading: const Icon(Icons.people_alt),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final vm = ref.read(homeProvider.notifier);

                      return ListTile(
                        leading: const Icon(Icons.logout),
                        title: Text(AppLocalizations.of(context)!.logout),
                        onTap: () {
                          vm.logout(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
