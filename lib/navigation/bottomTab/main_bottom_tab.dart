import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/providers/auth/auth_session_provider.dart';
import 'package:cooking_pad/widget/custom_alert_dialog.dart';
import 'package:cooking_pad/navigation/route_names.dart';

class MainBottomTab extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainBottomTab({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authSessionProvider);
    final isLoggedIn = authState.maybeWhen(
      data: (session) => session != null,
      orElse: () => false,
    );

    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          currentIndex: navigationShell.currentIndex,

          selectedItemColor: Theme.of(context).colorScheme.onPrimary,
          unselectedItemColor: Theme.of(
            context,
          ).colorScheme.onPrimary.withOpacity(0.5),

          selectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 14),

          onTap: (index) {
            if (index == 1 && !isLoggedIn) {
              showDialog(
                context: context,
                builder: (dialogContext) {
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
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Delicious Dish Storage',
            ),
          ],
        ),
      ),
    );
  }
}
