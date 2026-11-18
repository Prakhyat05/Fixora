import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:service/common/components/my_appbar_back_button.dart';
import 'package:service/common/components/my_desc_text_widget.dart';
import 'package:service/common/components/my_heading_text_widget.dart';
import 'package:service/common/components/my_inkwell_button.dart';
import 'package:service/common/components/my_text_button.dart';
import 'package:service/common/components/my_text_widget.dart';
import 'package:service/screen/Auth/Register/RegisterWithMobileNumber/register_with_mobile_number.dart';
import 'package:service/screen/snackBar.dart';
import 'package:service/service/authentication.dart';

class OTPPhone extends StatefulWidget {
  const OTPPhone({super.key});

  @override
  State<OTPPhone> createState() => _OTPPhoneState();
}

class _OTPPhoneState extends State<OTPPhone> {
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

    final phone = RegisterWithMobileNumber.phoneSend;
    final success =
        await AuthServices().verifyMobileOTP(phone, pinController.text.trim());

    if (!mounted) return;
    setState(() {
      isVerifying = false;
    });

    if (success) {
      Navigator.pushNamed(context, 'otpphoneverified');
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushNamed(context, 'emptystate');
    } else {
      showSnackBar(context, "Invalid OTP code. Please try again.");
    }
  }

  void resendCode() async {
    final phone = RegisterWithMobileNumber.phoneSend;
    final sent = await AuthServices().requestMobileOTP(phone);
    if (!mounted) return;
    if (sent) {
      showSnackBar(context, "A new OTP code has been sent!");
    } else {
      showSnackBar(context, "Failed to resend OTP. Please try again later.");
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
                  const MyHeadingTextWidget(text: 'OTP Verification'),
                  const SizedBox(height: 10),
                  const MyDescTextWidget(
                    text:
                        'Enter the verification code we just sent to your phone number.',
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: Pinput(
                      length: 6,
                      showCursor: true,
                      controller: pinController,
                      onCompleted: (_) => verifyCode(),
                    ),
                  ),
                  const SizedBox(height: 25),
                  isVerifying
                      ? const Center(child: CircularProgressIndicator())
                      : MyTextButton(
                          text: 'Verify',
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
