import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final TabsRouter tabsRouter;

  const NavBar({Key? key, required this.tabsRouter}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  _NavBarState();

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.list_outlined),
          icon: Icon(Icons.list),
          label: 'Certificates',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.key_outlined),
          icon: Icon(Icons.key),
          label: 'Keys',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.qr_code_outlined),
          icon: Icon(Icons.qr_code),
          label: 'Verify',
        ),
      ],
      selectedIndex: widget.tabsRouter.activeIndex,
      onDestinationSelected: (int index) {
        setState(() {
          widget.tabsRouter.setActiveIndex(index);
        });
      },
    );
  }
}
