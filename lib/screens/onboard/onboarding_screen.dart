import 'package:cooking_pad/config/image_paths.dart';
import 'package:cooking_pad/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/config/dimens.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

          // Using horizontal scaling for padding
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.w(30)),
            child: Text(
              'Chào mừng bạn đến với Cookpad!',
              style: textTheme.bodyLarge?.copyWith(
                fontSize: context.font(26), // Using font scaling
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
                  onPressed: () {},
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
