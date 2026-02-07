import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/helper/date_picker_helper.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class PurchaseReportView extends ConsumerStatefulWidget {
  final PurchaseItem purchaseHead;
  const PurchaseReportView({super.key, required this.purchaseHead});

  @override
  ConsumerState<PurchaseReportView> createState() => _PurchaseReportViewState();
}

class _PurchaseReportViewState extends ConsumerState<PurchaseReportView> {
  String? pdfPath;

  @override
  void initState() {
    super.initState();
    // Delay PDF generation until after first frame to ensure ref is available
    WidgetsBinding.instance.addPostFrameCallback((_) => generatePdf());
  }

  Future<void> generatePdf() async {
    final companyName = await SharedPreferencesHelper.getString('company');
    final phone = await SharedPreferencesHelper.getString('phone');
    final email = await SharedPreferencesHelper.getString('email');

    final int nameLength = companyName?.length ?? 1; // avoid division by zero
    final double fontSize = (200 / nameLength) * 4;
    final state = ref.read(purchaseViewModelProvider);
    final items = state.purchaseDetails!.items;

    if (items.isEmpty) {
      // No items, nothing to generate
      return;
    }

    final pdf = pw.Document();

    // Calculate grand total
    final total = items.fold<double>(0, (sum, item) => sum + item.subTotal);

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
                    'Purchase Report',
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
                            "Supplier: ${widget.purchaseHead.supplierName.toString()}",
                            style: pw.TextStyle(fontSize: 18),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            "Bill N0: ${widget.purchaseHead.purchaseNo.toString()}",
                            style: pw.TextStyle(fontSize: 18),
                          ),
                        ],
                      ),

                      pw.Text(
                        'Date: ${formatDate(widget.purchaseHead.purchaseDate)}',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.normal,
                        ),
                        textAlign: pw.TextAlign.end,
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 12),

                  // Table with purchase items
                  pw.TableHelper.fromTextArray(
                    headers: ['Product', 'Quantity', 'Unit Price', 'Total'],
                    data: items
                        .map(
                          (p) => [
                            p.product,
                            p.quantity.toString(),
                            p.unitPrice.toStringAsFixed(2),
                            p.subTotal.toStringAsFixed(2),
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
    final file = File(
      '${dir.path}/purchase_report_${widget.purchaseHead.purchaseNo}.pdf',
    );
    await file.writeAsBytes(await pdf.save());

    setState(() {
      pdfPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(purchaseViewModelProvider);

    if (state.purchaseList.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: CustomAppbarBack(
        title: "Purchase Report",
        actions: [
          Consumer(
            builder: (context, ref, child) => IconButton(
              onPressed: () {
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
