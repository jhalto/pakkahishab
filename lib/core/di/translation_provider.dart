
import 'package:flutter_riverpod/legacy.dart';
import 'package:pakkahishab/translation_controller.dart';


final translationProvider =
    ChangeNotifierProvider<TranslationController>((ref) {
  return TranslationController();
});