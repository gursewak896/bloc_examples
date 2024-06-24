import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task2/pdf/pdfView.dart';

class pdfScreen extends StatefulWidget {
  const pdfScreen({Key? key}) : super(key: key);

  @override
  State<pdfScreen> createState() => _pdfScreenState();
}

class _pdfScreenState extends State<pdfScreen> {
  String? _filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pdf screen"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text("Pick a pdf"),
            ),
            if (_filePath != null)
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PDFViewScreen(filePath: _filePath!)));
                      },
                      child: Text("View PDF")),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickPDF() async {
    if (await _requestPermission(Permission.storage)) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

      if (result != null) {
        setState(() {
          _filePath = result.files.single.path;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF selected: ${result.files.single.name}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No file selected')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

 

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }
}
