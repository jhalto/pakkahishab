import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';

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
              final vm = ref.watch(homeViewModelProvider);
              return DrawerHeader(
                // currentAccountPictureSize: Size(70, 70),
                margin: EdgeInsets.only(bottom: 0),
                decoration: BoxDecoration(color: AppColors.primaryColor),
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
                  ExpansionTile(
                    leading: const Icon(Icons.shopping_cart), // 🛒 Purchase
                    title: Text("Purchase", style:AppTextStyle. bodyLarge),
                    children: [
                      ListTile(
                        title: Text("New Purchase"),
                        leading:const Icon(FontAwesomeIcons.cartShopping),
                      ),
                      ListTile(
                        title: Text("Purchase Return"),
                        leading:const Icon(FontAwesomeIcons.arrowRotateLeft),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(Icons.point_of_sale), // 💰 Sales
                    title: Text("Sales", style:AppTextStyle.bodyLarge),
                    children: [
                      ListTile(
                        title: Text("New Sales"),
                        leading:const Icon(FontAwesomeIcons.cashRegister),
                      ),
                      ListTile(
                        title: Text("Sales Return"),
                        leading:const Icon(FontAwesomeIcons.arrowRotateLeft),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(Icons.money_off), // 💸 Expenses
                    title: Text("Expenses", style:AppTextStyle. bodyLarge),
                    children: [
                      ListTile(
                        title: Text("Head"),
                        leading:const Icon(Icons.category),
                      ),
                      ListTile(
                        title: Text("Add Expenses"),
                        leading:const Icon(Icons.add_circle_outline),
                      ),
                      ListTile(
                        title: Text("Edit Expenses"),
                        leading:const Icon(Icons.edit),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(Icons.attach_money), // 💵 Income
                    title: Text("Income", style:AppTextStyle.bodyLarge),
                    children: [
                      ListTile(
                        title: Text("Head"),
                        leading:const Icon(Icons.category),
                      ),
                      ListTile(
                        title: Text("Add Income"),
                        leading:const Icon(Icons.add_circle_outline),
                      ),
                      ListTile(
                        title: Text("Edit Income"),
                        leading:const Icon(Icons.edit),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(Icons.payment), // 📑 Due
                    title: Text("Due", style:AppTextStyle.bodyLarge),
                    children: [
                      ListTile(
                        title: Text("Supplier Due"),
                        leading:const Icon(Icons.store),
                      ),
                      ListTile(
                        title: Text("Customer Due"),
                        leading:const Icon(Icons.person),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(Icons.savings), // 💳 Advance
                    title: Text("Advance", style:AppTextStyle.bodyLarge),
                    children: [
                      ListTile(
                        title: Text("Head"),
                        leading:const Icon(Icons.category),
                      ),
                      ListTile(
                        title: Text("Add Advance"),
                        leading:const Icon(Icons.add_circle_outline),
                      ),
                      ListTile(
                        title: Text("Edit Advance"),
                        leading:const Icon(Icons.edit),
                      ),
                      ListTile(
                        title: Text("Advance Refund"),
                        leading:const Icon(Icons.undo),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(Icons.account_balance), // 🏦 Loan
                    title: Text("Loan", style:AppTextStyle.bodyLarge),
                    children: [
                      ListTile(
                        title: Text("Head"),
                        leading:const Icon(Icons.category),
                      ),
                      ListTile(
                        title: Text("Add Loan"),
                        leading:const Icon(Icons.add_circle_outline),
                      ),
                      ListTile(
                        title: Text("Edit Loan"),
                        leading:const Icon(Icons.edit),
                      ),
                      ListTile(
                        title: Text("Loan Pay"),
                        leading:const Icon(Icons.payments),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(Icons.insert_chart), // 📊 Reports
                    title: Text("Reports", style:AppTextStyle.bodyLarge),
                    children: [
                      ListTile(
                        title: Text("Transaction Reports"),
                        leading:const Icon(Icons.receipt_long),
                      ),
                      ListTile(
                        title: Text("Stock Reports"),
                        leading:const Icon(Icons.inventory),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(Icons.settings), // ⚙️ Settings
                    title: Text("Settings", style:AppTextStyle.bodyLarge),
                    children: [
                      ListTile(
                        title: Text("Company Info"),
                        leading:const Icon(Icons.business),
                      ),
                      ListTile(
                        title: Text("Chart of Accounts"),
                        leading:const Icon(Icons.account_tree),
                      ),
                      ListTile(
                        title: Text("Supplier"),
                        leading:const Icon(Icons.store),
                      ),
                      ListTile(
                        title: Text("Customer"),
                        leading:const Icon(Icons.people),
                      ),
                      ListTile(
                        title: Text("Product"),
                        leading:const Icon(Icons.shopping_bag),
                      ),
                      ListTile(
                        title: Text("Edit Profile"),
                        leading:const Icon(Icons.edit),
                      ),
                      ListTile(
                        title: Text("Opening Balance"),
                        leading:const Icon(Icons.account_balance_wallet),
                      ),
                      ListTile(
                        title: Text("Supplier Opening Balance"),
                        leading:const Icon(Icons.store_mall_directory),
                      ),
                      ListTile(
                        title: Text("Customer Opening Balance"),
                        leading:const Icon(Icons.people_alt),
                      ),
                    ],
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final vm = ref.read(homeViewModelProvider);

                      return ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("Logout"),
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
