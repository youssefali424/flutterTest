import 'package:flutter/painting.dart';
import 'dart:math' as math;

/// A convex shape which implemented [NotchedShape].
///
/// It's used to draw a convex shape for [ConvexAppBar], If you are interested about
/// the math calculation, please refer to [CircularNotchedRectangle], it's based
/// on Bezier curve;
///
/// See also:
///
///  * [CircularNotchedRectangle], a rectangle with a smooth circular notch.
class ConvexNotchedRectangle extends NotchedShape {
  /// Draw the background with topLeft and topRight corner
  final double radius;

  /// Create Shape instance
  const ConvexNotchedRectangle({this.radius = 0});

  @override
  Path getOuterPath(Rect host, Rect guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final notchRadius = guest.height / 2.0;

    const s1 = 15.0;
    const s2 = 1.0;

    final r = notchRadius;
    final a = -1.0 * r - s2;
    final b = host.left - guest.center.dx;

    final n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final p2yA = -math.sqrt(r * r - p2xA * p2xA);
    final p2yB = -math.sqrt(r * r - p2xB * p2xB);

    final p = List<Offset>.filled(6, Offset.zero, growable: false);
    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(b, a);
    final cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (var i = 0; i < p.length; i += 1) {
      p[i] = p[i] + guest.center;
      //p[i] += padding;
    }

    return radius > 0
        ? (Path()
          ..moveTo(host.left, host.top + radius)
          ..arcToPoint(Offset(host.left + radius, host.top),
              radius: Radius.circular(radius))
          ..lineTo(p[0].dx, p[0].dy)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
          ..arcToPoint(
            p[3],
            radius: Radius.circular(notchRadius),
            clockwise: true,
          )
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
          ..lineTo(host.right - radius, host.top)
          ..arcToPoint(Offset(host.right, host.top + radius),
              radius: Radius.circular(radius))
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close())
        : (Path()
          ..moveTo(host.left, host.top)
          ..lineTo(p[0].dx, p[0].dy)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
          ..arcToPoint(
            p[3],
            radius: Radius.circular(notchRadius),
            clockwise: true,
          )
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
          ..lineTo(host.top, host.bottom)
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close());
  }
}
