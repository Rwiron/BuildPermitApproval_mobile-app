import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReasonScreen extends StatelessWidget {
  final Map<String, dynamic>
      request; // Assuming this map contains all the necessary request details.

  const ReasonScreen({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description: ${request['description'] ?? 'N/A'}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text('name: ${request['username'] ?? 'N/A'}'),

            SizedBox(height: 20),
            Text('Location: ${request['location'] ?? 'N/A'}'),
            SizedBox(height: 20),

            Text('Province: ${request['province'] ?? 'N/A'}'),
            SizedBox(height: 20),

            Text('District: ${request['district'] ?? 'N/A'}'),
            SizedBox(height: 20),
            Text('Sector: ${request['sector'] ?? 'N/A'}'),

            SizedBox(height: 20),
            Text('Cell: ${request['cell'] ?? 'N/A'}'),
            SizedBox(height: 20),

            Text('Land UPI Number: ${request['land_upi_number'] ?? 'N/A'}'),
            SizedBox(height: 20),

            Text('Status: ${request['status'] ?? 'N/A'}'),
            SizedBox(height: 20),
            // Print button
            Center(
              child: ElevatedButton(
                onPressed: () => _onPrintButtonPressed(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // Button color
                  onPrimary: Colors.white, // Text color
                ),
                child: Text('Print Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPrintButtonPressed(BuildContext context) async {
    final pdf = pw.Document();
    final logoAsset = pw.MemoryImage(
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Date: ${DateTime.now().toString()}',
                  style: pw.TextStyle(fontSize: 18),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Center(child: pw.Image(logoAsset, width: 120, height: 120)),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text(
                  'BPMS',
                  style: pw.TextStyle(
                      fontSize: 35, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text(
                  'Ubusabe Bwanjye',
                  style: pw.TextStyle(
                      fontSize: 25, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Divider(),
              pw.SizedBox(height: 20),
              _buildDetail('Name', request['username']),
              _buildDetail('Land UPI', request['land_upi_number']),
              _buildDetail('Province', request['province']),
              _buildDetail('District', request['district']),
              _buildDetail('Sector', request['sector']),
              _buildDetail('Location', request['location']),
              _buildDetail('Cell', request['cell']),
              _buildDetail('Status', request['status']),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text(
                  'Thank You!!!',
                  style: pw.TextStyle(
                      fontSize: 25, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  'Building Permit Management System V1',
                  style: pw.TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.Widget _buildDetail(String title, String? value) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title,
              style:
                  pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Text(value ?? 'N/A', style: pw.TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
