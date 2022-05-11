// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;

import '../../domain/model/signed_certificate.dart' as _i16;
import '../screens/navigation_screens/authentication.dart' as _i6;
import '../screens/navigation_screens/certificate_list.dart' as _i10;
import '../screens/navigation_screens/home.dart' as _i1;
import '../screens/navigation_screens/keys.dart' as _i11;
import '../screens/navigation_screens/scan_certificate.dart' as _i12;
import '../screens/other_screens/certificate_detail.dart' as _i2;
import '../screens/other_screens/create_certificate.dart' as _i3;
import '../screens/other_screens/onboarding.dart' as _i9;
import '../screens/other_screens/patient_detail.dart' as _i4;
import '../screens/other_screens/patient_list.dart' as _i5;
import '../screens/other_screens/sign_in.dart' as _i7;
import '../screens/other_screens/sign_up.dart' as _i8;
import 'auth_guard.dart' as _i15;

class AppRouter extends _i13.RootStackRouter {
  AppRouter(
      {_i14.GlobalKey<_i14.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i15.AuthGuard authGuard;

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.Home());
    },
    CertificateDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CertificateDetailRouteArgs>();
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.CertificateDetail(
              key: args.key, signedCertificate: args.signedCertificate));
    },
    CreateCertificateRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.CreateCertificate());
    },
    PatientDetailRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.PatientDetail());
    },
    PatientListRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.PatientList());
    },
    AuthenticationRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.Authentication());
    },
    SignInRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.SignIn());
    },
    SignUpRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.SignUp());
    },
    OnboardingRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.Onboarding());
    },
    CertificateListRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.CertificateList());
    },
    KeysRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.Keys());
    },
    ScanCertificateRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.ScanCertificate());
    }
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(HomeRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          _i13.RouteConfig(CertificateListRoute.name,
              path: 'certificate-list',
              parent: HomeRoute.name,
              guards: [authGuard]),
          _i13.RouteConfig(KeysRoute.name,
              path: 'Keys', parent: HomeRoute.name, guards: [authGuard]),
          _i13.RouteConfig(ScanCertificateRoute.name,
              path: 'scan-certificate',
              parent: HomeRoute.name,
              guards: [authGuard])
        ]),
        _i13.RouteConfig(CertificateDetailRoute.name,
            path: '/certificate-detail', guards: [authGuard]),
        _i13.RouteConfig(CreateCertificateRoute.name,
            path: '/create-certificate', guards: [authGuard]),
        _i13.RouteConfig(PatientDetailRoute.name,
            path: '/patient-detail', guards: [authGuard]),
        _i13.RouteConfig(PatientListRoute.name,
            path: '/patient-list', guards: [authGuard]),
        _i13.RouteConfig(AuthenticationRoute.name, path: '/Authentication'),
        _i13.RouteConfig(SignInRoute.name, path: '/sign-in'),
        _i13.RouteConfig(SignUpRoute.name, path: '/sign-up'),
        _i13.RouteConfig(OnboardingRoute.name, path: '/Onboarding')
      ];
}

/// generated route for
/// [_i1.Home]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.CertificateDetail]
class CertificateDetailRoute
    extends _i13.PageRouteInfo<CertificateDetailRouteArgs> {
  CertificateDetailRoute(
      {_i14.Key? key, required _i16.SignedCertificate signedCertificate})
      : super(CertificateDetailRoute.name,
            path: '/certificate-detail',
            args: CertificateDetailRouteArgs(
                key: key, signedCertificate: signedCertificate));

  static const String name = 'CertificateDetailRoute';
}

class CertificateDetailRouteArgs {
  const CertificateDetailRouteArgs({this.key, required this.signedCertificate});

  final _i14.Key? key;

  final _i16.SignedCertificate signedCertificate;

  @override
  String toString() {
    return 'CertificateDetailRouteArgs{key: $key, signedCertificate: $signedCertificate}';
  }
}

/// generated route for
/// [_i3.CreateCertificate]
class CreateCertificateRoute extends _i13.PageRouteInfo<void> {
  const CreateCertificateRoute()
      : super(CreateCertificateRoute.name, path: '/create-certificate');

  static const String name = 'CreateCertificateRoute';
}

/// generated route for
/// [_i4.PatientDetail]
class PatientDetailRoute extends _i13.PageRouteInfo<void> {
  const PatientDetailRoute()
      : super(PatientDetailRoute.name, path: '/patient-detail');

  static const String name = 'PatientDetailRoute';
}

/// generated route for
/// [_i5.PatientList]
class PatientListRoute extends _i13.PageRouteInfo<void> {
  const PatientListRoute()
      : super(PatientListRoute.name, path: '/patient-list');

  static const String name = 'PatientListRoute';
}

/// generated route for
/// [_i6.Authentication]
class AuthenticationRoute extends _i13.PageRouteInfo<void> {
  const AuthenticationRoute()
      : super(AuthenticationRoute.name, path: '/Authentication');

  static const String name = 'AuthenticationRoute';
}

/// generated route for
/// [_i7.SignIn]
class SignInRoute extends _i13.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/sign-in');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i8.SignUp]
class SignUpRoute extends _i13.PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: '/sign-up');

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i9.Onboarding]
class OnboardingRoute extends _i13.PageRouteInfo<void> {
  const OnboardingRoute() : super(OnboardingRoute.name, path: '/Onboarding');

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [_i10.CertificateList]
class CertificateListRoute extends _i13.PageRouteInfo<void> {
  const CertificateListRoute()
      : super(CertificateListRoute.name, path: 'certificate-list');

  static const String name = 'CertificateListRoute';
}

/// generated route for
/// [_i11.Keys]
class KeysRoute extends _i13.PageRouteInfo<void> {
  const KeysRoute() : super(KeysRoute.name, path: 'Keys');

  static const String name = 'KeysRoute';
}

/// generated route for
/// [_i12.ScanCertificate]
class ScanCertificateRoute extends _i13.PageRouteInfo<void> {
  const ScanCertificateRoute()
      : super(ScanCertificateRoute.name, path: 'scan-certificate');

  static const String name = 'ScanCertificateRoute';
}
