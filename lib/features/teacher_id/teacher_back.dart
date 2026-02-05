import 'package:flutter/material.dart';
import '../../data/models/teacher.dart';

class TeacherBackCard extends StatelessWidget {
  final Teacher teacher;

  const TeacherBackCard({super.key, required this.teacher});

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
            const Divider(),

            // Teacher Details
            _buildDetailRow('Blood Group', teacher.bloodGroup),
            _buildDetailRow('Mobile No', teacher.mobile),
            _buildDetailRow('Email ID', teacher.email),

            const SizedBox(height: 8),
            const Text(
              'Address:',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            Text(teacher.address, style: const TextStyle(fontSize: 10)),

            const Spacer(),

            // Footer
            const Center(
              child: Text(
                'Emergency Contact',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 10))),
        ],
      ),
    );
  }
}
