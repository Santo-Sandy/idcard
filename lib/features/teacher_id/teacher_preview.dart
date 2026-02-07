import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/id_provider.dart';
import '../../data/models/teacher.dart';
import '../../exports/pdf_export.dart';
import '../../exports/image_export.dart';
import '../../widgets/export_options_dialog.dart';
import 'teacher_flip_card.dart';

class TeacherPreviewScreen extends ConsumerStatefulWidget {
  const TeacherPreviewScreen({super.key});

  @override
  ConsumerState<TeacherPreviewScreen> createState() =>
      _TeacherPreviewScreenState();
}

class _TeacherPreviewScreenState extends ConsumerState<TeacherPreviewScreen> {
  late List<GlobalKey> _cardKeys;

  @override
  void initState() {
    super.initState();
    _cardKeys = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final teachers = ref.watch(idProvider).teachers;
    if (_cardKeys.length != teachers.length) {
      _cardKeys = List.generate(teachers.length, (_) => GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    final idState = ref.watch(idProvider);
    final teachers = idState.teachers;

    if (teachers.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Teacher ID Preview')),
        body: const Center(
          child: Text(
            'No teacher data available. Please upload an Excel file first.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher ID Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              try {
                await PdfExporter.exportTeacherCards(teachers);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PDF exported successfully!')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Export failed: $e')),
                  );
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () => _showExportDialog(context, teachers),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1.6, // Standard ID card aspect ratio
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              return TeacherFlipCard(
                  teacher: teachers[index], repaintKey: _cardKeys[index]);
            },
          );
        },
      ),
    );
  }

  void _showExportDialog(BuildContext context, List<Teacher> teachers) {
    showDialog(
      context: context,
      builder: (context) => ExportOptionsDialog(
        title: 'Export Teacher ID Cards',
        onExport: (format, quality, shareAfterExport) async {
          // Show progress indicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Exporting...'),
                ],
              ),
            ),
          );

          try {
            if (format == 'PDF') {
              await PdfExporter.exportTeacherCards(teachers);
            } else {
              await ImageExporter.exportAllTeacherCards(teachers, _cardKeys);
            }
            if (mounted) {
              Navigator.pop(context); // Close progress dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$format exported successfully!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          } catch (e) {
            if (mounted) {
              Navigator.pop(context); // Close progress dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Export failed: $e'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
