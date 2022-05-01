import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/navigation/routes.gr.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        CertificateListRoute(),
        KeysRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.blueGrey),
            backgroundColor: Colors.white10,
            elevation: 0,
            centerTitle: true, // todo make title dynamic
          ),
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
          bottomNavigationBar: NavBar(tabsRouter: tabsRouter),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                  child: Text(
                      'Welcome to the Impfy!\n\nLeave while you still can'),
                ),
                ListTile(
                  title: const Text('Patients'),
                  onTap: () {
                    Navigator.pushNamed(context, '/patients/patient');
                  },
                ),
                ListTile(
                  title: const Text('Settings'),
                  onTap: () {
                    // Navigator.pop(context); should lead to a settings page
                  },
                ),
                ListTile(
                  title: const Text('Sign Out'),
                  onTap: () {
                    Navigator.pushNamed(context, '/auth');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
        // NavigationDestination(
        //   selectedIcon: Icon(Icons.qr_code_outlined),
        //   icon: Icon(Icons.qr_code),
        //   label: 'Verify',
        // ),
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
