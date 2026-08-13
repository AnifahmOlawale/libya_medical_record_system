import 'package:flutter/material.dart';

/// A [NotchedShape] that combines rounded TOP corners with a circular
/// notch cut out for a docked FAB.
///
/// Flutter's built-in [CircularNotchedRectangle] only handles the
/// notch — the rest of the bar always renders as a plain rectangle
/// with square corners. This shape adds the rounded top-left /
/// top-right corners on top of that.
///
/// How it works: build a rounded-rectangle [Path] for the bar's outer
/// shape, build a circle [Path] sized to the FAB (the [guest] rect
/// BottomAppBar passes in is already inflated by `notchMargin`), then
/// subtract the circle from the rectangle with
/// `Path.combine(PathOperation.difference, ...)`. That subtraction is
/// what actually carves the curved bite out of the middle — no manual
/// Bezier math needed.
///
/// Trade-off worth knowing: Flutter's internal [CircularNotchedRectangle]
/// uses hand-tuned quadratic-Bezier + arc math to make the notch blend
/// into the flat top edge with a perfectly smooth, tangent transition.
/// A plain circle subtraction (this class) is simpler and easy to
/// verify correct, but leaves a very slightly sharper transition where
/// the circle's edge meets the flat top line. In practice, at normal
/// FAB sizes this reads as smooth to the eye — but if you want the
/// exact silky Flutter-internal curve blended with rounded corners
/// too, that requires reproducing their arc/Bezier construction by
/// hand instead of the boolean-difference approach used here.
class RoundedNotchedRectangle extends NotchedShape {
  const RoundedNotchedRectangle({this.topCornerRadius = 24});

  /// Radius applied to the bar's top-left and top-right corners.
  /// Bottom corners stay square, matching a bar sitting flush against
  /// the bottom of the screen.
  final double topCornerRadius;

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final roundedRect = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          host,
          topLeft: Radius.circular(topCornerRadius),
          topRight: Radius.circular(topCornerRadius),
        ),
      );

    if (guest == null || !host.overlaps(guest)) {
      return roundedRect;
    }

    // guest is already inflated by BottomAppBar's notchMargin, so its
    // own half-width is exactly the radius we want for the cutout.
    final notchRadius = guest.width / 2.0;
    final notchCircle = Path()
      ..addOval(Rect.fromCircle(center: guest.center, radius: notchRadius));

    return Path.combine(PathOperation.difference, roundedRect, notchCircle);
  }
}
