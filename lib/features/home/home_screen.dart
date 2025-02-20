import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/features/favorites/favorites_screen.dart';
import 'package:fridge_app/features/home/data/home_controller.dart';
import 'package:fridge_app/features/home/widgets/bottom_nav_bar_widget.dart';
import 'package:fridge_app/features/home/widgets/category_grid.dart';
import 'package:fridge_app/features/home/widgets/floating_action_button.dart';
import 'package:fridge_app/features/home/widgets/home_widget.dart';
import 'package:fridge_app/features/notifications/notifications_screen.dart';
import 'package:fridge_app/features/profile/profile_screen.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:get/get.dart';

// Import your reusable widgets here
// e.g., import 'search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.put(HomeController());
  }

  int _selectedIndex = 0;

  // Define your screens
  static const List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    FavoriteScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: _selectedIndex == 0
          ? AddIngredientButton(
              onPressed: () {
                AppRouting().routeTo(NameRoutes.addItemScreen);
              },
            )
          : null,
      floatingActionButtonLocation:
          _selectedIndex == 0 ? FloatingActionButtonLocation.endFloat : null,
      bottomNavigationBar: BottomNavBar(
        onTap: _onItemTapped,
      ),
    );
  }
}
