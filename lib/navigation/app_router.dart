import 'package:cooking_pad/screens/home/home_screen.dart';
import 'package:cooking_pad/screens/onboard/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/screens/sign_In/sign_in_screen.dart';
import 'package:cooking_pad/screens/register/register_screen.dart';
import 'package:cooking_pad/navigation/route_names.dart';
import 'package:cooking_pad/navigation/navigation_wrapper.dart';

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

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          state.slidePage(const NavigationWrapper()),
    ),
    GoRoute(
      path: Routes.onboarding,
      pageBuilder: (context, state) => state.slidePage(const OnboardScreen()),
    ),
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) => state.slidePage(HomeScreen()),
    ),
    GoRoute(
      path: Routes.signin,
      pageBuilder: (context, state) => state.slidePage(SignInScreen()),
    ),
    GoRoute(
      path: Routes.register,
      pageBuilder: (context, state) => state.slidePage(const RegisterScreen()),
    ),
  ],
);
