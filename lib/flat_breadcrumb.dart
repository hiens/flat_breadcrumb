library flat_breadcrumb;

import 'dart:math' as math;
import 'package:flutter/material.dart';

class FlatBreadcrumb extends StatelessWidget {
  FlatBreadcrumb({super.key});
  final List<Widget> _sampleItems = [
    BreadcrumbItem(isFirst: true),
    BreadcrumbItem(),
    BreadcrumbItem(),
    BreadcrumbItem(),
    BreadcrumbItem(),
    BreadcrumbItem(isLast: true),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _sampleItems
            .asMap()
            .map((i, e) => MapEntry(
                i,
                Transform.translate(
                    offset: Offset(-20.0 * i, 0),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: _sampleItems[i],
                    ))))
            .values
            .toList(),
      ),
    );
  }
}

class BreadcrumbItem extends StatelessWidget {
  const BreadcrumbItem({this.isFirst = false, this.isLast = false, super.key});

  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: BreadcrumbItemPainter(
          strokeColor: Colors.black,
          backgroundColor: Colors.grey,
          strokeCap: StrokeCap.round,
          strokeWidth: 1,
          isFirst: isFirst,
          isLast: isLast,
        ),
        child: SizedBox.expand());
  }
}

class BreadcrumbItemPainter extends CustomPainter {
  const BreadcrumbItemPainter({
    required this.strokeColor,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.strokeCap,
    required this.isFirst,
    required this.isLast,
  });

  final Color strokeColor;
  final Color backgroundColor;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final bool isFirst;
  final bool isLast;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap;
    final x = size.width;
    final y = size.height;

    final Path path = Path();
    path
      ..moveTo(0, 0)
      ..lineTo(x - y / 2, 0);

    if (isLast) {
      path.addArc(
          Rect.fromCenter(
              center: Offset(x - y / 2, y / 2), height: y, width: y),
          3 * math.pi / 2,
          math.pi);
    } else {
      path
        ..lineTo(x, y / 2)
        ..lineTo(x - y / 2, y);
    }

    path.lineTo(0, y);

    if (isFirst) {
      path.lineTo(0, 0);
    } else {
      path
        ..lineTo(y / 2, y / 2)
        ..lineTo(0, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
