import 'package:flutter/material.dart';

import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/shared/global_widgets/custom_button.dart';

enum DialogType { success, error }

class ShowAppDialog {
  static void showSuccessDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.done, size: 30, color: Colors.white),
              ),
              const SizedBox(height: 18),
              Text("Success !", style: AppTextStyle.titleExtraLarge),
              const SizedBox(height: 5),
              Text(
                "Your payment was successful.",
                style: AppTextStyle.bodyMedium,
              ),
              Text(
                "A receipt for this purchase has",
                style: AppTextStyle.bodyMedium,
              ),
              Text("been sent to your email", style: AppTextStyle.bodyMedium),
              const SizedBox(height: 30),
              CustomButton(
                paddingVertical: 10,
                onTap: () {
                  Navigator.pop(context);
                },
                title: "Go Back",
              ),
            ],
          ),
        );
      },
    );
  }

  void showErrorDialog(
    BuildContext context, {
    String? body1,
    String? body2,
    VoidCallback? onTap,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.error_outline_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18),
              Text("Error !", style: AppTextStyle.titleExtraLarge),
              const SizedBox(height: 5),
              if (body1 != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    body1,
                    style: AppTextStyle.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (body2 != null) Text(body2, style: AppTextStyle.bodyMedium),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 10,
                    child: CustomButton(
                      color: AppColors.errorTextColor,
                      paddingVertical: 10,
                      paddingHorizontal: 6,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: "Go Back",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 15,
                    child: CustomButton(
                      paddingHorizontal: 6,
                      paddingVertical: 10,
                      onTap: onTap ?? () {},
                      title: "Confirm",
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showAppDialog(
    BuildContext context,
    String? msg, {
    DialogType type = DialogType.error,
    Duration autoCloseDuration = const Duration(seconds: 3),
  }) {
    final Color bgColor = type == DialogType.success ? Colors.green : Colors.red;
    final String title = type == DialogType.success ? "Success !" : "Error !";

    bool isDialogOpen = true;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: bgColor,
              child: type == DialogType.success
                  ? const Icon(Icons.done, size: 30, color: Colors.white)
                  : const Icon(
                      Icons.error_outline,
                      size: 30,
                      color: Colors.white,
                    ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // Replace with your titleLarge style
              ),
              textAlign: TextAlign.center,
            ),
            if (msg != null) ...[
              const SizedBox(height: 5),
              Text(
                msg,
                style: const TextStyle(
                  fontSize: 16,
                  // Replace with your titleMedium style
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: type == DialogType.error
                    ? Colors.red
                    : Colors.green,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
              ),
              onPressed: () {
                if (isDialogOpen) {
                  Navigator.of(context).pop();
                  isDialogOpen = false;
                }
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );

    // Auto close after duration
    Future.delayed(autoCloseDuration, () {
      if (isDialogOpen) {
        Navigator.of(context).pop();
        isDialogOpen = false;
      }
    });
  }
}
