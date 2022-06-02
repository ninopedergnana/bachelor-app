import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/navigation/routes.gr.dart';
import 'package:flutter_app/presentation/screens/other_screens/onboarding.dart';

import '../../../domain/authentication/auth_provider.dart';
import '../../navigation/nav_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = AuthProvider();
    return AutoTabsRouter(
      routes: [
        CertificateListRoute(isDoctorList: false),
        CertificateListRoute(isDoctorList: true),
        const KeysRoute(),
        const ScanCertificateRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Color(0xff475c6c)),
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
                    color: Color(0xfff7efd2),
                  ),
                  child: Text('Welcome to the Impfy!\n\nEnjoy your stay'),
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
                    AutoRouter.of(context).push(const OnboardingRoute());
                  },
                ),
                ListTile(
                  title: const Text('Sign Out'),
                  onTap: () {
                    _authProvider.signOut();
                    AutoRouter.of(context).replaceAll(
                      [const OnboardingRoute()],
                    );
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
