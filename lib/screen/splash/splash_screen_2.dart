import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenTwo extends StatelessWidget {
  const SplashScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Imagery
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/images/plumber/plum.png',
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/images/engineers/woman-engineers.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                ),
              ),
            ],
          ),

          // Dark Overlay
          Container(
            color: Colors.black.withOpacity(0.75),
            height: double.infinity,
            width: double.infinity,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "FIXORA",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 75),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Signup Button
                  TextButton(
                    style: ButtonStyle(
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(300, 65)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0x12121212).withOpacity(1),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.white24),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'regemail');
                    },
                    child: Text(
                      "Signup",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Login Button
                  TextButton(
                    style: ButtonStyle(
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(300, 65)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Colors.white,
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'loginemail');
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        textStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
