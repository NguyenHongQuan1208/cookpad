import 'package:cooking_pad/navigation/route_names.dart';
import 'package:cooking_pad/providers/storage/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NavigationWrapper extends ConsumerStatefulWidget {
  const NavigationWrapper({super.key});

  @override
  ConsumerState<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends ConsumerState<NavigationWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Đã xảy ra lỗi. Vui lòng thử lại.")),
          );
        }

        final authState = snapshot.data;
        if (authState == null) {
          return const Scaffold(
            body: Center(child: Text("Không có dữ liệu đăng nhập.")),
          );
        }

        final session = authState.session;
        if (session != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.go(Routes.home);
            }
          });
        } else {
          final shown = ref.watch(storageProvider);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              if (!shown) {
                context.go(Routes.onboarding);
              } else {
                context.go(Routes.signin);
              }
            }
          });
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
