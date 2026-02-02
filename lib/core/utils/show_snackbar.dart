import 'package:flutter/material.dart';


enum SnackBarType { success, error }

class ShowSnackbar {
  static void showDefaultSnackBar(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.error,
  }) {
    final Color bgColor = type == SnackBarType.success ? Colors.green : Colors.red;
    final String title = type == SnackBarType.success ? 'Success' : 'Error';

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            type == SnackBarType.success ? Icons.check_circle : Icons.error,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$title: $message',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.zero,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void show(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.error,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);

    final bgColor = type == SnackBarType.success ? Colors.green : Colors.red;
    final icon = type == SnackBarType.success
        ? const Icon(Icons.check_circle, color: Colors.white, size: 28)
        : const Icon(Icons.error_outline, color: Colors.white, size: 28);
    final title = type == SnackBarType.success ? "Success" : "Error";

    // Animation controller
    final animationController = AnimationController(
      vsync: overlay,
      duration: const Duration(milliseconds: 300),
    );

    final animation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        );

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SafeArea(
          child: SlideTransition(
            position: animation,
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      icon,
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              message,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Play slide animation
    animationController.forward();

    // Remove after duration
    Future.delayed(duration, () async {
      await animationController.reverse();
      overlayEntry.remove();
      animationController.dispose();
    });
  }
}

const snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
// ScaffoldMessenger.of(context).showSnackBar(snackBar);
void showCustomSnackBar(
  BuildContext context,
  String message, {
  SnackBarType type = SnackBarType.error,
  Duration duration = const Duration(seconds: 3),
}) {
  Color bgColor;
  final String title = type == SnackBarType.success ? 'Success' : 'Error';
  final Icon icon = type == SnackBarType.success
      ? const Icon(Icons.done, color: Colors.white, size: 28)
      : const Icon(Icons.error_outline, color: Colors.white, size: 28);

  switch (type) {
    case SnackBarType.success:
      bgColor = Colors.black87;
      break;
    case SnackBarType.error:
      bgColor = Colors.red;
      break;
  }

  late OverlayEntry overlay;

  overlay = OverlayEntry(
    builder: (context) => Positioned(
      top: 45,
      left: 10,
      right: 10,
      child: Material(
        color: Colors.transparent,
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.up,
          onDismissed: (_) {
            if (overlay.mounted) overlay.remove();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icon,
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlay);

  Future.delayed(duration, () {
    if (overlay.mounted) overlay.remove();
  });
}

