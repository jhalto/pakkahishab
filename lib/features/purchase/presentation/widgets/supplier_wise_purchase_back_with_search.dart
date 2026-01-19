import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pakkahishab/core/global_widgets/custom_back_button.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_supplier_wise_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';

class SupplierWisePurchaseAppbarBackWithSearch extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final ValueChanged<String>? onSearchChanged;

  SupplierWisePurchaseAppbarBackWithSearch({
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
                final vm = ref.watch(purchaseSupplierWiseViewModel);

                return InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  onTap: () {
                    final RenderBox button =
                        context.findRenderObject() as RenderBox;
                    final Offset position = button.localToGlobal(Offset.zero);

                    showMenu(
                      color: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      position: RelativeRect.fromLTRB(
                        position.dx,
                        position.dy,
                        position.dy,
                        0,
                      ),
                      context: context,
                      items: [
                        PopupMenuItem(
                          onTap: () async {
                            final notifier = ref.read(
                              purchaseSupplierWiseViewModel.notifier,
                            );
                            final vm = ref.read(purchaseSupplierWiseViewModel);

                            if (vm.supplier == null ||
                                (vm.supplier?.items?.isEmpty ?? true)) {
                              notifier.getSupplier();
                            }

                            if (!context.mounted) return;
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.bgColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Consumer(
                                          builder: (context, ref, child) {
                                            final vmn = ref.watch(
                                              purchaseSupplierWiseViewModel
                                                  .notifier,
                                            );

                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller: vmn
                                                        .searchSupplierController,
                                                    autofocus: true,

                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                    decoration: const InputDecoration(
                                                      prefixIcon: Icon(
                                                        CupertinoIcons.search,
                                                      ),
                                                      fillColor:
                                                          AppColors.fillColor,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                            vertical: 14,
                                                            horizontal: 0,
                                                          ),
                                                      filled: true,

                                                      labelText:
                                                          'Search supplier',
                                                      hintStyle: TextStyle(
                                                        color: Colors.white70,
                                                      ),
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    10,
                                                                  ),
                                                                ),
                                                          ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                            ),

                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    10,
                                                                  ),
                                                                ),
                                                          ),
                                                    ),
                                                    onChanged: (value) {
                                                      vmn.searchSupplier(value);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        Expanded(
                                          child: Consumer(
                                            builder: (context, ref, child) {
                                              final notifier = ref.read(
                                                purchaseSupplierWiseViewModel
                                                    .notifier,
                                              );
                                              final vm = ref.watch(
                                                purchaseSupplierWiseViewModel,
                                              );
                                              final supplierList =
                                                  vm.filteredSuppliers ?? [];
                                              if (vm.supplierLoading) {
                                                return Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                      16.0,
                                                    ),
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              }
                                              if (supplierList.isEmpty) {
                                                return Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                      16.0,
                                                    ),
                                                    child: Text(
                                                      'No suppliers available',
                                                    ),
                                                  ),
                                                );
                                              }
                                              return ListView.separated(
                                                itemCount: supplierList.length,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        const Divider(
                                                          color: Colors.grey,
                                                          thickness: 0.5,
                                                          height: 0,
                                                          indent: 16,
                                                          endIndent: 16,
                                                        ),
                                                itemBuilder: (context, index) {
                                                  final supplier =
                                                      supplierList[index];
                                                  return Material(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(16),
                                                        ),
                                                    child: ListTile(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(
                                                                16,
                                                              ),
                                                            ),
                                                      ),
                                                      splashColor: AppColors
                                                          .blackColor
                                                          .withAlpha(20),
                                                      onTap: () {
                                                        notifier
                                                            .updateSupplierId(
                                                              supplier
                                                                  .supplierId,
                                                            );

                                                        Navigator.pop(context);
                                                      },
                                                      title: Text(
                                                        supplier.supplierName,
                                                      ),
                                                      subtitle: Text(
                                                        supplier.mobile,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },

                          child: const Text("Supplier"),
                        ),
                      ],
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/filter.svg",
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      height: 18,
                    ),
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
