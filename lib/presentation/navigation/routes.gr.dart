// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

import '../../domain/model/signed_certificate.dart' as _i15;
import '../screens/navigation_screens/authentication.dart' as _i6;
import '../screens/navigation_screens/certificate_list.dart' as _i9;
import '../screens/navigation_screens/keys.dart' as _i10;
import '../screens/navigation_screens/scan_certificate.dart' as _i11;
import '../screens/other_screens/certificate_detail.dart' as _i2;
import '../screens/other_screens/create_certificate.dart' as _i3;
import '../screens/other_screens/patient_detail.dart' as _i4;
import '../screens/other_screens/patient_list.dart' as _i5;
import '../screens/other_screens/sign_in.dart' as _i7;
import '../screens/other_screens/sign_up.dart' as _i8;
import 'auth_guard.dart' as _i14;
import 'nav_bar.dart' as _i1;

class AppRouter extends _i12.RootStackRouter {
  AppRouter(
      {_i13.GlobalKey<_i13.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i14.AuthGuard authGuard;

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.Main());
    },
    CertificateDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CertificateDetailRouteArgs>();
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.CertificateDetail(
              key: args.key, signedCertificate: args.signedCertificate));
    },
    CreateCertificateRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.CreateCertificate());
    },
    PatientDetailRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.PatientDetail());
    },
    PatientListRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.PatientList());
    },
    AuthenticationRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.Authentication());
    },
    SignInRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.SignIn());
    },
    SignUpRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.SignUp());
    },
    CertificateListRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.CertificateList());
    },
    KeysRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.Keys());
    },
    ScanCertificateRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.ScanCertificate());
    }
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(MainRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          _i12.RouteConfig(CertificateListRoute.name,
              path: 'certificate-list',
              parent: MainRoute.name,
              guards: [authGuard]),
          _i12.RouteConfig(KeysRoute.name,
              path: 'Keys', parent: MainRoute.name, guards: [authGuard]),
          _i12.RouteConfig(ScanCertificateRoute.name,
              path: 'scan-certificate',
              parent: MainRoute.name,
              guards: [authGuard])
        ]),
        _i12.RouteConfig(CertificateDetailRoute.name,
            path: '/certificate-detail', guards: [authGuard]),
        _i12.RouteConfig(CreateCertificateRoute.name,
            path: '/create-certificate', guards: [authGuard]),
        _i12.RouteConfig(PatientDetailRoute.name,
            path: '/patient-detail', guards: [authGuard]),
        _i12.RouteConfig(PatientListRoute.name,
            path: '/patient-list', guards: [authGuard]),
        _i12.RouteConfig(AuthenticationRoute.name, path: '/Authentication'),
        _i12.RouteConfig(SignInRoute.name, path: '/sign-in'),
        _i12.RouteConfig(SignUpRoute.name, path: '/sign-up')
      ];
}

/// generated route for
/// [_i1.Main]
class MainRoute extends _i12.PageRouteInfo<void> {
  const MainRoute({List<_i12.PageRouteInfo>? children})
      : super(MainRoute.name, path: '/', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.CertificateDetail]
class CertificateDetailRoute
    extends _i12.PageRouteInfo<CertificateDetailRouteArgs> {
  CertificateDetailRoute(
      {_i13.Key? key, required _i15.SignedCertificate signedCertificate})
      : super(CertificateDetailRoute.name,
            path: '/certificate-detail',
            args: CertificateDetailRouteArgs(
                key: key, signedCertificate: signedCertificate));

  static const String name = 'CertificateDetailRoute';
}

class CertificateDetailRouteArgs {
  const CertificateDetailRouteArgs({this.key, required this.signedCertificate});

  final _i13.Key? key;

  final _i15.SignedCertificate signedCertificate;

  @override
  String toString() {
    return 'CertificateDetailRouteArgs{key: $key, signedCertificate: $signedCertificate}';
  }
}

/// generated route for
/// [_i3.CreateCertificate]
class CreateCertificateRoute extends _i12.PageRouteInfo<void> {
  const CreateCertificateRoute()
      : super(CreateCertificateRoute.name, path: '/create-certificate');

  static const String name = 'CreateCertificateRoute';
}

/// generated route for
/// [_i4.PatientDetail]
class PatientDetailRoute extends _i12.PageRouteInfo<void> {
  const PatientDetailRoute()
      : super(PatientDetailRoute.name, path: '/patient-detail');

  static const String name = 'PatientDetailRoute';
}

/// generated route for
/// [_i5.PatientList]
class PatientListRoute extends _i12.PageRouteInfo<void> {
  const PatientListRoute()
      : super(PatientListRoute.name, path: '/patient-list');

  static const String name = 'PatientListRoute';
}

/// generated route for
/// [_i6.Authentication]
class AuthenticationRoute extends _i12.PageRouteInfo<void> {
  const AuthenticationRoute()
      : super(AuthenticationRoute.name, path: '/Authentication');

  static const String name = 'AuthenticationRoute';
}

/// generated route for
/// [_i7.SignIn]
class SignInRoute extends _i12.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/sign-in');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i8.SignUp]
class SignUpRoute extends _i12.PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: '/sign-up');

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i9.CertificateList]
class CertificateListRoute extends _i12.PageRouteInfo<void> {
  const CertificateListRoute()
      : super(CertificateListRoute.name, path: 'certificate-list');

  static const String name = 'CertificateListRoute';
}

/// generated route for
/// [_i10.Keys]
class KeysRoute extends _i12.PageRouteInfo<void> {
  const KeysRoute() : super(KeysRoute.name, path: 'Keys');

  static const String name = 'KeysRoute';
}

/// generated route for
/// [_i11.ScanCertificate]
class ScanCertificateRoute extends _i12.PageRouteInfo<void> {
  const ScanCertificateRoute()
      : super(ScanCertificateRoute.name, path: 'scan-certificate');

  static const String name = 'ScanCertificateRoute';
}
