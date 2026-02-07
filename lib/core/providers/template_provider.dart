import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/card_template.dart';

final templateProvider =
    StateNotifierProvider<TemplateNotifier, CardTemplate>((ref) {
  return TemplateNotifier();
});

class TemplateNotifier extends StateNotifier<CardTemplate> {
  TemplateNotifier() : super(CardTemplate.classic);

  void setTemplate(CardTemplate template) {
    state = template;
  }
}
