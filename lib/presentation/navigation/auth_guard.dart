import 'package:auto_route/auto_route.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './routes.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool authenticated = await _secureStorage.containsKey(key: 'pgpPrivateKey');
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (!authenticated) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.replace(const AuthenticationRoute());
      resolver.next(false);
    }
  }
}
