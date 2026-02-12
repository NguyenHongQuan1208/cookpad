import 'package:cooking_pad/navigation/bottomTab/main_bottom_tab.dart';
import 'package:cooking_pad/navigation/route_names.dart';
import 'package:cooking_pad/network/services/auth_service.dart';
import 'package:cooking_pad/utils/helpers/call_supabase_api.dart';
import 'package:cooking_pad/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  const MainShell({super.key, required this.navigationShell});

  Future<void> _logout(BuildContext context) async {
    final authService = AuthService();
    await callSupabaseAuthApi<void>(
      service: () => authService.signOut(),
      context: context,
      onSuccess: (_) => context.go(Routes.signin),
      showSuccessToast: false,
      showErrorToast: false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(onLogout: () => _logout(context)),
      body: navigationShell,
      bottomNavigationBar: MainBottomTab(navigationShell: navigationShell),
    );
  }
}
