import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:live_score_application/screens/home/view/home_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:live_score_application/screens/profile/view/profile_screen.dart';
import 'package:live_score_application/screens/reels/view/reel_screen.dart';
import 'package:live_score_application/widgets/schedule_match.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  bool _showBottomNav = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_showBottomNav) {
        setState(() {
          _showBottomNav = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_showBottomNav) {
        setState(() {
          _showBottomNav = true;
        });
      }
    }
  }

  Widget buildIcon(IconData icon, bool isSelected, {double size = 30}) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 90,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.grey),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(scrollController: _scrollController),
      ScheduleMatch(scrollController: _scrollController),
      ReelScreen(scrollController: _scrollController),
      ProfileScreen(scrollController: _scrollController),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: screens[selectedIndex],
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _showBottomNav ? 64 : 0,
        child: Wrap(
          children: [
            Container(
              color: Colors.grey.shade800,
              height: 80,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => selectedIndex = 0),
                    child: buildIcon(Iconsax.home, selectedIndex == 0, size: 35),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => selectedIndex = 1),
                    child: buildIcon(Iconsax.calendar, selectedIndex == 1, size: 35),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => selectedIndex = 2),
                    child: buildIcon(Iconsax.video, selectedIndex == 2, size: 35),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => selectedIndex = 3),
                    child: buildIcon(Iconsax.user, selectedIndex == 3, size: 35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
