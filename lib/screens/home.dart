import 'dart:convert';

import 'package:ems_pdf_generater_app/screens/pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PdfServices pdfS = PdfServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Generator")),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
              onPressed: () async {
                final data = await pdfS.generatePdf();
                pdfS.openFilePdf("PDF KHAN", data);
              },
              child: const Text("Generate EMS PDF")),
        ),
      ),
    );
  }
}

