import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/presentation/components/indicator.dart';
import 'package:flutter_app/presentation/components/onboarding_screen.dart';
import 'package:flutter_app/presentation/screens/other_screens/sign_up.dart';
import '../../navigation/routes.gr.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _numberPages = 3;
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> wList = [];
    for (int i = 0; i < _numberPages; i++) {
      wList.add(i == _currentPage
          ? const Indicator(
              isActive: true,
            )
          : const Indicator(isActive: false));
    }
    return wList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                  0.3,
                  0.7,
                ],
                    colors: [
                  Color(0xFFf7efd2),
                  Color(0xFFeed7a1),
                ])),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        AutoRouter.of(context)
                            .push(const HomeRoute());
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        136, // padding, don't ask xD
                    width: MediaQuery.of(context).size.width,
                    child: PageView(
                      physics: const ClampingScrollPhysics(),
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      controller: _pageController,
                      children: <Widget>[
                        const OnboardingScreen(
                            imageURLString: 'assets/images/onboarding0.png',
                            title: "Welcome To Impfy",
                            content:
                                "A not so truly decentralized vaccine passport"),
                        const OnboardingScreen(
                            imageURLString: 'assets/images/onboarding1.png',
                            title: "Ethereum, IPFS and OpenPGP Encryption",
                            content:
                                "We store your data with 256-Bit Encryption on the Ethereum Blockchain, forever!"),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              const SizedBox(height: 270, child: SignUpForm()),
                              const Text(
                                "Already have an account?\nSign in by scanning your User Key QR Code",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  height: 1.5,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          primary: const Color(0xff475c6c)
                                      ),
                                      onPressed: () {
                                        AutoRouter.of(context)
                                            .push(const SignInRoute());
                                      },
                                      child: const Text(
                                        "Sign in",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
