import 'package:auto_route/auto_route.dart';

import './routes.gr.dart';
import '../../domain/authentication/key_storage.dart';

class AuthGuard extends AutoRouteGuard {
  final KeyStorage _keyStorage = KeyStorage();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool authenticated = await _keyStorage.isSignedIn();

    if (authenticated) {
      resolver.next(true);
    } else {
      router.replace(const AuthenticationRoute());
      resolver.next(false);
    }
  }
}
