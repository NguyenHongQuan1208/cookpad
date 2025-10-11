import 'package:cooking_pad/providers/storage/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(storageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Register Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Register Screen', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text('Count: $count', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      ref.read(storageProvider.notifier).increase(),
                  child: const Text('Increase'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => ref.read(storageProvider.notifier).reset(),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
