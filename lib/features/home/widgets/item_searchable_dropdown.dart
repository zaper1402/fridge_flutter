import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/home/data/data/category_data.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'dart:async';

import 'package:fridge_app/themes/colors.dart';

class ItemSearchableDropdown extends StatefulWidget {
  final TextEditingController searchController;
  final Function(CategoryData) onSelectCategory;
  final Future<List<CategoryData>> Function(String) onSearch;

  const ItemSearchableDropdown({super.key, required this.onSearch,
    required this.onSelectCategory,
   required this.searchController});

  @override
  _ItemSearchableDropdownState createState() => _ItemSearchableDropdownState();
}

class _ItemSearchableDropdownState extends State<ItemSearchableDropdown> {
  late TextEditingController _searchController;
  List<CategoryData> _searchResults = [];
  OverlayEntry? _overlayEntry;
  Timer? _debounce;
  bool isDropdownSelected = false;

  @override
  void initState() {
    super.initState();
    _searchController = widget.searchController;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    // _searchController.dispose();
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
    if(isDropdownSelected){
      isDropdownSelected = false;
      return;
    };
    if (query.isEmpty) {
      _hideDropdown();
      return;
    }

    try {
      final results = await widget.onSearch(query);
      print("search Result $results");
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
        top: MediaQuery.of(context).padding.top +
            kToolbarHeight + scaleH(80), // Adjusted top position
        left: scaleW(40),
        right: scaleW(40),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: scaleH(300),
            child: ListView.separated(
              // Use ListView.separated
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    isDropdownSelected = true;
                    _searchController.text = _searchResults[index].name;
                    widget.onSelectCategory(_searchResults[index]);
                    _hideDropdown();
                  },
                  child: ListTile(
                    title: Text(_searchResults[index].name, style: getTextTheme().defaultText.copyWith(
                      color: textBrownColor
                    ),),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: scaleW(16), vertical: scaleW(4)), // Adjust padding
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: Colors.grey[300]), // Add separator
            ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText("Product",
            style: getTextTheme().defaultText.copyWith(
                color: textBrownColor,
                fontWeight: FontWeight.w500,
                fontSize: scaleW(14))),
        VerticalGap(scaleH(10)),
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Find or add item',
            hintStyle: TextStyle(color: borderColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: borderColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: borderColor)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: borderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: borderColor)),
            contentPadding: EdgeInsets.symmetric(
                horizontal: scaleW(16), vertical: scaleH(12)),
          ),
          onTap: _showDropdown, // Show dropdown when tapping the text field
        ),
      ],
    );
  }
}
