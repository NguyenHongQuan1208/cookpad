import 'package:cooking_pad/navigation/route_names.dart';
import 'package:cooking_pad/network/services/auth_service.dart';
import 'package:cooking_pad/utils/helpers/call_supabase_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is Home Screen", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final authService = AuthService();
                await callSupabaseAuthApi<void>(
                  service: () => authService.signOut(),
                  context: context,
                  onSuccess: (data) => context.go(Routes.signin),
                  showSuccessToast: false,
                  showErrorToast: false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
