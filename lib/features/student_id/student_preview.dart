import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/id_provider.dart';
import '../../exports/pdf_export.dart';
import '../../exports/image_export.dart';
import 'student_flip_card.dart';

class StudentPreviewScreen extends ConsumerWidget {
  const StudentPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                await ImageExporter.exportAllStudentCards(students, []);
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
          return StudentFlipCard(student: students[index]);
        },
      ),
    );
  }
}
