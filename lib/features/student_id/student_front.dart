import 'package:flutter/material.dart';
import '../../data/models/student.dart';

class StudentFrontCard extends StatelessWidget {
  final Student student;

  const StudentFrontCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'GOVERNMENT ARTS & SCIENCE COLLEGE',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '(Affiliated to XYZ University)',
                    style: TextStyle(fontSize: 9, color: Colors.blue[700]),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'College Address Line',
                    style: const TextStyle(fontSize: 9, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Photo and Details Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo
                Container(
                  width: 90,
                  height: 110,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: student.photo != null
                        ? Image.memory(student.photo!, fit: BoxFit.cover)
                        : Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.person,
                              size: 48,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ),

                const SizedBox(width: 16),

                // Student Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Name', student.name),
                      _buildDetailRow('Reg No', student.regNo),
                      _buildDetailRow(
                        'Batch',
                        '${student.startYear} - ${student.endYear}',
                      ),
                      _buildDetailRow('Department', student.department),
                      _buildDetailRow('Blood Group', student.bloodGroup),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // QR Code Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // QR Code
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text(
                        'QR\nCode',
                        style: TextStyle(fontSize: 8, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                // Principal Signature
                Column(
                  children: [
                    const Text(
                      'PRINCIPAL',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'Signature',
                          style: TextStyle(fontSize: 8, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Footer Text
            Center(
              child: Text(
                '*If found please return to College Office*',
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
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
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 11, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
