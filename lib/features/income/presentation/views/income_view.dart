import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/income/presentation/viewmodels/income_viewmodel.dart';
import 'package:pakkahishab/features/income/presentation/views/income_details.dart';
import 'package:pakkahishab/features/income/presentation/widgets/income_appbar_back_with_search.dart';

class IncomeView extends StatelessWidget {
  const IncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IncomeAppbarBackWithSearch(title: "Incomes"),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () {
                return ref
                    .read(incomeViewModelProvider.notifier)
                    .refreshSales();
              },
              child: Consumer(
                builder: (outerContext, ref, child) {
                  final incomeState = ref.watch(incomeViewModelProvider);

                  if (incomeState.loading) {
                    return Center(child: loader);
                  }
                  if (incomeState.incomeList.isEmpty) {
                    return Center(child: Text("No Incomes"));
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
                                      incomeState.incomeList.isEmpty
                                          ? "0"
                                          : ref
                                                .watch(incomeViewModelProvider)
                                                .incomeList
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
                                      incomeState.incomeList.isEmpty
                                          ? "0"
                                          : ref
                                                .watch(incomeViewModelProvider)
                                                .incomeList
                                                .first
                                                .totalIncome
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
                          itemCount: incomeState.incomeList.length,
                          itemBuilder: (context, index) {
                            final item = incomeState.incomeList[index];
                            final parsedDate = DateFormat(
                              "dd/MM/yyyy",
                            ).parse(item.voucherDate);
                            final formattedDate = DateFormat(
                              'dd MMM',
                            ).format(parsedDate);
                            final formattedYear = DateFormat(
                              'yy',
                            ).format(parsedDate);
                            final formattedTime = DateFormat(
                              'hh:mma',
                            ).format(parsedDate);
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
                                      builder: (_) => IncomeDetails(incomeItem: item,),
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
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "$formattedDate $formattedYear",
                                                style: AppTextStyle.bodyMedium
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor2,
                                                      fontSize: 12.sp,
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
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    item.accountName.toString(),
                                                    style:
                                                        AppTextStyle.bodyMedium,
                                                  ),
                                                

                                                
                                                  Text(
                                                    "${item.amount.toString()} Tk",
                                                  ),
                                                ],
                                              ),
                                               Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    item.voucher.toString(),
                                                    style:
                                                        AppTextStyle.bodyMedium,
                                                  ),
                                                

                                                
                                                  Text(
                                                    item.debitCredit,style: AppTextStyle.bodySmall,
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
                      SalesPagination(),
                    ],
                  );
                },
              ),
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

class SalesPagination extends ConsumerStatefulWidget {
  const SalesPagination({super.key});

  @override
  ConsumerState<SalesPagination> createState() => _SalesPaginationState();
}

class _SalesPaginationState extends ConsumerState<SalesPagination> {
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
      final currentPage = ref.read(incomeViewModelProvider).currentPage;
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
    final purchaseState = ref.watch(incomeViewModelProvider);
    final notifier = ref.read(incomeViewModelProvider.notifier);

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
