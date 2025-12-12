import 'package:cooking_pad/providers/auth/auth_session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/navigation/route_names.dart';

class AppDrawer extends ConsumerWidget {
  final Future<void> Function() onLogout;

  const AppDrawer({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authSessionProvider);

    final isLoggedIn = authState.maybeWhen(
      data: (session) => session != null,
      orElse: () => false,
    );

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(isLoggedIn ? 'User Name' : 'Guest'),
            accountEmail: Text(
              isLoggedIn ? 'user@example.com' : 'guest@example.com',
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/default_avatar.jpg'),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          // Other menu items
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // TODO: Navigate to profile screen
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // TODO: Navigate to settings screen
              Navigator.pop(context);
            },
          ),

          const Divider(),

          // Login / Logout button
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(isLoggedIn ? 'Logout' : 'Login'),
            onTap: () async {
              Navigator.pop(context);
              if (isLoggedIn) {
                await onLogout();
              } else {
                context.go(Routes.signin);
              }
            },
          ),
        ],
      ),
    );
  }
}
