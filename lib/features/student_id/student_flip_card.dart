import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../../data/models/student.dart';
import '../../core/models/card_template.dart';

class StudentFlipCard extends StatelessWidget {
  final Student student;
  final GlobalKey? repaintKey;
  final CardTemplate template;

  const StudentFlipCard({
    super.key,
    required this.student,
    this.repaintKey,
    this.template = CardTemplate.classic,
  });

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
      elevation: 8,
      shadowColor: template.primaryColor.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              template.primaryColor.withValues(alpha: 0.05),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header: Logo and College Name side by side
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: template.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo placeholder
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: template.primaryColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.school,
                      color: template.primaryColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // College Name
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GOVERNMENT ARTS & SCIENCE COLLEGE',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: template.primaryColor,
                          ),
                        ),
                        Text(
                          '(Affiliated to XYZ University)',
                          style: TextStyle(
                            fontSize: 6,
                            color: template.primaryColor.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // College Address
            Text(
              'College Address Line 1, City, State - PIN',
              style: TextStyle(
                fontSize: 6,
                color: template.primaryColor.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Center Photo
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                    color: template.primaryColor.withValues(alpha: 0.5),
                    width: 2),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: template.primaryColor.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: student.photo != null
                    ? Image.memory(student.photo!, fit: BoxFit.cover)
                    : Container(
                        color: template.primaryColor.withValues(alpha: 0.1),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: template.primaryColor,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 12),

            // Student Details below photo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  _buildDetailRow('Name:', student.name),
                  _buildDetailRow('Reg No:', student.regNo),
                  _buildDetailRow(
                    'Batch:',
                    '${student.startYear} - ${student.endYear}',
                  ),
                  _buildDetailRow('Department:', student.department),
                  _buildDetailRow('Blood Group:', student.bloodGroup),
                ],
              ),
            ),

            const Spacer(),

            // Principal Signature at bottom
            Column(
              children: [
                const Text(
                  'PRINCIPAL',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
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
                  child: const Center(
                    child: Text(
                      'Signature',
                      style: TextStyle(
                        fontSize: 6,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Footer Text
            Text(
              '*If found please return to College Office*',
              style: TextStyle(
                fontSize: 6,
                color: template.primaryColor,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: template.primaryColor.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              template.primaryColor.withValues(alpha: 0.05),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Center(
              child: Text(
                'STUDENT ID CARD',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Contact Information
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 6),
            _buildBackDetailRow('Mobile:', student.mobile),
            _buildBackDetailRow('Email:', student.email),
            _buildBackDetailRow('Aadhaar:', student.aadhaar),

            const SizedBox(height: 8),

            // Address
            const Text(
              'Address',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Text(
                student.address,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Parent/Guardian Information
            const Text(
              'Parent/Guardian Information',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 4),
            _buildBackDetailRow('Parent Name:', 'N/A'),
            _buildBackDetailRow('Parent Mobile:', 'N/A'),

            const Spacer(),

            // Emergency Contact Note
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency Contact',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'In case of emergency, please contact the college office or use the information provided above.',
                    style: TextStyle(
                      fontSize: 7,
                      color: Colors.black87,
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
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 8,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 45,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 9,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
