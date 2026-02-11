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
        return const Color.fromARGB(255, 146, 255, 250);
      case CardTemplate.modern:
        return const Color.fromARGB(255, 127, 187, 236);
      case CardTemplate.minimal:
        return const Color.fromARGB(255, 241, 157, 157);
    }
  }

  Color get secondaryColor {
    switch (this) {
      case CardTemplate.classic:
        return const Color.fromARGB(255, 24, 95, 95);
      case CardTemplate.modern:
        return const Color.fromARGB(255, 18, 58, 99);
      case CardTemplate.minimal:
        return const Color.fromARGB(255, 109, 29, 29);
    }
  }
}
