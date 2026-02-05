import 'dart:typed_data';
import 'package:excel/excel.dart';
import '../models/student.dart';
import '../models/teacher.dart';

class ExcelParser {
  static List<Student> parseStudentExcel(Uint8List bytes) {
    var excel = Excel.decodeBytes(bytes);
    var sheet = excel.tables[excel.tables.keys.first]!;
    List<Student> students = [];

    for (var row in sheet.rows.skip(1)) {
      if (row.length < 11) continue;
      students.add(
        Student(
          regNo: row[0]?.value?.toString() ?? '',
          name: row[1]?.value?.toString() ?? '',
          department: row[2]?.value?.toString() ?? '',
          startYear: int.tryParse(row[3]?.value?.toString() ?? '0') ?? 0,
          endYear: int.tryParse(row[4]?.value?.toString() ?? '0') ?? 0,
          bloodGroup: row[5]?.value?.toString() ?? '',
          mobile: row[6]?.value?.toString() ?? '',
          aadhaar: row[7]?.value?.toString() ?? '',
          email: row[8]?.value?.toString() ?? '',
          address: row[9]?.value?.toString() ?? '',
          photo: null, // Handle photo separately
        ),
      );
    }
    return students;
  }

  static List<Teacher> parseTeacherExcel(Uint8List bytes) {
    var excel = Excel.decodeBytes(bytes);
    var sheet = excel.tables[excel.tables.keys.first]!;
    List<Teacher> teachers = [];

    for (var row in sheet.rows.skip(1)) {
      if (row.length < 9) continue;
      teachers.add(
        Teacher(
          staffId: row[0]?.value?.toString() ?? '',
          name: row[1]?.value?.toString() ?? '',
          department: row[2]?.value?.toString() ?? '',
          designation: row[3]?.value?.toString() ?? '',
          bloodGroup: row[4]?.value?.toString() ?? '',
          mobile: row[5]?.value?.toString() ?? '',
          email: row[6]?.value?.toString() ?? '',
          address: row[7]?.value?.toString() ?? '',
          photo: null, // Handle photo separately
        ),
      );
    }
    return teachers;
  }
}
