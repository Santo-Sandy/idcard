import 'package:flutter/material.dart';

enum CardTemplate {
  classic,
  modern,
  minimal,
}

extension CardTemplateExtension on CardTemplate {
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
        return Colors.teal;
      case CardTemplate.modern:
        return Colors.blue;
      case CardTemplate.minimal:
        return Colors.grey;
    }
  }

  Color get secondaryColor {
    switch (this) {
      case CardTemplate.classic:
        return Colors.teal.shade700;
      case CardTemplate.modern:
        return Colors.blue.shade700;
      case CardTemplate.minimal:
        return Colors.grey.shade700;
    }
  }
}
