import 'package:flutter/material.dart';
import '../../data/models/teacher.dart';

class TeacherFrontCard extends StatelessWidget {
  final Teacher teacher;

  const TeacherFrontCard({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'GOVERNMENT ARTS & SCIENCE COLLEGE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              '(Affiliated to XYZ University)',
              style: TextStyle(fontSize: 8, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Text(
              'College Address Line',
              style: TextStyle(fontSize: 8, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Divider(),

            // Photo
            Center(
              child: Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: teacher.photo != null
                    ? Image.memory(teacher.photo!, fit: BoxFit.cover)
                    : const Icon(Icons.person, size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),

            // Teacher Details
            _buildDetailRow('Name', teacher.name),
            _buildDetailRow('Designation', teacher.designation),
            _buildDetailRow('Department', teacher.department),
            _buildDetailRow('Staff ID', teacher.staffId),

            const Spacer(),

            // Footer
            const Center(
              child: Text(
                'PRINCIPAL',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(fontSize: 10))),
        ],
      ),
    );
  }
}
