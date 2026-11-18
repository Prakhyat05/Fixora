import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service/screen/onboarding_screen/onboarding_screen.dart';
import 'package:service/service/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenOne extends StatefulWidget {
  final bool onboarding;
  const SplashScreenOne({super.key, this.onboarding = false});

  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {
  @override
  void initState() {
    super.initState();
    _checkInitialRoute();
  }

  Future<void> _checkInitialRoute() async {
    await AuthServices().sync();
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('onboarding') ?? false;

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    if (AuthServices().isSignedIn()) {
      Navigator.pushReplacementNamed(context, 'dashboard');
    } else if (hasSeenOnboarding) {
      Navigator.pushReplacementNamed(context, 'loginemail');
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "RAPSAPP",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 34,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Hyperlocal Service Marketplace",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  textStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
