import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../../data/models/teacher.dart';
import '../../core/models/card_template.dart';

class TeacherFlipCard extends StatelessWidget {
  final Teacher teacher;
  final GlobalKey? repaintKey;
  final CardTemplate template;

  const TeacherFlipCard({
    super.key,
    required this.teacher,
    this.repaintKey,
    this.template = CardTemplate.classic,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: repaintKey,
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: _buildFrontCard(context),
        back: _buildBackCard(context),
      ),
    );
  }

  Widget _buildFrontCard(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = template.primaryColor;
    final secondary = template.secondaryColor;
    return Card(
      elevation: 12,
      shadowColor: primary.withValues(alpha: 0.22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primary.withValues(alpha: 0.12),
              cs.surface,
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
                color: primary.withValues(alpha: 0.10),
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
                      color: primary.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.school,
                      color: secondary,
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
                            color: secondary,
                          ),
                        ),
                        Text(
                          '(Affiliated to XYZ University)',
                          style: TextStyle(
                            fontSize: 6,
                            color: secondary.withValues(alpha: 0.8),
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
                color: cs.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Center Photo
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                    color: secondary.withValues(alpha: 0.45),
                    width: 2),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: secondary.withValues(alpha: 0.16),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: teacher.photo != null
                    ? Image.memory(teacher.photo!, fit: BoxFit.cover)
                    : Container(
                        color: primary.withValues(alpha: 0.10),
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: secondary,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 12),

            // Teacher Details below photo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  _buildDetailRow(context, 'Name:', teacher.name),
                  _buildDetailRow(context, 'Staff ID:', teacher.staffId),
                  _buildDetailRow(context, 'Department:', teacher.department),
                  _buildDetailRow(context, 'Blood Group:', teacher.bloodGroup),
                ],
              ),
            ),

            const Spacer(),

            // Principal Signature at bottom
            Column(
              children: [
                Text(
                  'PRINCIPAL',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: secondary,
                  ),
                ),
                Container(
                  width: 80,
                  height: 30,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: primary.withValues(alpha: 0.55)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      'Signature',
                      style: TextStyle(
                        fontSize: 6,
                        color: secondary.withValues(alpha: 0.75),
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
                color: secondary,
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
    final cs = Theme.of(context).colorScheme;
    final primary = template.primaryColor;
    final secondary = template.secondaryColor;
    return Card(
      elevation: 8,
      shadowColor: primary.withValues(alpha: 0.18),
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
              primary.withValues(alpha: 0.10),
              cs.surface,
            ],
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
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: secondary,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Contact Information
            Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: secondary,
              ),
            ),
            const SizedBox(height: 6),
            _buildBackDetailRow(context, 'Mobile:', teacher.mobile),
            _buildBackDetailRow(context, 'Email:', teacher.email),

            const SizedBox(height: 8),

            // Address
            Text(
              'Address',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: secondary,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: primary.withValues(alpha: 0.35)),
              ),
              child: Text(
                teacher.address,
                style: TextStyle(
                  fontSize: 8,
                  color: cs.onSurface,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Professional Information
            Text(
              'Professional Information',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: secondary,
              ),
            ),
            const SizedBox(height: 4),
            _buildBackDetailRow(context, 'Designation:', teacher.designation),
            _buildBackDetailRow(context, 'Department:', teacher.department),
            _buildBackDetailRow(context, 'Staff ID:', teacher.staffId),
            _buildBackDetailRow(context, 'Blood Group:', teacher.bloodGroup),

            const Spacer(),

            // Emergency Contact Note
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: primary.withValues(alpha: 0.35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency Contact',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: secondary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'In case of emergency, please contact the college office or use the information provided above.',
                    style: TextStyle(
                      fontSize: 7,
                      color: cs.onSurfaceVariant,
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

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: template.secondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 8,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 45,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: template.secondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 9,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
