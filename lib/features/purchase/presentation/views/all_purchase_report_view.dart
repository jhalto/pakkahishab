import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/helper/date_picker_helper.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_supplier_wise_viewmodel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class AllPurchaseReportView extends ConsumerStatefulWidget {
  const AllPurchaseReportView({super.key});

  @override
  ConsumerState<AllPurchaseReportView> createState() =>
      _PurchaseReportViewState();
}

class _PurchaseReportViewState extends ConsumerState<AllPurchaseReportView> {
  String? pdfPath;

  @override
  void initState() {
    super.initState();
    // Delay PDF generation until after first frame to ensure ref is available
    // WidgetsBinding.instance.addPostFrameCallback((_) => generatePdf());
  }

  Future<void> generatePdf() async {
    final companyName = await SharedPreferencesHelper.getString('company');
    final phone = await SharedPreferencesHelper.getString('phone');
    final email = await SharedPreferencesHelper.getString('email');

    final int nameLength = companyName?.length ?? 1; // avoid division by zero
    final double fontSize = (200 / nameLength) * 4;
    final state = ref.watch(purchaseSupplierWiseViewModel);

    final items = state.supplierPurchaseList;

    if (items.isEmpty) {
      // No items, nothing to generate
      return;
    }

    final pdf = pw.Document();

    // Calculate grand total
    final total = items.fold<double>(
      0,
      (sum, item) => sum + item.totalPurchaseAmount,
    );

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4, // ✅ moved here
          buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Container(
              color: PdfColors.white, // outside/background color
            ),
          ),
        ),
        build: (context) {
          return pw.Stack(
            children: [
              pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: .spaceBetween,
                    crossAxisAlignment: .start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: .start,
                        children: [
                          pw.Text(
                            companyName.toString(),
                            style: pw.TextStyle(
                              fontSize: 24,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            phone.toString(),
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                          pw.Text(
                            email.toString(),
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      pw.Text(
                        "Print Date : ${formatDate(DateTime.now())}",
                        style: pw.TextStyle(
                          color: PdfColors.grey800,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'All Purchase Report',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    mainAxisAlignment: .spaceBetween,
                    crossAxisAlignment: .end,
                    children: [
                      pw.Column(
                        crossAxisAlignment: .start,

                        children: [
                          pw.Text(
                            "Supplier: ",
                            style: pw.TextStyle(fontSize: 18),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            "Supplier No: ",
                            style: pw.TextStyle(fontSize: 18),
                          ),
                        ],
                      ),

                      // pw.Text(
                      //   'Date: ',
                      //   style: pw.TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: pw.FontWeight.normal,
                      //   ),
                      //   textAlign: pw.TextAlign.end,
                      // ),
                    ],
                  ),
                  pw.SizedBox(height: 12),

                  // Table with purchase items
                  pw.TableHelper.fromTextArray(
                    headers: ['Supplier Id', 'Name', 'Net Amount'],
                    data: items
                        .map(
                          (p) => [
                            p.supplierId,
                            p.supplierName,
                            // formatApiDate(p.purchaseDate.toString()),
                            p.totalPurchaseAmount,
                            // p.purchaseNo,
                          ],
                        )
                        .toList(),
                    headerStyle: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                    ),
                    cellAlignment: pw.Alignment.center,
                    border: pw.TableBorder.all(width: 0.5),
                    cellStyle: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),

                  pw.SizedBox(height: 12),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Grand Total: ${total.toStringAsFixed(2)}',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Center(
                child: pw.Transform.rotate(
                  angle: 1, // slight rotation in radians
                  child: pw.Opacity(
                    opacity: 0.1, // light watermark
                    child: pw.Text(
                      companyName.toString(),
                      style: pw.TextStyle(
                        fontSize: fontSize, // big watermark
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/purchase_report.pdf');
    await file.writeAsBytes(await pdf.save());

    setState(() {
      pdfPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(purchaseSupplierWiseViewModel);

    // 🔥 Generate only once after data loads
    if (state.supplierPurchaseList.isNotEmpty && pdfPath == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        generatePdf();
      });
    }
    return Scaffold(
      appBar: CustomAppbarBack(
        title: "Purchase Report",
        actions: [
          Consumer(
            builder: (context, ref, child) => IconButton(
              onPressed: pdfPath == null
                  ? null
                  : () {
                      ref
                          .read(purchaseViewModelProvider.notifier)
                          .downloadFile(context, pdfPath!);
                    },
              icon: Icon(Icons.download, color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
      body: pdfPath == null
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : SfPdfViewerTheme(
              data: SfPdfViewerThemeData(backgroundColor: Colors.black),
              child: SfPdfViewer.file(File(pdfPath!)),
            ),
    );
  }
}
