// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:pdfx/pdfx.dart';
// // ignore: depend_on_referenced_packages
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

// import '../const/app_colors.dart';


// class HomePdfView extends StatefulWidget {
//   final String pdfUrl;

//   const HomePdfView({super.key, required this.pdfUrl});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomePdfViewState createState() => _HomePdfViewState();
// }

// class _HomePdfViewState extends State<HomePdfView> {
//   PdfControllerPinch? _pdfController;
//   // ignore: unused_field
//   String? _localPath;

//   @override
//   void initState() {
//     super.initState();
//     _loadPdf();
//   }

//   Future<void> _loadPdf() async {
//   try {
//     if (widget.pdfUrl.startsWith('http')) {
//       // URL-based PDF
//       String fileName = widget.pdfUrl.split('/').last;
//       Directory dir = await getApplicationDocumentsDirectory();
//       File file = File("${dir.path}/$fileName");

//       if (!file.existsSync()) {
//         final response = await http.get(Uri.parse(widget.pdfUrl));
//         if (response.statusCode == 200) {
//           await file.writeAsBytes(response.bodyBytes);
//         } else {
//           throw Exception("Failed to download PDF");
//         }
//       }

//       setState(() {
//         _localPath = file.path;
//         _pdfController = PdfControllerPinch(
//           document: PdfDocument.openFile(file.path),
//         );
//       });
//     } else {
//       // Asset-based PDF
//       setState(() {
//         _pdfController = PdfControllerPinch(
//           document: PdfDocument.openAsset(widget.pdfUrl),
//         );
//       });
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       print("Error loading PDF: $e");
//     }
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     if (_pdfController == null) {
//       return Center(
//         child: CircularProgressIndicator(color: AppColors.primaryColor),
//       );
//     }

//     return PdfView(
//       // maxScale: 2.5,
//       // minScale: 1,
     
//       controller: _pdfController!);
//   }
// }