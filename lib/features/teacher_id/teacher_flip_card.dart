import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../../data/models/teacher.dart';

class TeacherFlipCard extends StatelessWidget {
  final Teacher teacher;

  const TeacherFlipCard({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: _buildFrontCard(context),
      back: _buildBackCard(context),
    );
  }

  Widget _buildFrontCard(BuildContext context) {
    return Card(
      elevation: 12,
      shadowColor: Colors.teal.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade50, Colors.white],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'GOVERNMENT ARTS & SCIENCE COLLEGE',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '(Affiliated to XYZ University)',
                    style: TextStyle(fontSize: 9, color: Colors.teal.shade700),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'College Address Line',
                    style: TextStyle(fontSize: 9, color: Colors.teal.shade600),
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
                    border: Border.all(color: Colors.teal.shade300, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: teacher.photo != null
                        ? Image.memory(teacher.photo!, fit: BoxFit.cover)
                        : Container(
                            color: Colors.teal.shade50,
                            child: Icon(
                              Icons.person,
                              size: 48,
                              color: Colors.teal.shade300,
                            ),
                          ),
                  ),
                ),

                const SizedBox(width: 16),

                // Teacher Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Name', teacher.name),
                      _buildDetailRow('Designation', teacher.designation),
                      _buildDetailRow('Department', teacher.department),
                      _buildDetailRow('Staff ID', teacher.staffId),
                      _buildDetailRow('Blood Group', teacher.bloodGroup),
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
                        color: Colors.teal.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.teal.shade50,
                    child: Center(
                      child: Text(
                        'QR\nCode',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.teal.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                // Principal Signature
                Column(
                  children: [
                    Text(
                      'PRINCIPAL',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'Signature',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.teal.shade400,
                          ),
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
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.teal.shade600,
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

  Widget _buildBackCard(BuildContext context) {
    return Card(
      elevation: 12,
      shadowColor: Colors.teal.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade100, Colors.white],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Text(
                'TEACHER ID CARD',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Contact Information
            Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 12),
            _buildBackDetailRow('Mobile', teacher.mobile),
            _buildBackDetailRow('Email', teacher.email),

            const SizedBox(height: 20),

            // Address
            Text(
              'Address',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Text(
                teacher.address,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.teal.shade800,
                  height: 1.4,
                ),
              ),
            ),

            const Spacer(),

            // Emergency Contact Note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency Contact',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'In case of emergency, please contact the college office or use the information provided above.',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.teal.shade600,
                      height: 1.3,
                    ),
                  ),
                ],
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
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 11, color: Colors.teal.shade900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12, color: Colors.teal.shade900),
            ),
          ),
        ],
      ),
    );
  }
}
