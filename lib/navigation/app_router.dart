import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/screens/home/home_screen.dart';
import 'package:cooking_pad/screens/onboard/onboarding_screen.dart';
import 'package:cooking_pad/screens/personal/personal_screen.dart';
import 'package:cooking_pad/screens/sign_In/sign_in_screen.dart';
import 'package:cooking_pad/screens/register/register_screen.dart';
import 'package:cooking_pad/screens/splash/splash_screen.dart';
import 'package:cooking_pad/navigation/route_names.dart';

enum SlideDirection { right, left, up, down }

extension GoRouterStateExtension on GoRouterState {
  SlideRouteTransition slidePage(
    Widget child, {
    SlideDirection direction = SlideDirection.left,
  }) {
    return SlideRouteTransition(
      key: pageKey,
      child: child,
      direction: direction,
    );
  }
}

class SlideRouteTransition extends CustomTransitionPage<void> {
  SlideRouteTransition({
    required super.key,
    required super.child,
    SlideDirection direction = SlideDirection.left,
  }) : super(
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final curve = CurvedAnimation(
             parent: animation,
             curve: Curves.easeInOut,
           );

           Offset begin;
           switch (direction) {
             case SlideDirection.right:
               begin = const Offset(-1.0, 0.0);
               break;
             case SlideDirection.left:
               begin = const Offset(1.0, 0.0);
               break;
             case SlideDirection.up:
               begin = const Offset(0.0, 1.0);
               break;
             case SlideDirection.down:
               begin = const Offset(0.0, -1.0);
               break;
           }

           final tween = Tween(begin: begin, end: Offset.zero);
           final offsetAnimation = tween.animate(curve);

           return SlideTransition(position: offsetAnimation, child: child);
         },
       );
}

final router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      pageBuilder: (context, state) => state.slidePage(
        const SplashScreen(),
        direction: SlideDirection.right,
      ),
    ),
    GoRoute(
      path: Routes.onboarding,
      pageBuilder: (context, state) => state.slidePage(
        const OnboardScreen(),
        direction: SlideDirection.right,
      ),
    ),
    GoRoute(
      path: Routes.signin,
      pageBuilder: (context, state) =>
          state.slidePage(SignInScreen(), direction: SlideDirection.right),
    ),
    GoRoute(
      path: Routes.register,
      pageBuilder: (context, state) => state.slidePage(
        const RegisterScreen(),
        direction: SlideDirection.right,
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Personal',
              ),
            ],
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              pageBuilder: (context, state) => state.slidePage(
                HomeScreen(),
                direction: SlideDirection.right,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.personal,
              pageBuilder: (context, state) => state.slidePage(
                PersonalScreen(),
                direction: SlideDirection.right,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
