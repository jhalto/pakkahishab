import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/global_widgets/custom_back_button.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';

class CustomAppbarBackWithSearch extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final ValueChanged<String>? onSearchChanged;

  CustomAppbarBackWithSearch({
    super.key,
    required this.title,
    this.onSearchChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  // ValueNotifier to manage search state
  final ValueNotifier<bool> isSearch = ValueNotifier(false);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSearch,
      builder: (context, value, child) {
        return AppBar(
          automaticallyImplyLeading: false,
          leading: CustomBackButton(),
          centerTitle: false,
          title: value
              ? TextField(
                  controller: _controller,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onChanged: onSearchChanged,
                )
              : Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ),
          actions: [
            Consumer(
              builder: (context, ref, child) {
                return PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                  ),
                  color: AppColors.whiteColor,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(child: Text("Supplier")),

                      PopupMenuItem(
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2025),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: AppColors
                                        .primaryColor, // header background & selected date
                                    onPrimary: Colors
                                        .white, // header text & selected date text
                                    onSurface:
                                        Colors.black, // default date text
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (selectedDate != null) {
                            final formattedDate = DateFormat(
                              'yyyy-MM-dd',
                            ).format(selectedDate);

                            // Pass the formatted date to fetchPurchases
                            ref
                                .read(purchaseViewModelProvider.notifier)
                                .fetchPurchases(purchaseDate: formattedDate);
                          }
                        },
                        child: Text("Purchase Date"),
                      ),
                    ];
                  },
                  child: SvgPicture.asset(
                    "assets/icons/filter.svg",
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    height: 18,
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                value ? Icons.close : Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                if (value) {
                  _controller.clear();
                  onSearchChanged?.call('');
                }
                isSearch.value = !value;
              },
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor2, AppColors.primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        );
      },
    );
  }
}
