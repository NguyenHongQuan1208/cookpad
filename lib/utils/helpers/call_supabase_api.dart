import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cooking_pad/widget/loading_spinner_widget.dart';
import 'package:cooking_pad/widget/toast/toast.dart';

typedef SupabaseAuthService<T> = Future<T> Function();

Future<void> callSupabaseAuthApi<T>({
  required SupabaseAuthService<T> service,
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
    // Trước khi gọi API
    onPreRun?.call();

    // Hiển thị loading
    if (showLoading && context != null && context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingSpinnerWidget(showOverlay: true),
      );
    }

    // Gọi service
    final result = await service();

    // Success
    onSuccess?.call(result);
    if (showSuccessToast &&
        successMessage != null &&
        context != null &&
        context.mounted) {
      ToastHelper.showSuccessToast(
        context,
        title: 'Success',
        subtitle: successMessage,
      );
    }
  } catch (e) {
    // Bắt lỗi
    String errorMsg = e is AuthException ? e.message : e.toString();
    onError?.call(errorMsg);

    if (showErrorToast && context != null && context.mounted) {
      ToastHelper.showErrorToast(
        context,
        title: errorPrefix,
        subtitle: errorMsg,
      );
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
