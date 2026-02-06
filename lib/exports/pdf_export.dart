import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../data/models/student.dart';
import '../data/models/teacher.dart';

class PdfExporter {
  static Future<String> exportStudentCards(List<Student> students) async {
    final pdf = pw.Document();

    for (var student in students) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColors.white,
                border: pw.Border.all(color: PdfColors.grey, width: 2),
                borderRadius: pw.BorderRadius.circular(12),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Header
                  pw.Container(
                    padding: const pw.EdgeInsets.all(12),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.blue50,
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Column(
                      children: [
                        pw.Text(
                          'GOVERNMENT ARTS & SCIENCE COLLEGE',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue900,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          '(Affiliated to XYZ University)',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.blue700,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          'College Address Line',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.blue,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  pw.SizedBox(height: 16),

                  // Photo and Details Row
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Photo placeholder
                      pw.Container(
                        width: 90,
                        height: 110,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.grey,
                            width: 2,
                          ),
                          borderRadius: pw.BorderRadius.circular(8),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            'Photo',
                            style: pw.TextStyle(color: PdfColors.grey),
                          ),
                        ),
                      ),

                      pw.SizedBox(width: 16),

                      // Student Details
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            _buildPdfDetailRow('Name', student.name),
                            _buildPdfDetailRow('Reg No', student.regNo),
                            _buildPdfDetailRow(
                              'Batch',
                              '${student.startYear} - ${student.endYear}',
                            ),
                            _buildPdfDetailRow(
                              'Department',
                              student.department,
                            ),
                            _buildPdfDetailRow(
                              'Blood Group',
                              student.bloodGroup,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 16),

                  // QR Code and Signature
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      // QR Code placeholder
                      pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          borderRadius: pw.BorderRadius.circular(8),
                          border: pw.Border.all(color: PdfColors.grey),
                        ),
                        child: pw.Container(
                          width: 60,
                          height: 60,
                          child: pw.Center(
                            child: pw.Text(
                              'QR\nCode',
                              style: pw.TextStyle(
                                fontSize: 8,
                                color: PdfColors.black,
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      // Principal Signature
                      pw.Column(
                        children: [
                          pw.Text(
                            'PRINCIPAL',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue,
                            ),
                          ),
                          pw.Container(
                            width: 80,
                            height: 30,
                            margin: const pw.EdgeInsets.only(top: 4),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.grey),
                              borderRadius: pw.BorderRadius.circular(4),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                'Signature',
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  color: PdfColors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 8),

                  // Footer
                  pw.Center(
                    child: pw.Text(
                      '*If found please return to College Office*',
                      style: pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.grey,
                        fontStyle: pw.FontStyle.italic,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    final dir = await getApplicationDocumentsDirectory();
    final fileName = 'student_id_cards.pdf';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  static Future<String> exportTeacherCards(List<Teacher> teachers) async {
    final pdf = pw.Document();

    for (var teacher in teachers) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              padding: const pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Header
                  pw.Text(
                    'GOVERNMENT ARTS & SCIENCE COLLEGE',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                  pw.Text(
                    '(Affiliated to XYZ University)',
                    style: pw.TextStyle(fontSize: 8, color: PdfColors.grey),
                    textAlign: pw.TextAlign.center,
                  ),
                  pw.Text(
                    'College Address Line',
                    style: pw.TextStyle(fontSize: 8, color: PdfColors.grey),
                    textAlign: pw.TextAlign.center,
                  ),
                  pw.Divider(),

                  // Photo
                  pw.Center(
                    child: pw.Container(
                      width: 80,
                      height: 100,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.grey),
                        borderRadius: pw.BorderRadius.circular(8),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          'Photo',
                          style: pw.TextStyle(color: PdfColors.grey),
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 8),

                  // Teacher Details
                  _buildPdfDetailRow('Name', teacher.name),
                  _buildPdfDetailRow('Designation', teacher.designation),
                  _buildPdfDetailRow('Department', teacher.department),
                  _buildPdfDetailRow('Staff ID', teacher.staffId),

                  pw.Spacer(),

                  // Footer
                  pw.Center(
                    child: pw.Text(
                      'PRINCIPAL',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    final dir = await getApplicationDocumentsDirectory();
    final fileName = 'teacher_id_cards.pdf';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  static pw.Widget _buildPdfDetailRow(String label, String value) {
    return pw.Container(
      margin: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 80,
            child: pw.Text(
              '$label:',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: pw.TextStyle(fontSize: 10, color: PdfColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
