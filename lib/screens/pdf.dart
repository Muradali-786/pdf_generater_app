import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfServices {
  Future<Uint8List> generatePdf() {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return _builtUI(context);
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _builtUI(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _logoAndCompanyName(context, 'AcMobileNo', 'AcAddress'),
          pw.SizedBox(height: 20.0),
          _saleInvoiceAndPrint(context, 'SPDate'),
          pw.SizedBox(height: 20.0),
          _accountCashAndRemark(context, 'AccountName', 'Remarks'),
          pw.SizedBox(height: 20.0),
          _itemAndTotal(context),
          pw.SizedBox(height: 20.0),
          _itemTable(context, 2, 'subData'),
          pw.SizedBox(height: 20.0),
          _total(context, '2560'),
          pw.SizedBox(height: 10.0),
          pw.Text(
            'Terms And Condition',
            style: pw.TextStyle(fontSize: 19, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10.0),
          _termAndConditionDescription(
              context, '1', 'Shop policies: please read'),
          _termAndConditionDescription(
              context, '2', 'Customer satisfaction is our priority.'),
          _termAndConditionDescription(
              context, '3', 'Easy exchanges, no hassles'),
          pw.SizedBox(height: 20.0),
          _easySoftStamp(context),
        ],
      ),
    );
  }

  pw.Widget _logoAndCompanyName(
      pw.Context context, String phNo, String address) {
    return pw.Container(
      width: double.infinity,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Row(
        children: [
          pw.SizedBox(width: 10),
          pw.Row(
            children: [
              pw.Text(
                'Logo',
                style: const pw.TextStyle(fontSize: 17),
              ),
            ],
          ),
          pw.SizedBox(width: 30),
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Company Name',
                style:
                    pw.TextStyle(fontSize: 21, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(address),
              pw.Text(phNo),
            ],
          )
        ],
      ),
    );
  }

  pw.Widget _saleInvoiceAndPrint(pw.Context context, String date) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Align(
          alignment: pw.Alignment.center,
          child: pw.Text(
            'Sales Invoice',
            style: const pw.TextStyle(fontSize: 20),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            "Print Date : $date",
            style: const pw.TextStyle(fontSize: 20, color: PdfColors.grey),
          ),
        )
      ],
    );
  }

  pw.Widget _accountCashAndRemark(
      pw.Context context, String cash, String remarks) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Account:$cash',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 5),
        pw.Text('Remarks: $remarks',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  pw.Widget _itemAndTotal(pw.Context context) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 2),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Items',
            style: pw.TextStyle(fontSize: 19, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'Total',
            style: pw.TextStyle(fontSize: 19, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );
  }

  pw.Widget _itemTable(pw.Context context, int length, String data) {
    return pw.ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black, width: 1),
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(1),
          },
          children: [
            pw.TableRow(
              verticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(
                      8.0),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'First line of text',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        'Second line of text',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    '1500',
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  pw.Widget _total(pw.Context context, String billTotal) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.fromLTRB(8, 6, 8, 6),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: PdfColors.black,
          width: 2,
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Total',
            style: pw.TextStyle(fontSize: 19, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            '579',
            style: pw.TextStyle(fontSize: 19, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );
  }

  pw.Widget _termAndConditionDescription(
      pw.Context context, String no, String text) {
    return pw.Row(
      children: [
        pw.Text(
          '$no.',
          style: const pw.TextStyle(color: PdfColors.grey),
        ),
        pw.SizedBox(width: 10),
        pw.Text(
          text,
          style: const pw.TextStyle(color: PdfColors.grey),
        ),
      ],
    );
  }

  pw.Widget _easySoftStamp(pw.Context context) {
    return pw.Container(
      height: 40,
      width: double.infinity,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(
            color: PdfColors.black,
            width: 1,
          ),
          bottom: pw.BorderSide(
            color: PdfColors.black,
            width: 1,
          ),
        ),
      ),
      child: pw.Center(
        child: pw.Text(
          'Printed By EasySoft',
          style: const pw.TextStyle(fontSize: 18, color: PdfColors.grey),
        ),
      ),
    );
  }

  Future<void> openFilePdf(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";

    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}


