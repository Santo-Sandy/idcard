import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/id_provider.dart';
import 'student_front.dart';

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
              // TODO: Implement PDF export
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PDF export coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () async {
              // TODO: Implement image export
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Image export coming soon!')),
              );
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
          return StudentFrontCard(student: students[index]);
        },
      ),
    );
  }
}
