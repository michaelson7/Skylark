import 'package:flutter/material.dart';
import 'package:skylark/view/constants/constants.dart';

class PopUpDialog {
  BuildContext context;
  PopUpDialog({required this.context});

  showLoadingAnimation({
    String message = "Processing",
    required BuildContext context,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (builder) {
        return AlertDialog(
          content: SizedBox(
            // height: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: kPrimary),
                const SizedBox(width: 20),
                Text(message),
              ],
            ),
          ),
        );
      },
    );
  }

  closeDialog() {
    try {
      Navigator.pop(context);
    } catch (e) {}
  }
}
