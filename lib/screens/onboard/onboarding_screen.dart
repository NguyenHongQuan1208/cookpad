import 'package:cooking_pad/config/image_paths.dart';
import 'package:cooking_pad/providers/storage/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooking_pad/config/dimens.dart';

class OnboardScreen extends ConsumerWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.h(150)),

          Center(
            child: Image.asset(ImagePaths.cookpadLogo2, width: context.w(200)),
          ),

          SizedBox(height: context.h(50)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.w(30)),
            child: Text(
              'Chào mừng bạn đến với Cookpad!',
              style: textTheme.bodyLarge?.copyWith(
                fontSize: context.font(26),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: context.h(10)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.w(30)),
            child: Text(
              'Khám phá và xem công thức miễn phí.',
              style: textTheme.bodyMedium?.copyWith(fontSize: context.font(16)),
            ),
          ),

          Spacer(), // đẩy nút xuống cuối màn hình

          Center(
            child: ElevatedButton(
              onPressed: () async {
                ref.read(storageProvider.notifier).setShown();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w(100),
                  vertical: context.h(16),
                ),
                backgroundColor: colorScheme.primary,
              ),
              child: Text(
                'Bắt đầu',
                style: TextStyle(
                  fontSize: context.font(18),
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: context.h(60)),
        ],
      ),
    );
  }
}
