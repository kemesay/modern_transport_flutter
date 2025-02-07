import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWidget extends StatelessWidget {
  final double height;
  final String logoPath;

  const HeaderWidget({
    super.key,
    required this.height,
    this.logoPath = 'assets/images/OdaaTransportation.svg', // Default path
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      clipper: MyCustomClipper(),
      child: Stack(
        children: [
          // Base road layer
          Container(
            height: height * 0.5, // Reduced height
            color: const Color(0xFF03930A),
          ),

          // Road texture and markings
          CustomPaint(
            size: Size(screenWidth, height * 0.5),
            painter: RoadPainter(),
          ),

          // Highway reflectors
          ...List.generate(4, (index) {
            // Reduced number of reflectors
            return Positioned(
              top: height * 0.18 + (index * 12), // Adjusted positioning
              right: -30 + (index * 35),
              child: Transform.rotate(
                angle: -0.2,
                child: Container(
                  width: 80, // Slightly smaller
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.6),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          // Logo container with white background
          Positioned(
            top: height * 0.08, // Adjusted positioning
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    logoPath,
                    height: height * 0.2, // Reduced logo size
                  ),
                ),
                const SizedBox(height: 8), // Reduced spacing
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Updated RoadPainter for more compact design
class RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3; // Slightly thinner lines

    // Center line
    final dashWidth = 15.0; // Shorter dashes
    final dashSpace = 10.0; // Shorter spaces
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height * 0.45),
        Offset(startX + dashWidth, size.height * 0.45),
        paint,
      );
      startX += dashWidth + dashSpace;
    }

    // Enhanced road shine effect
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.15),
          Colors.white.withOpacity(0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Updated clipper for more subtle curve
class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60); // Reduced curve height

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height - 30,
      size.width * 0.5,
      size.height - 45,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 60,
      size.width,
      size.height - 35,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class NoLogoHeaderWidget extends StatelessWidget {
  final double height;

  const NoLogoHeaderWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        height: height * 0.5,
        color: const Color(0xFF03930A), // As before for non-logo case
      ),
    );
  }
}
