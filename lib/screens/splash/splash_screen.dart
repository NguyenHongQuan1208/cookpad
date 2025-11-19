import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooking_pad/navigation/route_names.dart';
import 'package:cooking_pad/providers/storage/storage_provider.dart';
import 'package:cooking_pad/config/image_paths.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    final isOnboardShown = ref.read(storageProvider);
    isOnboardShown.when(
      loading: () => _retryRedirect(),
      error: (_, __) => context.go(Routes.onboarding),
      data: (shown) => context.go(shown ? Routes.signin : Routes.onboarding),
    );
  }

  void _retryRedirect() {
    Future.delayed(const Duration(milliseconds: 500), _redirect);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ImagePaths.cookpadLogo2,
              width: w * 0.5,
              height: w * 0.5,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
