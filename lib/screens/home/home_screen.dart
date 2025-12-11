import 'package:cooking_pad/navigation/route_names.dart';
import 'package:cooking_pad/network/services/auth_service.dart';
import 'package:cooking_pad/utils/helpers/call_supabase_api.dart';
import 'package:cooking_pad/widget/app_header.dart';
import 'package:cooking_pad/widget/app_drawer.dart'; // 👈 import drawer mới
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(isSearchScreen: true),

      drawer: AppDrawer(onLogout: () => _logout(context)),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is Home Screen", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
