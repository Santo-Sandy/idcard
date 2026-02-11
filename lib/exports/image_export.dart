import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../data/models/student.dart';
import '../data/models/teacher.dart';

class ImageExporter {
  static String _joinPath(String a, String b) {
    final sep = Platform.pathSeparator;
    if (a.endsWith(sep)) return '$a$b';
    return '$a$sep$b';
  }

  static Future<Directory> _resolveExportDirectory() async {
    Directory? base;

    if (Platform.isAndroid) {
      // Best-effort: "Downloads" (may be app-scoped depending on Android version).
      final dirs =
          await getExternalStorageDirectories(type: StorageDirectory.downloads);
      if (dirs != null && dirs.isNotEmpty) {
        base = dirs.first;
      } else {
        base = await getExternalStorageDirectory();
      }
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      base = await getDownloadsDirectory();
    }

    base ??= await getApplicationDocumentsDirectory();

    final exportDir = Directory(_joinPath(base.path, 'IDCards'));
    if (!await exportDir.exists()) {
      await exportDir.create(recursive: true);
    }
    return exportDir;
  }

  static Future<Uint8List> _captureToPngBytes(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) {
      throw Exception('Card is not rendered yet. Scroll until it is visible.');
    }

    final renderObject = ctx.findRenderObject();
    if (renderObject is! RenderRepaintBoundary) {
      throw Exception('Export failed: target is not a RepaintBoundary.');
    }

    final ui.Image image = await renderObject.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List() ?? Uint8List(0);
  }

  static Future<String> exportStudentCardAsImage(
    Student student,
    GlobalKey key,
    {bool shareAfterExport = true}
  ) async {
    try {
      final pngBytes = await _captureToPngBytes(key);
      final exportDir = await _resolveExportDirectory();
      final fileName = 'student_${student.regNo}.png';
      final file = File(_joinPath(exportDir.path, fileName));
      await file.writeAsBytes(pngBytes, flush: true);

      if (shareAfterExport) {
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Student ID Card - ${student.name}',
        );
      }

      return file.path;
    } catch (e) {
      throw Exception('Failed to export image: $e');
    }
  }

  static Future<String> exportTeacherCardAsImage(
    Teacher teacher,
    GlobalKey key,
    {bool shareAfterExport = true}
  ) async {
    try {
      final pngBytes = await _captureToPngBytes(key);
      final exportDir = await _resolveExportDirectory();
      final fileName = 'teacher_${teacher.staffId}.png';
      final file = File(_joinPath(exportDir.path, fileName));
      await file.writeAsBytes(pngBytes, flush: true);

      if (shareAfterExport) {
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Teacher ID Card - ${teacher.name}',
        );
      }

      return file.path;
    } catch (e) {
      throw Exception('Failed to export image: $e');
    }
  }

  static Future<void> exportAllStudentCards(
    List<Student> students,
    List<GlobalKey> keys,
    {bool shareAfterExport = false}
  ) async {
    for (int i = 0; i < students.length; i++) {
      if (i < keys.length) {
        await exportStudentCardAsImage(
          students[i],
          keys[i],
          shareAfterExport: shareAfterExport,
        );
      }
    }
  }

  static Future<void> exportAllTeacherCards(
    List<Teacher> teachers,
    List<GlobalKey> keys,
    {bool shareAfterExport = false}
  ) async {
    for (int i = 0; i < teachers.length; i++) {
      if (i < keys.length) {
        await exportTeacherCardAsImage(
          teachers[i],
          keys[i],
          shareAfterExport: shareAfterExport,
        );
      }
    }
  }
}
