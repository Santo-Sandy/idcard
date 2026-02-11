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
    final child = FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: _buildFrontCard(context),
      back: _buildBackCard(context),
    );

    // Needed for image export: the key must be on a RepaintBoundary.
    if (repaintKey != null) {
      return RepaintBoundary(key: repaintKey, child: child);
    }
    return child;
  }

  Widget _buildFrontCard(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = template.primaryColor;
    final secondary = template.secondaryColor;
    final surface = cs.surface;
    final onSurfaceVariant = cs.onSurfaceVariant;

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
              primary.withValues(alpha: 0.12),
              surface,
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
                border: Border.all(
                  color: primary.withValues(alpha: 0.28),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo placeholder with gradient
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          secondary,
                          primary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: secondary.withValues(alpha: 0.22),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.white,
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
                            letterSpacing: 0.5,
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
                color: onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Center Photo with Enhanced styling
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: secondary.withValues(alpha: 0.45),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: secondary.withValues(alpha: 0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: secondary.withValues(alpha: 0.08),
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

            // Student Details below photo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildDetailRow(context, 'Name:', student.name),
                  _buildDetailRow(context, 'Reg No:', student.regNo),
                  _buildDetailRow(
                    context,
                    'Batch:',
                    '${student.startYear} - ${student.endYear}',
                  ),
                  _buildDetailRow(context, 'Department:', student.department),
                  _buildDetailRow(context, 'Blood Group:', student.bloodGroup),
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
                    letterSpacing: 0.5,
                  ),
                ),
                Container(
                  width: 80,
                  height: 30,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primary.withValues(alpha: 0.45),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      'Signature',
                      style: TextStyle(
                        fontSize: 6,
                        color: secondary.withValues(alpha: 0.7),
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
                fontWeight: FontWeight.w500,
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
    final surface = cs.surface;
    final onSurface = cs.onSurface;
    final onSurfaceVariant = cs.onSurfaceVariant;

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
              primary.withValues(alpha: 0.12),
              surface,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Text(
                'STUDENT ID CARD',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: secondary,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Contact Information
            _buildSectionHeader('Contact Information'),
            const SizedBox(height: 6),
            _buildBackDetailRow(context, 'Mobile:', student.mobile),
            _buildBackDetailRow(context, 'Email:', student.email),
            _buildBackDetailRow(context, 'Aadhaar:', student.aadhaar),

            const SizedBox(height: 8),

            // Address
            _buildSectionHeader('Address'),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: primary.withValues(alpha: 0.35),
                  width: 1,
                ),
              ),
              child: Text(
                student.address,
                style: TextStyle(
                  fontSize: 8,
                  color: onSurface,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Parent/Guardian Information
            _buildSectionHeader('Parent/Guardian Information'),
            const SizedBox(height: 4),
            _buildBackDetailRow(context, 'Parent Name:', 'N/A'),
            _buildBackDetailRow(context, 'Parent Mobile:', 'N/A'),

            const Spacer(),

            // Emergency Contact Note
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: primary.withValues(alpha: 0.35),
                  width: 1,
                ),
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
                  const SizedBox(height: 2),
                  Text(
                    'In case of emergency, please contact the college office or use the information provided above.',
                    style: TextStyle(
                      fontSize: 7,
                      color: onSurfaceVariant,
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

  Widget _buildSectionHeader(String title) {
    final secondary = template.secondaryColor;
    return Text(
      title,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: secondary,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final secondary = template.secondaryColor;
    final onSurface = Theme.of(context).colorScheme.onSurface;
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
                color: secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 8,
                color: onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackDetailRow(BuildContext context, String label, String value) {
    final secondary = template.secondaryColor;
    final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;
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
                color: secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 9,
                color: onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
