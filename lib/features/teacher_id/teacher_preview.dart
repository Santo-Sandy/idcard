import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/id_provider.dart';
import '../../exports/pdf_export.dart';
import '../../exports/image_export.dart';
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
                await ImageExporter.exportAllTeacherCards(teachers, _cardKeys);
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
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          return TeacherFlipCard(
              teacher: teachers[index], repaintKey: _cardKeys[index]);
        },
      ),
    );
  }
}
