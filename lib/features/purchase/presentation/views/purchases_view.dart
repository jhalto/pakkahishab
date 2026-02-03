import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/helper/date_picker_helper.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/views/purchase_payment_view.dart';
import 'package:pakkahishab/features/purchase/presentation/views/purchase_report_view.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_appbar_back_with_search.dart';
import 'package:pakkahishab/features/purchase/presentation/views/purchase_details.dart';

class PurchasesView extends StatelessWidget {
  const PurchasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PurchaseAppbarBackWithSearch(title: "Purchase"),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () {
                return ref
                    .read(purchaseViewModelProvider.notifier)
                    .refreshPurchases();
              },
              child: Consumer(
                builder: (outerContext, ref, child) {
                  final purchaseState = ref.watch(purchaseViewModelProvider);
                  final purchaseNotifier = ref.watch(
                    purchaseViewModelProvider.notifier,
                  );
                  if (purchaseState.loading) {
                    return Center(child: loader);
                  }
                  if (purchaseState.purchaseList.isEmpty) {
                    return Center(child: Text("No purchases"));
                  }
                  return Column(
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
                                    Text(
                                      "Total Item",
                                      style: AppTextStyle.labelLarge,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      purchaseState.purchaseList.isEmpty
                                          ? "0"
                                          : ref
                                                .watch(
                                                  purchaseViewModelProvider,
                                                )
                                                .purchaseList
                                                .first
                                                .totalCount
                                                .toString(),
                                      style: AppTextStyle.labelLarge,
                                    ),
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
                                    Text(
                                      "Total Price",
                                      style: AppTextStyle.labelLarge,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      purchaseState.purchaseList.isEmpty
                                          ? "0"
                                          : ref
                                                .watch(
                                                  purchaseViewModelProvider,
                                                )
                                                .purchaseList
                                                .first
                                                .totalNetAmount
                                                .toString(),
                                      style: AppTextStyle.labelLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 100),
                          itemCount: purchaseState.purchaseList.length,
                          itemBuilder: (context, index) {
                            final item = purchaseState.purchaseList[index];
                            final formattedDate = DateFormat(
                              'dd MMM',
                            ).format(item.purchaseDate);
                            final formattedTime = formatBangladeshTime(
                              item.created,
                            );
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 2,
                                left: 10,
                                right: 10,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          PurchaseDetails(purchase: item),
                                    ),
                                  );

                                  final success = await ref
                                      .read(purchaseViewModelProvider.notifier)
                                      .fetchPurchaseDetails(
                                        purchaseNo: item.purchaseNo,
                                      );
                                  print(success);
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.blackColor.withAlpha(
                                          20,
                                        ),
                                        blurRadius: .00001,
                                        spreadRadius: .01,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                formattedDate,
                                                style: AppTextStyle.bodyMedium
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor2,
                                                      fontSize: 16.sp,
                                                    ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                formattedTime,
                                                style: AppTextStyle.bodySmall
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor2,
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
                                                    item.supplierName
                                                        .toString(),
                                                    style:
                                                        AppTextStyle.bodyMedium,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    item.supplierPhone ??
                                                        "Not Available",
                                                    style: AppTextStyle
                                                        .bodyMediumSecondary,
                                                  ),
                                                ],
                                              ),

                                              Text(
                                                "${item.netAmount.toString()} Tk",
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Consumer(
                                            builder: (context, ref, child) {
                                              return PopupMenuButton(
                                                menuPadding: EdgeInsets.zero,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                    ),
                                                icon: const Icon(
                                                  CupertinoIcons.chevron_down,
                                                  size: 20,
                                                ),
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        purchaseNotifier
                                                            .deletePurchase(
                                                              context,
                                                              purchaseId: item
                                                                  .purchaseId
                                                                  .toString(),
                                                            );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.delete,
                                                            size: 30,
                                                            color: AppColors
                                                                .primaryColor, // Important: Keep white to reveal gradient
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Text("Delete"),
                                                        ],
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () async {
                                                        await ref
                                                            .read(
                                                              purchaseViewModelProvider
                                                                  .notifier,
                                                            )
                                                            .fetchPurchaseDetails(
                                                              purchaseNo: item
                                                                  .purchaseNo,
                                                            );
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                PurchaseReportView(purchaseHead: item,),
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.print,
                                                            size: 30,
                                                            color: AppColors
                                                                .primaryColor, // Important: Keep white to reveal gradient
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Text(
                                                            "Print Invoice",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ];
                                                },
                                              );
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
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return ref
                                      .watch(purchaseViewModelProvider)
                                      .totalPage ==
                                  1
                              ? SizedBox()
                              : PurchasesPagination();
                        },
                      ),
                      // PurchasesPagination(),
                    ],
                  );
                },
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
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: Consumer(
          builder: (context, ref, child) => InkWell(
            onTap: () {
              // ref
              //     .read(purchaseAddViewModelProvider.notifier)
              //     .fetchPurchaseSupplierDues(
              //       context,
              //       supplierAccountNo: ref.read(purchaseAddViewModelProvider),
              //     );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PurchasePaymentView()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisSize: .min,
                children: [
                  Icon(Icons.payment, color: AppColors.whiteColor),
                  SizedBox(width: 5),
                  Text("Make Payment", style: AppTextStyle.bodyMediumWhite),
                ],
              ),
            ),
          ),
        ),
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
  int? _previousPage;

  // Approximate width of each page button (adjust based on your design)
  static const double buttonWidth = 40.0;
  static const double buttonSpacing = 8.0;

  @override
  void initState() {
    super.initState();
    // Scroll to current page after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentPage = ref.read(purchaseViewModelProvider).currentPage;
      if (currentPage > 1) {
        _scrollToPageImmediate(currentPage);
      }
    });
  }

  void _scrollToPageImmediate(int page) {
    if (!_scrollController.hasClients) return;

    final itemWidth = buttonWidth + buttonSpacing;
    final buttonPosition = (page - 1) * itemWidth;
    final viewportWidth = _scrollController.position.viewportDimension;
    final targetOffset =
        buttonPosition - (viewportWidth / 2) + (buttonWidth / 2);

    // Jump immediately without animation for initial positioning
    _scrollController.jumpTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
    );
  }

  void _scrollToPage(int page) {
    if (!mounted) return;

    // Use a longer delay to ensure the UI has updated
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted || !_scrollController.hasClients) return;

      final itemWidth = buttonWidth + buttonSpacing;
      final buttonPosition = (page - 1) * itemWidth;
      final viewportWidth = _scrollController.position.viewportDimension;
      final targetOffset =
          buttonPosition - (viewportWidth / 2) + (buttonWidth / 2);

      _scrollController.animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
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
    print("total purchase view page = $totalPage");

    // Detect page change and scroll to it
    if (_previousPage != null && _previousPage != currentPage) {
      _scrollToPage(currentPage);
    }
    _previousPage = currentPage;

    if (totalPage == 0) return const SizedBox();

    final pages = List.generate(totalPage, (index) => index + 1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: currentPage > 1
                ? () => notifier.goToPage(currentPage - 1)
                : null,
          ),

          Flexible(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: pages.map((page) {
                  final isActive = page == currentPage;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () => notifier.goToPage(page),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(minWidth: 40),
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
                ? () => notifier.goToPage(currentPage + 1)
                : null,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
