import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/providers/auth/auth_session_provider.dart';
import 'package:cooking_pad/widget/custom_alert_dialog.dart';
import 'package:cooking_pad/navigation/route_names.dart';

class MainShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authSessionProvider);
    final isLoggedIn = authState.maybeWhen(
      data: (session) => session != null,
      orElse: () => false,
    );

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          if (index == 1 && !isLoggedIn) {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return CustomAlertDialog(
                  title: 'Notice',
                  content: 'You need to sign in to access this feature.',
                  buttonContent: {
                    'Skip': () {
                      Navigator.of(dialogContext).pop();
                    },
                    'Sign In': () {
                      Navigator.of(dialogContext).pop();
                      GoRouter.of(context).go(Routes.signin);
                    },
                  },
                );
              },
            );
          } else {
            navigationShell.goBranch(index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Delicious Dish Storage',
          ),
        ],
      ),
    );
  }
}
