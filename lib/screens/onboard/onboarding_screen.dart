import 'package:cooking_pad/config/image_paths.dart';
import 'package:cooking_pad/navigation/route_names.dart';
import 'package:cooking_pad/providers/storage/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
              textAlign: TextAlign.left,
            ),
          ),

          SizedBox(height: context.h(10)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.w(30)),
            child: Text(
              'Đăng ký và xem công thức miễn phí.',
              style: textTheme.bodyMedium?.copyWith(fontSize: context.font(16)),
              textAlign: TextAlign.left,
            ),
          ),

          SizedBox(height: context.h(200)),

          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(storageProvider.notifier).setShown();
                    context.push(Routes.signin);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w(60),
                      vertical: context.h(14),
                    ),
                    backgroundColor: colorScheme.primary,
                  ),
                  child: Text(
                    'Đăng ký hoặc Đăng nhập',
                    style: TextStyle(
                      fontSize: context.font(16),
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(storageProvider.notifier).setShown();
                    context.push(Routes.home);
                  },
                  child: Text(
                    'Để sau',
                    style: TextStyle(
                      fontSize: context.font(14),
                      color: textTheme.bodyMedium?.color,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
