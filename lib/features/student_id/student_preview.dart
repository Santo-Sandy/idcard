import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/id_provider.dart';
import '../../exports/pdf_export.dart';
import '../../exports/image_export.dart';
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PDF exported successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Export failed: $e')));
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () async {
              try {
                await ImageExporter.exportAllStudentCards(students, _cardKeys);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Images exported successfully!'),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Export failed: $e')));
              }
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.63,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentFlipCard(
              student: students[index], repaintKey: _cardKeys[index]);
        },
      ),
    );
  }
}
