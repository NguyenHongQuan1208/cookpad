import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cooking_pad/widget/loading_spinner_widget.dart';
import 'package:cooking_pad/widget/toast/toast.dart';

Future<void> callSupabaseApi<T>({
  required Future<T> Function() service,
  BuildContext? context,
  VoidCallback? onPreRun,
  Function(T data)? onSuccess,
  Function(String message)? onError,
  VoidCallback? onFinally,
  bool showLoading = true,
  String? successMessage,
  String errorPrefix = "Error",
  bool showSuccessToast = true,
  bool showErrorToast = true,
}) async {
  try {
    onPreRun?.call();

    if (showLoading && context != null && context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingSpinnerWidget(showOverlay: true),
      );
    }

    final result = await service();

    onSuccess?.call(result);
    if (showSuccessToast &&
        successMessage != null &&
        context != null &&
        context.mounted) {
      SnackbarHelper.show(context, successMessage);
    }
  } catch (e) {
    final errorMsg = switch (e) {
      AuthException(:final message) => message,
      PostgrestException(:final message) => message,
      StorageException(:final message) => message,
      _ => e.toString(),
    };

    onError?.call(errorMsg);

    if (showErrorToast && context != null && context.mounted) {
      SnackbarHelper.show(context, '$errorPrefix: $errorMsg');
    }
  } finally {
    if (showLoading && context != null && context.mounted) {
      final navigator = Navigator.maybeOf(context, rootNavigator: true);
      if (navigator != null && navigator.canPop()) {
        navigator.pop();
      }
    }
    onFinally?.call();
  }
}
