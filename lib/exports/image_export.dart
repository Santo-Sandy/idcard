import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import '../data/models/student.dart';
import '../data/models/teacher.dart';

class ImageExporter {
  static Future<String> exportStudentCardAsImage(
    Student student,
    GlobalKey key,
  ) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final dir = await getApplicationDocumentsDirectory();
      final fileName = 'student_${student.regNo}.png';
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(pngBytes);
      return file.path;
    } catch (e) {
      throw Exception('Failed to export image: $e');
    }
  }

  static Future<String> exportTeacherCardAsImage(
    Teacher teacher,
    GlobalKey key,
  ) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final dir = await getApplicationDocumentsDirectory();
      final fileName = 'teacher_${teacher.staffId}.png';
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(pngBytes);
      return file.path;
    } catch (e) {
      throw Exception('Failed to export image: $e');
    }
  }

  static Future<List<String>> exportAllStudentCards(
    List<Student> students,
    List<GlobalKey> keys,
  ) async {
    List<String> paths = [];
    for (int i = 0; i < students.length; i++) {
      if (i < keys.length) {
        final path = await exportStudentCardAsImage(students[i], keys[i]);
        paths.add(path);
      }
    }
    return paths;
  }

  static Future<List<String>> exportAllTeacherCards(
    List<Teacher> teachers,
    List<GlobalKey> keys,
  ) async {
    List<String> paths = [];
    for (int i = 0; i < teachers.length; i++) {
      if (i < keys.length) {
        final path = await exportTeacherCardAsImage(teachers[i], keys[i]);
        paths.add(path);
      }
    }
    return paths;
  }
}
