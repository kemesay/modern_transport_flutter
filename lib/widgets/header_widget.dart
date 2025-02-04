import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final double height;

  const HeaderWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Stack(
        children: [
          // Road background
          Container(
            height: height,
            // color: const Color.fromRGBO(3, 167, 61, 1), // Green road color
            color: const Color(0xFF03930A), // Green road color

          ),
          // First black section
          Positioned(
            top: height / 2 - 120, // Adjust this for line placement
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              color: Colors.black, // First black section
            ),
          ),
          // // White center line (road divider)
          // Positioned(
          //   top: height / 2 - 80, // Adjust this for line placement
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: 5,
          //     color: Colors.white, // White center line
          //   ),
          // ),
          // // Second black section
          // Positioned(
          //   top: height / 2 - 75, // Adjust this for line placement
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: 40,
          //     color: Colors.black, // Second black section
          //   ),
          // ),
          // // Logo in the center of the road
          // Positioned(
          //   top: height / 2 - 122, // Adjust to center the logo
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: SizedBox(
          //       width: 200,
          //       child: Image.asset(
          //         Constatnts.logo,
          //         height: 89,
          //       ),
          //     ),
          //   ),
          // ),
          // // Text below the second black section

          Image.asset('assets/images/image15.png'),
          const SizedBox(height: 50),
          Positioned(
            top: height / 2 +30, // Positioning text below the second black section
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                'Oda Transportation',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 24, // Text size
                  fontWeight: FontWeight.bold, // Text weight
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoLogoHeaderWidget extends StatelessWidget {
  final double height;

  const NoLogoHeaderWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        height: height,
        color: const Color(0xFF03930A), // As before for non-logo case
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 150);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 150);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
