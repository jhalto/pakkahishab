import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pakkahishab/core/const/app_colors.dart';

final loader = LoadingAnimationWidget.flickr(

leftDotColor: AppColors.primaryColor,
rightDotColor: AppColors.primaryColor2,
size: 60,
); 
final loader2 = LoadingAnimationWidget.fourRotatingDots(
  color: AppColors.primaryColor,

size: 60,
); 