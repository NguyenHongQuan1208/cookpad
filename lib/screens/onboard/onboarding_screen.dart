import 'package:cooking_pad/config/image_paths.dart';
import 'package:cooking_pad/navigation/route_names.dart';
import 'package:cooking_pad/widget/loading_spinner_widget.dart'; // Import spinner widget
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/config/dimens.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  bool _isLoading = false;

  void _testSpinner() async {
    setState(() {
      _isLoading = true;
    });

    // Test spinner trong 10 giây
    await Future.delayed(const Duration(seconds: 10));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.h(150)),

              Center(
                child: Image.asset(
                  ImagePaths.cookpadLogo2,
                  width: context.w(200),
                ),
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
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: context.font(16),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(height: context.h(200)),

              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
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

                    // Nút test spinner
                    TextButton(
                      onPressed: _isLoading ? null : _testSpinner,
                      child: Text(
                        'Test Spinner (10s)',
                        style: TextStyle(
                          fontSize: context.font(14),
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: _isLoading ? null : () {},
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

          // Hiển thị spinner khi đang loading
          if (_isLoading)
            const LoadingSpinnerWidget(
              message: 'Đang test spinner...',
              color: Colors.orange,
              size: 50,
            ),
        ],
      ),
    );
  }
}
