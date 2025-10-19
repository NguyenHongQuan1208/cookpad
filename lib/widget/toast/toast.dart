import 'package:delightful_toast/delight_toast.dart';
import 'package:flutter/material.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';

class ToastHelper {
  // Show success toast
  static void showSuccessToast(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: duration,
      position: DelightSnackbarPosition.top,
      builder: (context) => ToastCard(
        leading: const Icon(Icons.check_circle, size: 28, color: Colors.green),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              )
            : null,
        color: Colors.green.shade50,
        shadowColor: Colors.green.withOpacity(0.2),
      ),
    ).show(context);
  }

  // Show error toast
  static void showErrorToast(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 4),
  }) {
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: duration,
      position: DelightSnackbarPosition.top,
      builder: (context) => ToastCard(
        leading: const Icon(Icons.error_outline, size: 28, color: Colors.red),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.red,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.red[400]),
              )
            : null,
        color: Colors.red.shade50,
        shadowColor: Colors.red.withOpacity(0.2),
      ),
    ).show(context);
  }

  // Show warning toast
  static void showWarningToast(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: duration,
      position: DelightSnackbarPosition.top,
      builder: (context) => ToastCard(
        leading: const Icon(
          Icons.warning_amber,
          size: 28,
          color: Colors.orange,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.orange,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.orange[600]),
              )
            : null,
        color: Colors.orange.shade50,
        shadowColor: Colors.orange.withOpacity(0.2),
      ),
    ).show(context);
  }

  // Show info toast
  static void showInfoToast(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: duration,
      position: DelightSnackbarPosition.top,
      builder: (context) => ToastCard(
        leading: const Icon(Icons.info_outline, size: 28, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.blue,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.blue[600]),
              )
            : null,
        color: Colors.blue.shade50,
        shadowColor: Colors.blue.withOpacity(0.2),
      ),
    ).show(context);
  }
}
