import 'package:auto_route/auto_route.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './routes.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool authenticated = await _secureStorage.containsKey(key: 'PGP_PRIVATE_KEY');

    if (authenticated) {
      resolver.next(true);
    } else {
      router.replace(const AuthenticationRoute());
      resolver.next(false);
    }
  }
}
