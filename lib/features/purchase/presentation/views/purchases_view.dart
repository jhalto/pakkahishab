import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back_with_search.dart';
import 'package:pakkahishab/features/purchase/presentation/views/purchase_details.dart';

class PurchasesView extends StatelessWidget {
  const PurchasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBackWithSearch(title: "Purchases"),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: Colors.white,
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Total Item", style: AppTextStyle.labelLarge),
                          const SizedBox(height: 2),
                          Text("2", style: AppTextStyle.labelLarge),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: VerticalDivider(),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Total Price", style: AppTextStyle.labelLarge),
                          const SizedBox(height: 2),
                          Text("2", style: AppTextStyle.labelLarge),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final purchaseState = ref.watch(purchaseViewModelProvider);
                  if (purchaseState.loading) {
                    return loader;
                  }
                  if (purchaseState.purchaseList.isEmpty) {
                    return Center(child: Text("No purchases"));
                  }
                  return ListView.builder(
                    itemCount: purchaseState.purchaseList.length,
                    itemBuilder: (context, index) {
                      final item = purchaseState.purchaseList[index];
                      final formattedDate = DateFormat(
                        'dd MMM',
                      ).format(item.purchaseDate);
                      final formattedTime = DateFormat(
                        'hh:mma ',
                      ).format(item.purchaseDate);
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 2,
                          left: 10,
                          right: 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(purchaseViewModelProvider.notifier)
                                .fetchPurchaseDetails(
                                  context,
                                  purchaseNo: item.purchaseNo,
                                );
                            final data = ref
                                .read(purchaseViewModelProvider)
                                .purchaseDetails;
                            if (data != null && context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PurchaseDetails(),
                                ),
                              );
                            }
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.blackColor.withAlpha(20),
                                  blurRadius: .00001,
                                  spreadRadius: .01,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      children: [
                                        Text(
                                          formattedDate,
                                          style: AppTextStyle.bodyMedium
                                              .copyWith(
                                                color: AppColors.primaryColor2,
                                                fontSize: 16.sp,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          formattedTime,
                                          style: AppTextStyle.bodySmall
                                              .copyWith(
                                                color: AppColors.primaryColor2,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: AppColors.fillColor2,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.supplierName.toString(),
                                              style: AppTextStyle.bodyMedium,
                                            ),
                                            Text(
                                              item.mobile,
                                              style: AppTextStyle.bodySmall,
                                            ),

                                            const SizedBox(height: 10),
                                            Text(
                                              "${item.netAmount.toString()} Tk",
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (item.due == 0)
                                              Text(
                                                "Paid",
                                                style: AppTextStyle.bodyMedium
                                                    .copyWith(
                                                      color: const Color(
                                                        0xff50AA53,
                                                      ),
                                                    ),
                                              ),

                                            if (item.due == item.netAmount)
                                              Text(
                                                "Unpaid",
                                                style: AppTextStyle.bodyMedium
                                                    .copyWith(
                                                      color: const Color(
                                                        0xfff5a848,
                                                      ),
                                                    ),
                                              ),
                                            if (item.due != 0 &&
                                                item.due != item.netAmount)
                                              Text(
                                                "Partial",
                                                style: AppTextStyle.bodyMedium
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor2,
                                                    ),
                                              ),
                                            if (item.due != 0)
                                              Text(
                                                item.due.toString(),
                                                style: AppTextStyle.bodyMedium
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor2,
                                                    ),
                                              ),

                                            // if (item.due == item.netAmount)
                                            //   Text(
                                            //     item.netAmount.toString(),
                                            //     style:
                                            //         AppTextStyle.bodyMedium,
                                            //   ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: PopupMenuButton(
                                      menuPadding: EdgeInsets.zero,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      icon: const Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 20,
                                      ),
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                ShaderMask(
                                                  shaderCallback: (bounds) =>
                                                      const LinearGradient(
                                                        colors: [
                                                          Color(0xFF4FACFE),
                                                          Color(0xFF00F2FE),
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ).createShader(bounds),
                                                  child: const Icon(
                                                    Icons.print,
                                                    size: 30,
                                                    color: Colors
                                                        .white, // Important: Keep white to reveal gradient
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Text("Print Invoice"),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            onTap: () {},
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.local_print_shop_sharp,
                                                  color:
                                                      AppColors.accentTextColor,
                                                ),
                                                SizedBox(width: 10),
                                                Text("Print Invoice"),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Consumer(
            //   builder: (context, ref, _) {
            //     final purchaseState = ref.watch(purchaseViewModelProvider);
            //     final notifier = ref.read(purchaseViewModelProvider.notifier);

            //     final int currentPage = purchaseState.currentPage;
            //     final int totalPage = purchaseState.totalPage;

            //     if (totalPage == 0) return const SizedBox();

            //     // How many pages to show in the window at a time (optional)
            //     int maxVisiblePages = totalPage;
            //     int startPage = (currentPage - 2).clamp(1, totalPage);
            //     int endPage = (startPage + maxVisiblePages - 1).clamp(
            //       1,
            //       totalPage,
            //     );

            //     if (endPage - startPage + 1 < maxVisiblePages) {
            //       startPage = (endPage - maxVisiblePages + 1).clamp(
            //         1,
            //         totalPage,
            //       );
            //     }

            //     final pages = List.generate(
            //       endPage - startPage + 1,
            //       (index) => startPage + index,
            //     );

            //     return Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 100),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           // Previous button (fixed)
            //           IconButton(
            //             icon: const Icon(Icons.arrow_back_ios, size: 18),
            //             onPressed: currentPage > 1
            //                 ? () => notifier.goToPage(currentPage - 1)
            //                 : null,
            //           ),

            //           // Scrollable page numbers
            //           Expanded(
            //             child: SingleChildScrollView(
            //               scrollDirection: Axis.horizontal,
            //               child: Row(
            //                 children: pages.map((page) {
            //                   final isActive = page == currentPage;
            //                   return Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                       horizontal: 4,
            //                     ),
            //                     child: InkWell(
            //                       onTap: () => notifier.goToPage(page),
            //                       borderRadius: BorderRadius.circular(8),
            //                       child: Container(
            //                         padding: const EdgeInsets.symmetric(
            //                           horizontal: 10,
            //                           vertical: 6,
            //                         ),
            //                         decoration: BoxDecoration(
            //                           color: isActive
            //                               ? AppColors.primaryColor2
            //                               : Colors.grey.shade200,
            //                           borderRadius: BorderRadius.circular(8),
            //                         ),
            //                         child: Text(
            //                           "$page",
            //                           style: TextStyle(
            //                             color: isActive
            //                                 ? Colors.white
            //                                 : Colors.black87,
            //                             fontWeight: isActive
            //                                 ? FontWeight.bold
            //                                 : FontWeight.normal,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 }).toList(),
            //               ),
            //             ),
            //           ),

            //           // Next button (fixed)
            //           IconButton(
            //             icon: const Icon(Icons.arrow_forward_ios, size: 18),
            //             onPressed: currentPage < totalPage
            //                 ? () => notifier.goToPage(currentPage + 1)
            //                 : null,
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
            PurchasesPagination(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100),
        ),
        child: Icon(CupertinoIcons.add, color: AppColors.whiteColor),
      ),
    );
  }
}

class PurchasesPagination extends ConsumerStatefulWidget {
  const PurchasesPagination({super.key});

  @override
  ConsumerState<PurchasesPagination> createState() =>
      _PurchasesPaginationState();
}

class _PurchasesPaginationState extends ConsumerState<PurchasesPagination> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _pageKeys = {};

  void _scrollToPage(int page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final key = _pageKeys[page];
      if (key == null) return;

      final context = key.currentContext;
      if (context == null) return;

      final box = context.findRenderObject() as RenderBox;
      final scrollableBox =
          _scrollController.position.context.storageContext.findRenderObject()
              as RenderBox;

      // Get offset of page relative to scrollable
      final offset =
          _scrollController.offset +
          box.localToGlobal(Offset.zero, ancestor: scrollableBox).dx +
          box.size.width / 2 -
          scrollableBox.size.width / 2;

      _scrollController.animateTo(
        offset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final purchaseState = ref.watch(purchaseViewModelProvider);
    final notifier = ref.read(purchaseViewModelProvider.notifier);

    final currentPage = purchaseState.currentPage;
    final totalPage = purchaseState.totalPage;

    if (totalPage == 0) return const SizedBox();

    final pages = List.generate(totalPage, (index) => index + 1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: currentPage > 1
                ? () {
                    notifier.goToPage(currentPage - 1);
                    _scrollToPage(currentPage - 1);
                  }
                : null,
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: pages.map((page) {
                  _pageKeys.putIfAbsent(page, () => GlobalKey());
                  final isActive = page == currentPage;
                  return Padding(
                    key: _pageKeys[page],
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () {
                        notifier.goToPage(page);
                        _scrollToPage(page);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primaryColor2
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "$page",
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.black87,
                            fontWeight: isActive
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: currentPage < totalPage
                ? () {
                    notifier.goToPage(currentPage + 1);
                    _scrollToPage(currentPage + 1);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
