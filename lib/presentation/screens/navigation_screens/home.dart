import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/navigation/routes.gr.dart';

import '../../../domain/authentication/auth_provider.dart';
import '../../navigation/nav_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = AuthProvider();
    return AutoTabsRouter(
      routes: const [
        CertificateListRoute(),
        KeysRoute(),
        ScanCertificateRoute(),
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
                    AutoRouter.of(context).push(const PatientDetailRoute());
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
                    _authProvider.signOut();
                    AutoRouter.of(context).stack.clear();
                    AutoRouter.of(context).push(const AuthenticationRoute());
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
