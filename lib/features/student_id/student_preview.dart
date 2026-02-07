import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/id_provider.dart';
import '../../data/models/student.dart';
import '../../exports/pdf_export.dart';
import '../../exports/image_export.dart';
import '../../widgets/export_options_dialog.dart';
import 'student_flip_card.dart';

class StudentPreviewScreen extends ConsumerStatefulWidget {
  const StudentPreviewScreen({super.key});

  @override
  ConsumerState<StudentPreviewScreen> createState() =>
      _StudentPreviewScreenState();
}

class _StudentPreviewScreenState extends ConsumerState<StudentPreviewScreen> {
  late List<GlobalKey> _cardKeys;

  @override
  void initState() {
    super.initState();
    _cardKeys = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final students = ref.watch(idProvider).students;
    if (_cardKeys.length != students.length) {
      _cardKeys = List.generate(students.length, (_) => GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    final idState = ref.watch(idProvider);
    final students = idState.students;

    if (students.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Student ID Preview')),
        body: const Center(
          child: Text(
            'No student data available. Please upload an Excel file first.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student ID Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              try {
                await PdfExporter.exportStudentCards(students);
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
            onPressed: () => _showExportDialog(context, students),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'ID Card Generator',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2024 ID Card Generator Team',
            ),
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
            itemCount: students.length,
            itemBuilder: (context, index) {
              return StudentFlipCard(
                  student: students[index], repaintKey: _cardKeys[index]);
            },
          );
        },
      ),
    );
  }

  void _showExportDialog(BuildContext context, List<Student> students) {
    showDialog(
      context: context,
      builder: (context) => ExportOptionsDialog(
        title: 'Export Student ID Cards',
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
              await PdfExporter.exportStudentCards(students);
            } else {
              await ImageExporter.exportAllStudentCards(students, _cardKeys);
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
