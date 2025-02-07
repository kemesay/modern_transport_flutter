import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PopularPlacesCarousel extends StatefulWidget {
  const PopularPlacesCarousel({super.key});

  @override
  State<PopularPlacesCarousel> createState() => _PopularPlacesCarouselState();
}

class _PopularPlacesCarouselState extends State<PopularPlacesCarousel> {
  List<PopularPlace> _popularPlaces = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPopularPlaces();
  }

  Future<void> _fetchPopularPlaces() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.odatransportation.com/api/v1/popular-places'),
        headers: {
          'Authorization':
              'Bearer YOUR_AUTH_TOKEN', // Add your auth header here
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _popularPlaces =
              data.map((place) => PopularPlace.fromJson(place)).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching popular places: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: screenHeight *
                0.22, // Reduced from 0.35 to 0.22 for more compact view
            viewportFraction: 0.93, // Slightly adjusted for better spacing
            enlargeCenterPage: true, // Added for subtle depth
            enlargeFactor: 0.15, // Subtle zoom effect
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          items: _popularPlaces.map((place) {
            return SlideItem(
              place: place,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            );
          }).toList(),
        ),
        const SizedBox(height: 4), // Reduced spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _popularPlaces.asMap().entries.map((entry) {
            return Container(
              width: 6.0, // Reduced from 8.0 to 6.0
              height: 6.0, // Reduced from 8.0 to 6.0
              margin: const EdgeInsets.symmetric(
                  horizontal: 3.0), // Reduced from 4.0 to 3.0
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(
                  _currentIndex == entry.key ? 0.9 : 0.4,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SlideItem extends StatelessWidget {
  final PopularPlace place;
  final double screenWidth;
  final double screenHeight;

  const SlideItem({
    super.key,
    required this.place,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(place.image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12), // Added rounded corners
      ),
      margin:
          const EdgeInsets.symmetric(horizontal: 8), // Added horizontal margin
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.65),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01, // Reduced padding
              horizontal: screenWidth * 0.025,
            ),
            child: Column(
              children: [
                Text(
                  place.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _getResponsiveFontSize(
                        screenWidth, 15), // Adjusted base size
                    fontWeight: FontWeight.w500,
                    height: 1.1, // Tighter line height
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenHeight * 0.003), // Reduced spacing
                Text(
                  place.description,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: _getResponsiveFontSize(
                        screenWidth, 12), // Adjusted base size
                    fontWeight: FontWeight.w300,
                    height: 1.1, // Tighter line height
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1, // Reduced to 1 line for more compact view
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for responsive font sizing
  double _getResponsiveFontSize(double screenWidth, double baseSize) {
    // Calculate font size based on screen width
    // For smaller screens, reduce the font size proportionally
    if (screenWidth < 360) {
      return baseSize * 0.8;
    } else if (screenWidth < 400) {
      return baseSize * 0.9;
    } else {
      return baseSize;
    }
  }
}

class PopularPlace {
  final String image;
  final String title;
  final String description;

  PopularPlace({
    required this.image,
    required this.title,
    required this.description,
  });

  factory PopularPlace.fromJson(Map<String, dynamic> json) {
    return PopularPlace(
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
