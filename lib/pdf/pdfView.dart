import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class PDFViewScreen extends StatefulWidget {
  const PDFViewScreen({Key? key, required this.filePath}) : super(key: key);

  final String filePath;

  @override
  State<PDFViewScreen> createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  // Future<void> _savePDF(BuildContext context) async {

  //  Future<void> _savePDF(BuildContext context) async {
  //   if (await _requestPermission(Permission.storage)) {
  //     String downloadsDirPath = "/storage/emulated/0/Download"; // Use the hardcoded path to the Downloads folder
  //     String fileName = filePath.split('/').last;
  //     String newFilePath = '$downloadsDirPath/$fileName';

  //     File selectedFile = File(filePath);

  //     await selectedFile.copy(newFilePath);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('PDF saved to $newFilePath')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Storage permission denied')),
  //     );
  //   }
  // }


  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  double _downloadProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF View Page"),
      ),
      body: Stack(children: [
        PDFView(
          filePath: widget.filePath,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
        ),
        if (_downloadProgress > 0 && _downloadProgress < 1)
          Center(
            child: CircularProgressIndicator(
              value: _downloadProgress,
            ),
          ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}
        // _savePDF(context),
        // child: Icon(Icons.download),
      ),
    );
  }
}
