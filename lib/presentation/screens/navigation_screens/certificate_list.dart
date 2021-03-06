import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/authentication/auth_provider.dart';
import 'package:flutter_app/domain/model/signed_certificate.dart';
import 'package:flutter_app/presentation/components/certificate_item.dart';
import 'package:flutter_app/presentation/navigation/routes.gr.dart';

import '../../../data/repository/repository.dart';

class CertificateList extends StatefulWidget {
  final bool isDoctorList;

  const CertificateList({
    Key? key,
    required this.isDoctorList,
  }) : super(key: key);

  @override
  _CertificateListState createState() => _CertificateListState();
}

class _CertificateListState extends State<CertificateList> {
  final Repository _repository = Repository();
  final AuthProvider _authProvider = AuthProvider();

  List<SignedCertificate> _certificates = [];

  Future buildSignedCertList() async {
    _certificates = widget.isDoctorList
        ? await _repository.getDoctorCertificates()
        : await _repository.getPatientCertificates();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authProvider.isDoctor(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          print(snapshot.data);
          if (!snapshot.data && widget.isDoctorList) {
            print('its ${snapshot.data}');
            return const Center(
              child: Text(
                'You are not a doctor.\nTherefore you are not allowed\nto create vaccination certificates.',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            );
          } else {
            return Scaffold(
              floatingActionButton: widget.isDoctorList
                  ? FloatingActionButton(
                      onPressed: () {
                        AutoRouter.of(context).push(const CreateCertificateRoute());
                      },
                      elevation: 4,
                      focusElevation: 8,
                      hoverElevation: 8,
                      highlightElevation: 8,
                      backgroundColor: const Color(0xff475c6c),
                      child: const Icon(
                        Icons.add,
                        size: 30.0,
                      ),
                    )
                  : null,
              body: FutureBuilder(
                future: buildSignedCertList(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: _certificates.length,
                      itemBuilder: (context, index) {
                        return CertificateItem(
                          signedCertificate: _certificates[index],
                          isDoctorCertificate: widget.isDoctorList,
                        );
                      },
                    );
                  }
                },
              ),
            );
          }
        }
      },
    );
  }
}
