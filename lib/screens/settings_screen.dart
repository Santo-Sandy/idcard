import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _autoSave = true;
  String _exportFormat = 'PNG';
  double _imageQuality = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Section
          _buildSectionHeader('Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme'),
            value: _darkMode,
            onChanged: (value) {
              setState(() => _darkMode = value);
              // TODO: Implement theme switching
            },
          ),

          const Divider(),

          // Export Settings Section
          _buildSectionHeader('Export Settings'),
          ListTile(
            title: const Text('Default Export Format'),
            subtitle: Text(_exportFormat),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showFormatDialog(),
          ),
          ListTile(
            title: const Text('Image Quality'),
            subtitle: Text('${(_imageQuality * 100).round()}%'),
            trailing: Slider(
              value: _imageQuality,
              onChanged: (value) => setState(() => _imageQuality = value),
              min: 0.5,
              max: 1.0,
              divisions: 10,
            ),
          ),

          const Divider(),

          // General Settings Section
          _buildSectionHeader('General'),
          SwitchListTile(
            title: const Text('Auto-save Data'),
            subtitle: const Text('Automatically save changes'),
            value: _autoSave,
            onChanged: (value) => setState(() => _autoSave = value),
          ),

          const Divider(),

          // About Section
          _buildSectionHeader('About'),
          ListTile(
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            title: const Text('Developer'),
            subtitle: const Text('ID Card Generator Team'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  void _showFormatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Export Format'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['PNG', 'JPEG', 'PDF'].map((format) {
            final selected = _exportFormat == format;
            return ListTile(
              title: Text(format),
              trailing: selected ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => _exportFormat = format);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
