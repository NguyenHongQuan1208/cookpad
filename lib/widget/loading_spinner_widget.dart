import 'package:flutter/material.dart';

class LoadingSpinnerWidget extends StatelessWidget {
  final Color? color;
  final double size;
  final String? message;
  final TextStyle? messageStyle;
  final bool showOverlay;
  final double overlayOpacity;
  final Color? overlayColor;
  final double strokeWidth;

  const LoadingSpinnerWidget({
    super.key,
    this.color,
    this.size = 40,
    this.message,
    this.messageStyle,
    this.showOverlay = false,
    this.overlayOpacity = 0.3,
    this.overlayColor,
    this.strokeWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget spinner = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? colorScheme.primary,
            ),
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style:
                messageStyle ??
                TextStyle(
                  color: color ?? colorScheme.onSurface,
                  fontSize: 14,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (showOverlay) {
      return Stack(
        alignment: Alignment.center,
        children: [
          ModalBarrier(
            color:
                overlayColor?.withValues(alpha: overlayOpacity) ??
                colorScheme.shadow.withValues(alpha: overlayOpacity),
            dismissible: false,
          ),
          spinner,
        ],
      );
    }

    return Center(child: spinner);
  }
}
