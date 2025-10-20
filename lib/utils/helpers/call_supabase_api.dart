import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cooking_pad/widget/loading_spinner_widget.dart';
import 'package:cooking_pad/widget/toast/toast.dart';

typedef SupabaseAuthService<T> = Future<T> Function();

/// Gọi Supabase Auth API với loading, success/error toast và callback
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
    if (successMessage != null && context != null && context.mounted) {
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

    if (context != null && context.mounted) {
      ToastHelper.showErrorToast(
        context,
        title: errorPrefix,
        subtitle: errorMsg,
      );
    }
  } finally {
    // Cleanup
    if (showLoading && context != null && context.mounted) {
      Navigator.of(context, rootNavigator: true).maybePop();
    }
    onFinally?.call();
  }
}
