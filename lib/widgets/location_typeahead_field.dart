import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:modern_transportation/model/place_model.dart';
import 'dart:async';

class LocationTypeAheadField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final Color iconColor;
  final Function(PlaceDetail) onPlaceSelected;
  final Future<List<PlaceDetail>> Function(String) onSuggestions;

  const LocationTypeAheadField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.iconColor,
    required this.onPlaceSelected,
    required this.onSuggestions,
  });

  @override
  State<LocationTypeAheadField> createState() => _LocationTypeAheadFieldState();
}

class _LocationTypeAheadFieldState extends State<LocationTypeAheadField> {
  Timer? _debounce;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<List<PlaceDetail>> _debouncedSuggestions(String pattern) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final suggestions = await widget.onSuggestions(pattern);
        setState(() {
          _isLoading = false;
        });
        suggestions;
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error fetching locations. Please try again.';
        });
        return;
      }
    });

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          if (_isLoading)
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: TypeAheadField<PlaceDetail>(
        direction: VerticalDirection.up,
        debounceDuration: const Duration(milliseconds: 500),
        // textFieldConfiguration: TextFieldConfiguration(
        //   controller: widget.controller,
        //   style: const TextStyle(
        //     fontSize: 12,
        //     fontWeight: FontWeight.w400,
        //   ),
        //   decoration: InputDecoration(
        //     filled: true,
        //     fillColor: Colors.grey[50],
        //     icon: Icon(
        //       widget.icon,
        //       color: widget.iconColor,
        //       size: 20,
        //     ),
        //     suffixIcon: widget.controller.text.isNotEmpty
        //         ? IconButton(
        //             icon: const Icon(Icons.close, size: 15),
        //             onPressed: widget.controller.clear,
        //             color: Colors.grey[400],
        //           )
        //         : null,
        //     labelText: widget.labelText,
        //     labelStyle: TextStyle(color: Colors.grey[600]),
        //     enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(8),
        //       borderSide: BorderSide(color: Colors.grey[300]!),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(8),
        //       borderSide: BorderSide(color: widget.iconColor),
        //     ),
        //     contentPadding: const EdgeInsets.symmetric(
        //       horizontal: 12,
        //       vertical: 8,
        //     ),
        //   ),
        // ),
        suggestionsCallback: _debouncedSuggestions,
        itemBuilder: (context, dynamic suggestion) {
          return ListTile(
            title: Text(
              suggestion.description as String,
              style: const TextStyle(fontSize: 12),
            ),
          );
        },
        onSelected: (dynamic suggestion) async {
          widget.controller.text = suggestion.description;
          // TODO: Implement getPlaceDetail method or inject as dependency
          // final placeDetail = await getPlaceDetail(suggestion);
          widget
              .onPlaceSelected(suggestion); // Pass suggestion directly for now
        },
        // suggestionsBoxDecoration: const SuggestionsBoxDecoration(
        //   constraints: BoxConstraints(maxHeight: 200),
        // ),
        loadingBuilder: (context) => const Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
        animationDuration: const Duration(milliseconds: 300),
        transitionBuilder: (context, suggestionsBox, controller) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: suggestionsBox as Widget,
          );
        },
      ),
    );
  }
}

class SuggestionsBoxDecoration {
  const SuggestionsBoxDecoration({required BoxConstraints constraints});
}
