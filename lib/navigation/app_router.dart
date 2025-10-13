// File: lib/navigation/app_router.dart

import 'package:cooking_pad/screens/onboard/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/screens/sign_In/sign_in_screen.dart';
import 'package:cooking_pad/screens/register/register_screen.dart';
// import '../features/onboarding/ui/splash_screen.dart';
import 'route_names.dart';

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
  initialLocation: Routes.onboarding,
  routes: [
    GoRoute(
      path: Routes.onboarding,
      pageBuilder: (context, state) => state.slidePage(const OnboardScreen()),
    ),
    // GoRoute(
    //   path: Routes.splash,
    //   pageBuilder: (context, state) => state.slidePage(const SplashScreen()),
    // ),
    GoRoute(
      path: Routes.signin,
      pageBuilder: (context, state) => state.slidePage(SignInScreen()),
    ),
    GoRoute(
      path: Routes.register,
      pageBuilder: (context, state) => state.slidePage(const RegisterScreen()),
    ),
    // GoRoute(
    //   path: Routes.otp,
    //   pageBuilder: (context, state) {
    //     final map = state.extra as Map?;
    //     return state.slidePage(
    //       OtpScreen(
    //         email: map?['email'],
    //         isRegister: map?['isRegister'],
    //       ),
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: Routes.main,
    //   pageBuilder: (context, state) => state.slidePage(const MainScreen()),
    // ),
  ],
);
