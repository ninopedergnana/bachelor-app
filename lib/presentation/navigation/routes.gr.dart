// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;

import '../screens/navigation_screens/authentication.dart' as _i6;
import '../screens/navigation_screens/certificate_list.dart' as _i9;
import '../screens/navigation_screens/keys.dart' as _i10;
import '../screens/other_screens/certificate_detail.dart' as _i2;
import '../screens/other_screens/create_certificate.dart' as _i3;
import '../screens/other_screens/patient_detail.dart' as _i4;
import '../screens/other_screens/patient_list.dart' as _i5;
import '../screens/other_screens/sign_in.dart' as _i7;
import '../screens/other_screens/sign_up.dart' as _i8;
import 'auth_guard.dart' as _i13;
import 'nav_bar.dart' as _i1;

class AppRouter extends _i11.RootStackRouter {
  AppRouter(
      {_i12.GlobalKey<_i12.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i13.AuthGuard authGuard;

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.Main());
    },
    CertificateDetailRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CertificateDetail());
    },
    CreateCertificateRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.CreateCertificate());
    },
    PatientDetailRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.PatientDetail());
    },
    PatientListRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.PatientList());
    },
    AuthenticationRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.Authentication());
    },
    SignInRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.SignIn());
    },
    SignUpRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.SignUp());
    },
    CertificateListRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.CertificateList());
    },
    KeysRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.Keys());
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(MainRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          _i11.RouteConfig(CertificateListRoute.name,
              path: 'certificate-list',
              parent: MainRoute.name,
              guards: [authGuard]),
          _i11.RouteConfig(KeysRoute.name,
              path: 'Keys', parent: MainRoute.name, guards: [authGuard])
        ]),
        _i11.RouteConfig(CertificateDetailRoute.name,
            path: '/certificate-detail', guards: [authGuard]),
        _i11.RouteConfig(CreateCertificateRoute.name,
            path: '/create-certificate', guards: [authGuard]),
        _i11.RouteConfig(PatientDetailRoute.name,
            path: '/patient-detail', guards: [authGuard]),
        _i11.RouteConfig(PatientListRoute.name,
            path: '/patient-list', guards: [authGuard]),
        _i11.RouteConfig(AuthenticationRoute.name, path: '/Authentication'),
        _i11.RouteConfig(SignInRoute.name, path: '/sign-in'),
        _i11.RouteConfig(SignUpRoute.name, path: '/sign-up')
      ];
}

/// generated route for
/// [_i1.Main]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute({List<_i11.PageRouteInfo>? children})
      : super(MainRoute.name, path: '/', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.CertificateDetail]
class CertificateDetailRoute extends _i11.PageRouteInfo<void> {
  const CertificateDetailRoute()
      : super(CertificateDetailRoute.name, path: '/certificate-detail');

  static const String name = 'CertificateDetailRoute';
}

/// generated route for
/// [_i3.CreateCertificate]
class CreateCertificateRoute extends _i11.PageRouteInfo<void> {
  const CreateCertificateRoute()
      : super(CreateCertificateRoute.name, path: '/create-certificate');

  static const String name = 'CreateCertificateRoute';
}

/// generated route for
/// [_i4.PatientDetail]
class PatientDetailRoute extends _i11.PageRouteInfo<void> {
  const PatientDetailRoute()
      : super(PatientDetailRoute.name, path: '/patient-detail');

  static const String name = 'PatientDetailRoute';
}

/// generated route for
/// [_i5.PatientList]
class PatientListRoute extends _i11.PageRouteInfo<void> {
  const PatientListRoute()
      : super(PatientListRoute.name, path: '/patient-list');

  static const String name = 'PatientListRoute';
}

/// generated route for
/// [_i6.Authentication]
class AuthenticationRoute extends _i11.PageRouteInfo<void> {
  const AuthenticationRoute()
      : super(AuthenticationRoute.name, path: '/Authentication');

  static const String name = 'AuthenticationRoute';
}

/// generated route for
/// [_i7.SignIn]
class SignInRoute extends _i11.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/sign-in');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i8.SignUp]
class SignUpRoute extends _i11.PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: '/sign-up');

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i9.CertificateList]
class CertificateListRoute extends _i11.PageRouteInfo<void> {
  const CertificateListRoute()
      : super(CertificateListRoute.name, path: 'certificate-list');

  static const String name = 'CertificateListRoute';
}

/// generated route for
/// [_i10.Keys]
class KeysRoute extends _i11.PageRouteInfo<void> {
  const KeysRoute() : super(KeysRoute.name, path: 'Keys');

  static const String name = 'KeysRoute';
}
