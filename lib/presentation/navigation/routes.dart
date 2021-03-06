import 'package:auto_route/annotations.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/authentication.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/certificate_list.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/home.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/keys.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/scan_certificate.dart';
import 'package:flutter_app/presentation/screens/other_screens/certificate_detail.dart';
import 'package:flutter_app/presentation/screens/other_screens/create_certificate.dart';
import 'package:flutter_app/presentation/screens/other_screens/onboarding.dart';
import 'package:flutter_app/presentation/screens/other_screens/patient_detail.dart';
import 'package:flutter_app/presentation/screens/other_screens/patient_list.dart';
import 'package:flutter_app/presentation/screens/other_screens/sign_in.dart';
import 'package:flutter_app/presentation/screens/other_screens/sign_up.dart';

import 'auth_guard.dart';

/*
 * run `flutter pub run build_runner build --delete-conflicting-outputs`
 * after making changes
 */
@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      page: Home,
      guards: [AuthGuard],
      initial: true,
      children: [
        AutoRoute(page: CertificateList, guards: [AuthGuard]),
        AutoRoute(page: Keys, guards: [AuthGuard]),
        AutoRoute(page: ScanCertificate),
      ],
    ),
    AutoRoute(page: CertificateDetail),
    AutoRoute(page: CreateCertificate, guards: [AuthGuard]),
    AutoRoute(page: PatientDetail, guards: [AuthGuard]),
    AutoRoute(page: PatientList, guards: [AuthGuard]),
    AutoRoute(page: Authentication),
    AutoRoute(page: SignIn),
    AutoRoute(page: SignUp),
    AutoRoute(page: Onboarding)
  ],
)
class $AppRouter {}
