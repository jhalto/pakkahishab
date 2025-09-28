
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/translation_controller.dart';


final translationProvider = NotifierProvider< TranslationNotifier , TranslationState>(TranslationNotifier.new);