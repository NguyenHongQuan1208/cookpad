import 'package:cooking_pad/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.go(Routes.onboarding);
            }
          });
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
