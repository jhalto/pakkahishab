import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/routes/app_routes.dart';

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
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                              context,
                              Routes.supplierpurchase,
                            );
                          },
                          title: Text(
                            AppLocalizations.of(context)!.purchase,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(FontAwesomeIcons.cartShopping),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.addPurchase);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.newPurchase,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(FontAwesomeIcons.cartShopping),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.purchaseReturn,
                            style: AppTextStyle.bodyMediumSecondary,
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
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.customerSales);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.sales,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(FontAwesomeIcons.cashRegister),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.addSales);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.newSales,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(FontAwesomeIcons.cashRegister),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.salesReturn,
                            style: AppTextStyle.bodyMediumSecondary,
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
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.expenses);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.head,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.category),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.addExpenses,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.add_circle_outline),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.editExpenses,
                            style: AppTextStyle.bodyMediumSecondary,
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
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.income);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.head,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.category),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.addIncome,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.add_circle_outline),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.editIncome,
                            style: AppTextStyle.bodyMediumSecondary,
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
                      leading: const Icon(Icons.payment), // 📑 Due
                      title: Text(
                        AppLocalizations.of(context)!.due,
                        style: AppTextStyle.bodyLarge,
                      ),
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.supplierDues);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.supplierDue,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.store),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.customerDues);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.customerDue,
                            style: AppTextStyle.bodyMediumSecondary,
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
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.advance);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.head,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.category),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.addAdvance,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.add_circle_outline),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.advance);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.editAdvance,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.edit),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.advanceRefund,
                            style: AppTextStyle.bodyMediumSecondary,
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
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.loan);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.head,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.category),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.addLoan,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.add_circle_outline),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.loan);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.editLoan,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.edit),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.loanPay,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
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
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.receipt_long),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.stock);
                          },
                          title: Text(
                            AppLocalizations.of(context)!.stockReports,
                            style: AppTextStyle.bodyMediumSecondary,
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
                      leading: const Icon(Icons.person_2), // 📊 Reports
                      title: Text("Supplier", style: AppTextStyle.bodyLarge),
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.supplier);
                          },
                          title: Text(
                            "Supplier",
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.group),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.stock);
                          },
                          title: Text(
                            "Add Supplier",
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.person_add),
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
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.business),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.chartOfAccounts,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.account_tree),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.supplier,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.store),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.customer,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.people),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.product,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.shopping_bag),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.editProfile,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.edit),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.openingBalance,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.account_balance_wallet),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(
                              context,
                            )!.supplierOpeningBalance,
                            style: AppTextStyle.bodyMediumSecondary,
                          ),
                          leading: const Icon(Icons.store_mall_directory),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(
                              context,
                            )!.customerOpeningBalance,
                            style: AppTextStyle.bodyMediumSecondary,
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
                        title: Text(
                          AppLocalizations.of(context)!.logout,
                          style: AppTextStyle.bodyLarge,
                        ),
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
