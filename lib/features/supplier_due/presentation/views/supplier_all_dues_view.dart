import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/helper/navigation_helper.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/supplier_due/presentation/viewmodels/supplier_due_viewmodel.dart';

import 'package:pakkahishab/features/supplier_due/presentation/views/supplier_due_details.dart';
import 'package:pakkahishab/features/supplier_due/presentation/widgets/supplier_due_appbar_back_with_search.dart';
import 'package:intl/intl.dart';

class SupplierAllDuesView extends StatelessWidget {
  const SupplierAllDuesView({super.key, e});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: SupplierDueAppbarBackWithSearch(title: "Supplier Due History"),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () {
                return ref
                    .read(customerDueViewModelProvider.notifier)
                    .refreshPurchases();
              },
              child: Consumer(
                builder: (outerContext, ref, child) {
                  final dueState = ref.watch(customerDueViewModelProvider);
                  

                  if (dueState.loading) {
                    return Center(child: loader);
                  }

                  if (dueState.supplierDueDetails == null) {
                    return Center(child: Text("No Dues"));
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
                                      "Due Purchases",
                                      style: AppTextStyle.labelLarge,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      dueState.supplierTotalDuesCount
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
                                      "Total Due",
                                      style: AppTextStyle.labelLarge,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      dueState.supplierTotalDues.toString(),
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
                          itemCount: dueState.supplierDueDetails!.items.length,
                          itemBuilder: (context, index) {
                            final item =
                                dueState.supplierDueDetails!.items[index];
                            final formattedDate = item.purchaseDate != null
                                ? DateFormat('dd MMM').format(item.purchaseDate!)
                                : '';
                            final formattedTime = item.purchaseDate != null
                                ? DateFormat('hh:mma ').format(item.purchaseDate!)
                                : '';
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                left: 10,
                                right: 10,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  ref
                                      .read(
                                        customerDueViewModelProvider.notifier,
                                      )
                                      .fetchSupplierPurchasesMaster(
                                        purchaseNo: item.purchaseNo,
                                        supplierId: item.supplierId,
                                      );
                                  navigateWithSlide(
                                    context: context,
                                    page: SupplierDueDetails(),
                                  );
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
                                    vertical: 8,
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
                                                style: AppTextStyle.bodyLarge
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor2,
                                                    
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
                                                    item.accountName.toString(),

                                                    style:
                                                        AppTextStyle.labelLarge,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Phone: ",
                                                        style: AppTextStyle
                                                            .bodySmall,
                                                      ),
                                                      Text(
                                                        item.phoneNo,
                                                        style: AppTextStyle
                                                            .bodySmall,
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 10),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${item.amount.toString()} Tk",
                                                    style:
                                                        AppTextStyle.labelLarge,
                                                  ),
                                                  Text(
                                                    "Payable",
                                                    style: AppTextStyle
                                                        .bodyMedium
                                                        .copyWith(
                                                          color: AppColors
                                                              .errorTextColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
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
                                                                Color(
                                                                  0xFF4FACFE,
                                                                ),
                                                                Color(
                                                                  0xFF00F2FE,
                                                                ),
                                                              ],
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                            ).createShader(
                                                              bounds,
                                                            ),
                                                        child: const Icon(
                                                          Icons.print,
                                                          size: 30,
                                                          color: Colors
                                                              .white, // Important: Keep white to reveal gradient
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Text(
                                                        "Print Invoice",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  onTap: () {},
                                                  child: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .local_print_shop_sharp,
                                                        color: AppColors
                                                            .accentTextColor,
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
                        ),
                      ),
                      PurchasesPagination(),
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
  int? _previousPage;

  // Approximate width of each page button (adjust based on your design)
  static const double buttonWidth = 40.0;
  static const double buttonSpacing = 8.0;

  @override
  void initState() {
    super.initState();
    // Scroll to current page after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentPage = ref.read(customerDueViewModelProvider).currentPage;
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
    final purchaseState = ref.watch(customerDueViewModelProvider);
    final notifier = ref.read(customerDueViewModelProvider.notifier);

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
