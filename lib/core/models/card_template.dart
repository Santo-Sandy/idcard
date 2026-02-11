import 'package:flutter/material.dart';

enum CardTemplate {
  classic,
  modern,
  minimal,
}

extension CardTemplateExtension on CardTemplate {
  // Light-teal palette tuned for this project.
  // Classic uses LightSeaGreen-like teal, modern uses blue, minimal uses greys.
  static const Color _lightTealPrimary = Color(0xFF20B2AA);
  static const Color _lightTealSecondary = Color(0xFF008B8B);

  String get displayName {
    switch (this) {
      case CardTemplate.classic:
        return 'Classic';
      case CardTemplate.modern:
        return 'Modern';
      case CardTemplate.minimal:
        return 'Minimal';
    }
  }

  Color get primaryColor {
    switch (this) {
      case CardTemplate.classic:
        return _lightTealPrimary;
      case CardTemplate.modern:
        return Colors.blue;
      case CardTemplate.minimal:
        return Colors.grey;
    }
  }

  Color get secondaryColor {
    switch (this) {
      case CardTemplate.classic:
        return _lightTealSecondary;
      case CardTemplate.modern:
        return Colors.blue.shade700;
      case CardTemplate.minimal:
        return Colors.grey.shade700;
    }
  }
}
