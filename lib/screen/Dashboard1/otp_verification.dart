import 'package:service/export.dart';
import 'package:service/screen/snackBar.dart';
import 'package:service/service/authentication.dart';
import 'package:service/service/globals.dart';

class ServiceOtpVerification extends StatefulWidget {
  final String? descText;
  final String? whereToGo;

  const ServiceOtpVerification({super.key, this.descText, this.whereToGo});

  @override
  State<ServiceOtpVerification> createState() => _ServiceOtpVerificationState();
}

class _ServiceOtpVerificationState extends State<ServiceOtpVerification> {
  String otp = "0000";
  bool isVerifying = false;

  void verifyOtp() async {
    setState(() {
      isVerifying = true;
    });

    final email = AuthServices.currentEmail ?? Globals.demoEmail;
    final success = await AuthServices().checkOTP(email, otp);

    if (!mounted) return;
    setState(() {
      isVerifying = false;
    });

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Step6(
            imagelocation: verificationImage,
            text: 'Verified',
            whereToGo: widget.whereToGo ?? 'startingService',
          ),
        ),
      );
    } else {
      showSnackBar(context, "Invalid OTP code. Please try again.");
    }
  }

  void resendOtp() async {
    final email = AuthServices.currentEmail ?? Globals.demoEmail;
    await AuthServices().requestOTP(email);
    if (!mounted) return;
    showSnackBar(context, "Verification code sent!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyAppBarBackButton(),
        leadingWidth: 100,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
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
                  MyDescTextWidget(
                    text: widget.descText ??
                        'Enter the verification code to verify service.',
                  ),
                  const SizedBox(height: 20),
                  // boxes to put otp
                  Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<SizedBox>.generate(
                        4,
                        (i) => otpDigit(context, (int x) {
                          setState(() {
                            otp = otp.replaceRange(i, i + 1, "$x");
                          });
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  isVerifying
                      ? const Center(child: CircularProgressIndicator())
                      : MyTextButton(
                          text: 'Verify',
                          onPressed: verifyOtp,
                        ),
                ],
              ),
              Column(
                children: [
                  const MyTextWidget(
                    text: 'Didn\'t receive code?',
                    align: TextAlign.center,
                  ),
                  MyInkWellButton(
                    text: 'Resend',
                    onPressed: resendOtp,
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

SizedBox otpDigit(BuildContext context, Function(int) onChange) {
  return SizedBox(
    height: 68,
    width: 64,
    child: TextFormField(
      onChanged: (value) {
        if (value.length == 1) {
          onChange(int.tryParse(value) ?? 0);
          FocusScope.of(context).nextFocus();
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
  );
}
