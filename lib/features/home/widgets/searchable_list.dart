import 'package:flutter/material.dart';
import 'dart:async';

class SearchableDropdown extends StatefulWidget {
  final Future<List<String>> Function(String) onSearch;

  const SearchableDropdown({required this.onSearch});

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  OverlayEntry? _overlayEntry;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _performSearch(_searchController.text);
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      _hideDropdown();
      return;
    }

    try {
      final results = await widget.onSearch(query);
      setState(() {
        _searchResults = results;
      });
      _showDropdown();
    } catch (e) {
      print('Error during search: $e');
      setState(() {
        _searchResults = [];
      });
      _hideDropdown();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred during search')),
      );
    }
  }

  void _showDropdown() {
    _overlayEntry?.remove();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + kToolbarHeight, // Adjusted top position
        left: 16,
        right: 16,
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(10),
          child: ListView.separated( // Use ListView.separated
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  _searchController.text = _searchResults[index];
                  _hideDropdown();
                },
                child: ListTile(
                  title: Text(_searchResults[index]),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjust padding
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[300]), // Add separator
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _searchResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Find or add item',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        onTap: _showDropdown, // Show dropdown when tapping the text field
      ),
    );
  }
}