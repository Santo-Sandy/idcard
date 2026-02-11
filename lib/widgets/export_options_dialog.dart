import 'package:flutter/material.dart';

class ExportOptionsDialog extends StatefulWidget {
  final String title;
  final Function(String format, double quality, bool shareAfterExport) onExport;

  const ExportOptionsDialog({
    super.key,
    required this.title,
    required this.onExport,
  });

  @override
  State<ExportOptionsDialog> createState() => _ExportOptionsDialogState();
}

class _ExportOptionsDialogState extends State<ExportOptionsDialog> {
  String _selectedFormat = 'PNG';
  double _quality = 1.0;
  // "Download" is the default; sharing is optional.
  bool _shareAfterExport = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Format Selection
            const Text(
              'Export Format',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['PNG', 'JPEG', 'PDF'].map((format) {
                return ChoiceChip(
                  label: Text(format),
                  selected: _selectedFormat == format,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedFormat = format);
                    }
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Quality Slider (for images)
            if (_selectedFormat != 'PDF') ...[
              const Text(
                'Image Quality',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _quality,
                      onChanged: (value) => setState(() => _quality = value),
                      min: 0.5,
                      max: 1.0,
                      divisions: 10,
                      label: '${(_quality * 100).round()}%',
                    ),
                  ),
                  Text('${(_quality * 100).round()}%'),
                ],
              ),
            ],

            const SizedBox(height: 16),

            // Share Option
            SwitchListTile(
              title: const Text('Share after export'),
              subtitle: const Text('Automatically open share dialog'),
              value: _shareAfterExport,
              onChanged: (value) => setState(() => _shareAfterExport = value),
              dense: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onExport(_selectedFormat, _quality, _shareAfterExport);
            Navigator.pop(context);
          },
          child: const Text('Export'),
        ),
      ],
    );
  }
}
