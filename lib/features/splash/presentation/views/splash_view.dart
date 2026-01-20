import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/images_path.dart';
import 'package:pakkahishab/features/splash/presentation/viewmodels/splash_viewmodel.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    // Call isLogin after the first frame
    Future.microtask(() async {
      // Read the notifier
      final splashNotifier = ref.read(splashViewModel.notifier);

      // Call isLogin and pass the context
      if(!context.mounted) return;
      await splashNotifier.isLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Image(image: AssetImage(ImagesPath.logo)),
      ),
    );
  }
}
