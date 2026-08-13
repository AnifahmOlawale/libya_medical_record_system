import 'package:flutter/material.dart';

/// Slide to a new screen with a smooth right-to-left transition
void slideTo({
  required BuildContext context,
  required Widget page,
  required bool replace,
  String? routeName,
}) {
  final route = PageRouteBuilder(
    settings: RouteSettings(name: routeName), //  give the route a name
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // start from right
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
      //FadeTransition(opacity: animation, child: child),
    },
  );

  if (replace) {
    Navigator.pushReplacement(context, route);
  } else {
    Navigator.push(context, route);
  }
}

void slideUp({
  required BuildContext context,
  required Widget page,
  required bool replace,
  String? routeName,
}) {
  final route = PageRouteBuilder(
    settings: RouteSettings(name: routeName),
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // start from bottom
      const end = Offset.zero;
      const curve = Curves.easeOutCubic;
      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      // Combine slide + fade for a polished feel
      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
  if (replace) {
    Navigator.pushReplacement(context, route);
  } else {
    Navigator.push(context, route);
  }
}
