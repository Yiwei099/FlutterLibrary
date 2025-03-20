import 'package:flutter/material.dart';
import 'package:xiandun/utils/colors.dart';

class ScannerAnimation extends StatefulWidget {
  final bool needBorder;

  const ScannerAnimation({super.key, this.needBorder = false});

  @override
  // ignore: library_private_types_in_public_api
  _ScannerAnimation createState() => _ScannerAnimation();
}

class _ScannerAnimation extends State<ScannerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _needBorder = false;

  @override
  void initState() {
    super.initState();
    _needBorder = widget.needBorder;
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: ScannerPainter(_controller,_needBorder),
        size: Size(250, 250),
      ),
    );
  }
}

class ScannerPainter extends CustomPainter {
  final Animation<double> animation;
  final bool needBorder;

  ScannerPainter(this.animation, this.needBorder) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    if(needBorder){
      _drawBorder(canvas,width,height);
    }

    // 绘制扫描线
    final linePaint =
        Paint()
          ..shader = LinearGradient(
            colors: [Colors.transparent, MyColors.primary, Colors.transparent],
            stops: [0.1, 0.5, 0.9],
          ).createShader(Rect.fromLTWH(0, 0, width, 3))
          ..strokeWidth = 3;

    final lineY = height * animation.value;
    canvas.drawLine(Offset(0, lineY), Offset(width, lineY), linePaint);
  }

  void _drawBorder(Canvas canvas,double width,double height) {
    final borderPaint =
    Paint()
      ..color = MyColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // 绘制四角边框
    final cornerLength = 25.0;

    // 左上角
    canvas.drawLine(Offset.zero, Offset(cornerLength, 0), borderPaint);
    canvas.drawLine(Offset.zero, Offset(0, cornerLength), borderPaint);

    // 右上角
    canvas.drawLine(
      Offset(width, 0),
      Offset(width - cornerLength, 0),
      borderPaint,
    );
    canvas.drawLine(Offset(width, 0), Offset(width, cornerLength), borderPaint);

    // 左下角
    canvas.drawLine(
      Offset(0, height),
      Offset(cornerLength, height),
      borderPaint,
    );
    canvas.drawLine(
      Offset(0, height),
      Offset(0, height - cornerLength),
      borderPaint,
    );

    // 右下角
    canvas.drawLine(
      Offset(width, height),
      Offset(width - cornerLength, height),
      borderPaint,
    );
    canvas.drawLine(
      Offset(width, height),
      Offset(width, height - cornerLength),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
