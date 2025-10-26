import 'package:cooking_pad/network/services/auth_service.dart';
import 'package:cooking_pad/utils/helpers/call_supabase_api.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HomeScreen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final authService = AuthService();

                await callSupabaseAuthApi<void>(
                  service: () => authService.signOut(),
                  context: context,
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
