import 'dart:math';

import 'package:flutter/material.dart';

class Paintcircle extends StatefulWidget {
  final percentage;
  const Paintcircle({super.key, this.percentage});

  @override
  State<Paintcircle> createState() => _PaintcircleState();
}

class _PaintcircleState extends State<Paintcircle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(22, 21, 25, 1.0),
          ),
          child: ProgressPercentageText(child: widget.percentage)
          //  CustomPaint(
          //   painter: MyPainter(),
          // ),
          ),
    );
  }
}

class MyPainter extends CustomPainter {
  final percentage;
  final backgroundColor;
  final progressColor;
  final freeColor;

  MyPainter(
      {required this.percentage,
      required this.backgroundColor,
      required this.progressColor,
      required this.freeColor});
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint();
    backgroundPaint.color = backgroundColor
        // Colors.black
        ;

    backgroundPaint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backgroundPaint);

    final feeledPaint = Paint();
    feeledPaint.color = freeColor;
    feeledPaint.style = PaintingStyle.stroke;
    feeledPaint.strokeWidth = 5;
    feeledPaint.strokeCap = StrokeCap.round;
    canvas.drawArc(
        const Offset(5.5, 5.5) & Size(size.width - 11, size.height - 11),
        pi * 2 * percentage - (pi / 2),
        pi * 2 * (1.0 - percentage),
        false,
        feeledPaint);

    final feelPaint = Paint();
    feelPaint.color = progressColor;
    feelPaint.style = PaintingStyle.stroke;
    feelPaint.strokeWidth = 5;
    feelPaint.strokeCap = StrokeCap.round;
    canvas.drawArc(
        const Offset(5.5, 5.5) & Size(size.width - 11, size.height - 11),
        -pi / 2,
        pi * 2 * percentage,
        false,
        feelPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ProgressPercentageText extends StatelessWidget {
  final child;
  final textPercentage;
  const ProgressPercentageText(
      {super.key, required this.child, this.textPercentage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MyPainter(
              backgroundColor: Colors.black,
              progressColor: Colors.green,
              freeColor: Colors.yellow,
              percentage: child),
        ),
        Center(
            child: Text(
          ((child * 100).toInt()).toString(),
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ))
      ],
    );
  }
}
