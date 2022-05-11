import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/navigation/auth_guard.dart';
import 'package:flutter_app/presentation/navigation/routes.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _appRouter = AppRouter(authGuard: AuthGuard());
  runApp(
    MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    ),
  );
}
