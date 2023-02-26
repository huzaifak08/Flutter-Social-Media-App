import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/profile_screen.dart';
import 'package:tech_media/view_model/Provider/login_logout_providers.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // persistant controller:

  final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreen() {
    return [
      Center(child: Text('Home')),
      Center(child: Text('Chat')),
      Center(child: Text('Add')),
      Center(child: Text('Message')),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(Icons.home, color: Colors.grey.shade100)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.chat),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(Icons.chat, color: Colors.grey.shade100)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.add),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(Icons.add, color: Colors.grey.shade100)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.chat),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(Icons.chat, color: Colors.grey.shade100)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.account_circle),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon:
              Icon(Icons.account_circle, color: Colors.grey.shade100)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');

    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreen(),
      items: _navBarItem(),
      backgroundColor: AppColors.otpHintColor,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(1),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
