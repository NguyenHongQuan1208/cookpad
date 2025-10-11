import 'package:cooking_pad/providers/storage/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/navigation/route_names.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(storageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign In Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign In Screen', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/demo.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text('Count: $count', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(storageProvider.notifier).increase();
              },
              child: const Text('Increase Count'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(storageProvider.notifier).reset();
              },
              child: const Text('Reset Count'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.push(Routes.register);
              },
              child: const Text('Go to Register'),
            ),
          ],
        ),
      ),
    );
  }
}
