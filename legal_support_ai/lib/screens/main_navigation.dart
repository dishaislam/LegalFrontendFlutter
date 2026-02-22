import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'chat_screen.dart';
import 'settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    HistoryScreen(),
    ChatScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.bottomNavBackground,
          border: Border(
              top: BorderSide(
                  color: AppColors.divider.withOpacity(0.1), width: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                    0, Icons.home_outlined, Icons.home_rounded, 'HOME'),
                _buildNavItem(
                    1, Icons.history_outlined, Icons.history_rounded, 'HISTORY',
                    hasDot: true),
                _buildNavItem(2, Icons.chat_bubble_outline_rounded,
                    Icons.chat_bubble_rounded, 'CONSULT'),
                _buildNavItem(3, Icons.settings_outlined,
                    Icons.settings_rounded, 'PROFILE'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData outlinedIcon, IconData filledIcon, String label,
      {bool hasDot = false}) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? filledIcon : outlinedIcon,
                  color: isSelected
                      ? AppColors.primaryLight
                      : AppColors.textTertiary,
                  size: 24,
                ),
                if (hasDot && !isSelected)
                  Positioned(
                    right: -1,
                    top: -1,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: isSelected
                    ? AppColors.primaryLight
                    : AppColors.textTertiary,
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
