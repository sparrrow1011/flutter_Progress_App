import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viswal/provider/progess.dart';

class CircularProgressBar extends StatelessWidget {
  const CircularProgressBar({super.key});
  @override
  Widget build(BuildContext context) {
    final progressExpose = Provider.of<ProgressProvider>(context, listen: false);
    final progress = context.watch<ProgressProvider>().progress;
    
    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: Stack(
        children:[
          Center(
            child: CustomPaint(
              painter: ProgressPainter(progress: progress),
              child: SizedBox(
                width: 150.0,
                height: 150.0,
                child: Stack(
                    children:[
                      Center(
                        child: CustomPaint(
                          painter: BlueCustomPaint(progress: .80),
                          child: const SizedBox(
                            width: 120.0,
                            height: 120.0,
                          ),
                        ),
                      ),
                      Center(
                        child: Consumer<ProgressProvider>(builder: (context, data, child){
                          print(data.progress);
                          return Text('${data.progress*100.round()}%',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.normal,
                            ),
                          );
                        }),
                        ),
                    ]
                ),
              ),
            ),
          ),
          Positioned(
            // top: 60,
            // left: 20,
            top: (progress < 0 ? 60.0 : progress == 0.33 ? 180.0 : progress == 0.66 ? 60: 60) ,
            left:(progress < 0 ? 170.0 : progress == 0.33 ? 95.0 : progress == 0.66 ? 20: 170),
            child: Container(
              constraints: const BoxConstraints(
                  minHeight: 10,
                  minWidth: 10
              ),
              decoration: BoxDecoration(
                color: (progress == 1 ? const Color(0x00F864C5): const Color(0xffF864C5)) ,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ]
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  double progress;

  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2) - paint.strokeWidth / 2;

    // Draw first step progress
    double progress1 = math.min(0.33, progress);
    Paint background1 = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.square;
    if (progress1 > 0) {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2 + 0 * 2 * math.pi + 0 * 2 * math.pi + 0.04,
          0 * 2 * math.pi - math.pi / 180 * 5 - 0.08 ,
          false,
          background1);
    } else {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2 + 0 * 2 * math.pi + math.pi / 180 * 5,
          0 * 2 * math.pi - math.pi / 180 * 10,
          false,
          background1);
    }
    Paint paint1 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.square
      ..shader = LinearGradient(
        colors: [Colors.red, Colors.red],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        progress1 * 2 * math.pi - math.pi / 180 * 5,
        false,
        paint1);


// Draw second step progress
    // Draw second step background
    double progress2 = math.max(math.min(progress - 0.33, 0.33), 0);
    Paint background2 = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.square;
    if (progress2 > 0) {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2 + progress1 * 2 * math.pi + math.pi / 180 * 5,
          progress2 * 2 * math.pi - math.pi / 180 * 10,
          false,
          background2);
    } else {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2 + 0.33 * 2 * math.pi + math.pi / 180 * 5,
          0.33 * 2 * math.pi - math.pi / 180 * 10,
          false,
          background2);
    }

    // Draw second step progress
    Paint paint2 = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.square
      ..shader = LinearGradient(
        colors: [Colors.orange, Colors.orange],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + progress1 * 2 * math.pi + math.pi / 180 * 5,
        progress2 * 2 * math.pi - math.pi / 180 * 5,
        false,
        paint2);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + 0.33 * 2 * math.pi + math.pi / 180 * 5,
        0.33 * 2 * math.pi - math.pi / 180 * 10,
        false,
        background2);

// Draw third step progress
    double progress3 = math.max(progress - 0.66, 0);
    Paint background3 = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.square;

    if (progress3 > 0) {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2 + progress1 * 2 * math.pi + progress2 * 2 * math.pi + 0.04,
          progress3 * 2 * math.pi - math.pi / 180 * 5 - 0.08 ,
          false,
          background3);
    } else {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2 + progress1 * 2 * math.pi + progress2 * 2 * math.pi + math.pi / 180 * 5,
          progress3 * 2 * math.pi - math.pi / 180 * 10,
          false,
          background3);
    }
    Paint paint3 = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.square
      ..shader = LinearGradient(
        colors: [Colors.yellow, Colors.yellow],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + progress1 * 2 * math.pi + progress2 * 2 *  math.pi + math.pi / 180 * 5,
        progress3 * 2 * math.pi - math.pi / 180 * 10,
        false,
        paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class BlueCustomPaint extends CustomPainter {
  final double progress;

  BlueCustomPaint({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..color = Color(0xff333945)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        colors: [Color(0xff1772c5), Color(0xff1772c5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2));

    double radius = size.width / 2;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + math.pi * 2 * 0.95,
        math.pi * 2 ,
        false,
        backgroundPaint);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        math.pi * 2 * math.min(progress, 0.95),
        false,
        progressPaint);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
