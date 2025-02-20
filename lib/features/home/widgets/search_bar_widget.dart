import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey), // Hint text color
          prefixIcon: Icon(Icons.search, color: Colors.grey), // Search icon color
          filled: true, // Enable filling
          fillColor: Colors.grey[200], // Fill color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
            borderSide: BorderSide.none, // Remove border
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Adjust padding
        ),
      ),
    );
  }
}