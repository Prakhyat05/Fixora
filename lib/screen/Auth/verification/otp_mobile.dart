import 'package:pinput/pinput.dart';
import 'package:service/export.dart';
import 'package:service/screen/snackBar.dart';
import 'package:service/service/authentication.dart';

class OtpMobile extends StatefulWidget {
  const OtpMobile({super.key});

  @override
  State<OtpMobile> createState() => _OtpMobileState();
}

class _OtpMobileState extends State<OtpMobile> {
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
    final success = await AuthServices().verifyMobileOTP(phone, pinController.text.trim());

    if (!mounted) return;
    setState(() {
      isVerifying = false;
    });

    if (success) {
      Navigator.pushNamed(context, 'otpphoneverified');
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, 'emptystate');
    } else {
      showSnackBar(context, "Invalid OTP code. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/otp/otp_page.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 25),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter the verification code sent to your mobile number",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                showCursor: true,
                controller: pinController,
                onCompleted: (_) => verifyCode(),
              ),
              const SizedBox(height: 20),
              isVerifying
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: MyTextButton(
                        text: "Verify Phone Number",
                        onPressed: verifyCode,
                      ),
                    ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'regphone', (route) => false);
                    },
                    child: const Text(
                      "Edit Phone Number ?",
                      style: TextStyle(color: Colors.black),
                    ),
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
