import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../data/models/student.dart';
import '../data/models/teacher.dart';

class PdfExporter {
  static const double _cardWidth = 85.60;
  static const double _cardHeight = 53.98;

  // ==============================
  // STUDENT EXPORT
  // ==============================

  static Future<String> exportStudentCards(List<Student> students) async {
    final pdf = pw.Document();

    final fonts = await _loadFonts();
    final logo = await _loadLogo();

    for (final student in students) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat(
            _cardWidth * PdfPageFormat.mm,
            _cardHeight * PdfPageFormat.mm,
          ),
          margin: pw.EdgeInsets.zero,
          build: (_) => _buildStudentCard(student, fonts, logo),
        ),
      );
    }

    return _saveFile(pdf, "student_id_cards.pdf");
  }

  // ==============================
  // TEACHER EXPORT
  // ==============================

  static Future<String> exportTeacherCards(List<Teacher> teachers) async {
    final pdf = pw.Document();

    final fonts = await _loadFonts();
    final logo = await _loadLogo();

    for (final teacher in teachers) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat(
            _cardWidth * PdfPageFormat.mm,
            _cardHeight * PdfPageFormat.mm,
          ),
          margin: pw.EdgeInsets.zero,
          build: (_) => _buildTeacherCard(teacher, fonts, logo),
        ),
      );
    }

    return _saveFile(pdf, "teacher_id_cards.pdf");
  }

  // ==============================
  // STUDENT CARD DESIGN
  // ==============================

  static pw.Widget _buildStudentCard(
    Student student,
    _FontBundle fonts,
    pw.MemoryImage logo,
  ) {
    final photo = student.photo != null ? pw.MemoryImage(student.photo!) : null;

    return pw.Container(
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border.all(color: PdfColors.blue900, width: 1.2),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // HEADER
          pw.Container(
            height: 18,
            padding: const pw.EdgeInsets.symmetric(horizontal: 6),
            decoration: const pw.BoxDecoration(
              color: PdfColors.blue900,
              borderRadius: pw.BorderRadius.vertical(
                top: pw.Radius.circular(4),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Image(logo, width: 14),
                pw.SizedBox(width: 4),
                pw.Text(
                  "GOVERNMENT ARTS & SCIENCE COLLEGE",
                  style: pw.TextStyle(
                    font: fonts.bold,
                    fontSize: 6,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 4),

          // BODY
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 32,
                height: 40,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey),
                ),
                child: photo != null
                    ? pw.Image(photo, fit: pw.BoxFit.cover)
                    : pw.Center(
                        child: pw.Text(
                          "Photo",
                          style: pw.TextStyle(fontSize: 6),
                        ),
                      ),
              ),
              pw.SizedBox(width: 6),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _detailRow("Name", student.name, fonts),
                    _detailRow("Reg No", student.regNo, fonts),
                    _detailRow("Batch",
                        "${student.startYear}-${student.endYear}", fonts),
                    _detailRow("Dept", student.department, fonts),
                    _detailRow("Blood", student.bloodGroup, fonts),
                  ],
                ),
              ),
            ],
          ),

          pw.Spacer(),

          // FOOTER
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.BarcodeWidget(
                barcode: pw.Barcode.qrCode(),
                data: student.regNo,
                width: 28,
                height: 28,
              ),
              pw.Column(
                children: [
                  pw.Text(
                    "PRINCIPAL",
                    style: pw.TextStyle(
                      font: fonts.bold,
                      fontSize: 6,
                      color: PdfColors.blue900,
                    ),
                  ),
                  pw.Container(
                    width: 40,
                    height: 10,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==============================
  // TEACHER CARD DESIGN
  // ==============================

  static pw.Widget _buildTeacherCard(
    Teacher teacher,
    _FontBundle fonts,
    pw.MemoryImage logo,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border.all(color: PdfColors.blue900, width: 1.2),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            height: 18,
            padding: const pw.EdgeInsets.symmetric(horizontal: 6),
            decoration: const pw.BoxDecoration(
              color: PdfColors.blue900,
            ),
            child: pw.Row(
              children: [
                pw.Image(logo, width: 14),
                pw.SizedBox(width: 4),
                pw.Text(
                  "GOVERNMENT ARTS & SCIENCE COLLEGE",
                  style: pw.TextStyle(
                    font: fonts.bold,
                    fontSize: 6,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 6),
          _detailRow("Name", teacher.name, fonts),
          _detailRow("Designation", teacher.designation, fonts),
          _detailRow("Department", teacher.department, fonts),
          _detailRow("Staff ID", teacher.staffId, fonts),
        ],
      ),
    );
  }

  // ==============================
  // DETAIL ROW
  // ==============================

  static pw.Widget _detailRow(String label, String value, _FontBundle fonts) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 30,
            child: pw.Text(
              "$label:",
              style: pw.TextStyle(
                font: fonts.bold,
                fontSize: 6,
                color: PdfColors.blue900,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              maxLines: 1,
              style: pw.TextStyle(
                font: fonts.regular,
                fontSize: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // UTILITIES
  // ==============================

  static Future<_FontBundle> _loadFonts() async {
    final regular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final bold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");

    return _FontBundle(
      regular: pw.Font.ttf(regular),
      bold: pw.Font.ttf(bold),
    );
  }

  static Future<pw.MemoryImage> _loadLogo() async {
    final data = await rootBundle.load("assets/logo.png");
    return pw.MemoryImage(data.buffer.asUint8List());
  }

  static Future<String> _saveFile(pw.Document pdf, String name) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$name");
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }
}

class _FontBundle {
  final pw.Font regular;
  final pw.Font bold;

  _FontBundle({
    required this.regular,
    required this.bold,
  });
}
