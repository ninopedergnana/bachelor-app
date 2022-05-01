import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/navigation/auth_guard.dart';
import 'package:flutter_app/presentation/navigation/routes.gr.dart';
import 'package:provider/provider.dart';

import 'domain/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _appRouter = AppRouter(authGuard: AuthGuard());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    ),
  );
}
