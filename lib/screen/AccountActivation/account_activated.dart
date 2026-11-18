import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service/common/components/my_text_button.dart';

class AccountActivated extends StatefulWidget {
  const AccountActivated({super.key});

  @override
  State<AccountActivated> createState() => _AccountActivatedState();
}

class _AccountActivatedState extends State<AccountActivated> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, 'dashboard', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/accountactivation/Successmark.png',
                  width: 140,
                  height: 140,
                ),
                const SizedBox(height: 25),
                Text(
                  'Account Activated Successfully!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    textStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your profile is verified. You can now start receiving customer service requests.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: 250,
                  child: MyTextButton(
                    text: 'Go to Dashboard',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'dashboard',
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
