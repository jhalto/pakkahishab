import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/helper/navigation_helper.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/sales/presentation/views/sales_add.dart';
import 'package:pakkahishab/features/sales/presentation/viewmodels/sales_viewmodel.dart';
import 'package:pakkahishab/features/sales/presentation/views/sales_view.dart';
import 'package:pakkahishab/features/sales/presentation/widgets/customer_wise_sales_appbar_back_with_search.dart';

class CustomerWiseSalesView extends StatelessWidget {
  const CustomerWiseSalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomerWiseSalesAppbarBackWithSearch(title: "Sales"),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () {
                return ref.read(salesViewModelProvider.notifier).refreshSales();
              },
              child: Consumer(
                builder: (outerContext, ref, child) {
                  final saleState = ref.watch(salesViewModelProvider);
                  final vmn = ref.watch(salesViewModelProvider.notifier);

                  if (saleState.loading) {
                    return Center(child: loader);
                  }
                  if (saleState.customerWiseSalesList.isEmpty) {
                    return Center(child: Text("No Sales"));
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
                                      saleState.customerWiseSalesList.isEmpty
                                          ? "0"
                                          : ref
                                                .watch(salesViewModelProvider)
                                                .customerWiseSalesList
                                                .length
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
                                      saleState.customerWiseSalesList.isEmpty
                                          ? "0"
                                          : ref
                                                .watch(salesViewModelProvider)
                                                .customerWiseSalesList
                                                .first
                                                .totalSalesAmount
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
                          itemCount: saleState.customerWiseSalesList.length,
                          itemBuilder: (context, index) {
                            final item = saleState.customerWiseSalesList[index];
                            // final formattedDate = DateFormat(
                            //   'dd MMM',
                            // ).format(item.salesDate);
                            // final formattedTime = DateFormat(
                            //   'hh:mma ',
                            // ).format(item.salesDate);
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 2,
                                left: 10,
                                right: 10,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  vmn.updateCustomerId(item.customerId);
                                  vmn.fetchSales();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SalesView(),
                                    ),
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
                                    vertical: 16,
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Container(
                                            alignment: .center,
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              shape: .circle,
                                              color: AppColors.fillColor2,
                                            ),
                                            child: Text(
                                              item.supplierName[0]
                                                  .toUpperCase(),
                                              style: AppTextStyle.labelLarge
                                                  .copyWith(),
                                            ),
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

                                                  // Text(
                                                  //   item.,
                                                  //   style:
                                                  //       AppTextStyle.bodySmall,
                                                  // ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    item.customerPhoneNo
                                                        .toString(),style: AppTextStyle.bodyMediumSecondary,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${item.totalSalesAmount.toString()} Tk",
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
                      Consumer(
                        builder: (context, ref, child) {
                          return ref
                                      .watch(salesViewModelProvider)
                                      .totalPage ==
                                  1
                              ? SizedBox()
                              : CustomerWiseSalesPagination();
                        },
                      ),
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
        onPressed: () {
          navigateWithSlide(context: context, page: SaleAdd());
        },
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100),
        ),
        child: Icon(CupertinoIcons.add, color: AppColors.whiteColor),
      ),
    );
  }
}

class CustomerWiseSalesPagination extends ConsumerStatefulWidget {
  const CustomerWiseSalesPagination({super.key});

  @override
  ConsumerState<CustomerWiseSalesPagination> createState() => _SalesPaginationState();
}

class _SalesPaginationState extends ConsumerState<CustomerWiseSalesPagination> {
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
      final currentPage = ref.read(salesViewModelProvider).currentPage;
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
    final purchaseState = ref.watch(salesViewModelProvider);
    final notifier = ref.read(salesViewModelProvider.notifier);

    final currentPage = purchaseState.currentPage;
    final totalPage = purchaseState.totalPage;

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
