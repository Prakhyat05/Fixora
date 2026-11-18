import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:service/common/components/my_appbar_back_button.dart';
import 'package:service/common/components/my_desc_text_widget.dart';
import 'package:service/common/components/my_heading_text_widget.dart';
import 'package:service/common/components/my_inkwell_button.dart';
import 'package:service/common/components/my_text_button.dart';
import 'package:service/common/components/my_text_widget.dart';
import 'package:service/common/constants/string.dart';
import 'package:service/screen/snackBar.dart';
import 'package:service/service/authentication.dart';

class OTPEmail extends StatefulWidget {
  const OTPEmail({super.key});

  @override
  State<OTPEmail> createState() => _OTPEmailState();
}

class _OTPEmailState extends State<OTPEmail> {
  final TextEditingController pinController = TextEditingController();
  bool isVerifying = false;

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  void verifyCode() async {
    if (pinController.text.length < 4) {
      showSnackBar(context, "Please enter the complete verification code");
      return;
    }

    setState(() {
      isVerifying = true;
    });

    final success = await AuthServices().submitOTP(pinController.text.trim());

    if (!mounted) return;
    setState(() {
      isVerifying = false;
    });

    if (success) {
      Navigator.pushNamed(context, 'otpemailverified');
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      await Navigator.pushNamed(context, 'profile_step1');
    } else {
      showSnackBar(context, "Invalid OTP. Please check and try again.");
    }
  }

  void resendCode() async {
    final sent = await AuthServices().requestOTP();
    if (!mounted) return;
    if (sent) {
      showSnackBar(context, "A new verification code has been sent!");
    } else {
      showSnackBar(context, "Failed to resend code. Please try later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const MyAppBarBackButton(),
        leadingWidth: 100,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 25,
            left: 25,
            right: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyHeadingTextWidget(text: emailVerification),
                  const SizedBox(height: 10),
                  MyDescTextWidget(text: emailVerificationDesc),
                  const SizedBox(height: 30),

                  // PIN Input
                  Center(
                    child: Pinput(
                      length: 6,
                      showCursor: true,
                      controller: pinController,
                      onCompleted: (_) => verifyCode(),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Verify Button
                  isVerifying
                      ? const Center(child: CircularProgressIndicator())
                      : MyTextButton(
                          text: verify,
                          onPressed: verifyCode,
                        ),
                ],
              ),
              Column(
                children: [
                  const MyTextWidget(text: 'Didn\'t receive code?'),
                  MyInkWellButton(
                    text: 'Resend',
                    onPressed: resendCode,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
