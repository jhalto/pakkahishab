import 'dart:ui';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pakkahishab/core/const/app_colors.dart';

final loader = LoadingAnimationWidget.flickr(
  leftDotColor: Color(0xff00BBF2),
  rightDotColor: AppColors.primaryColor,
  size: 60,
);
final loader2 = LoadingAnimationWidget.fourRotatingDots(
  color: AppColors.primaryColor,

  size: 60,
);
