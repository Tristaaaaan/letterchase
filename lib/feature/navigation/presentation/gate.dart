import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letterchase/common/components/ad/banner_ad.dart';
import 'package:letterchase/common/components/navbar/custom_navbar.dart';
import 'package:letterchase/feature/settings/presentation/settings_screen.dart';
import 'package:letterchase/feature/spawn/presentation/spawn_screen.dart';

class NavigationGate extends ConsumerStatefulWidget {
  const NavigationGate({super.key});

  @override
  ConsumerState<NavigationGate> createState() => _NavigationGateState();
}

class _NavigationGateState extends ConsumerState<NavigationGate> {
  int _selectedIndex = 0;
  final bool _isHolding = false;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _screens => [const SpawnScreen(), const SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const BannerAdWidget(),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            layoutBuilder:
                (currentChild, previousChildren) => Stack(
                  children: [
                    if (currentChild != null) currentChild,
                    ...previousChildren,
                  ],
                ),
            child: _screens[_selectedIndex],
          ),

          // bottom nav bar
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              opacity: _isHolding ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: _isHolding,
                child: CustomBottomNavBar(
                  currentIndex: _selectedIndex,
                  onTap: _onTabSelected,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
