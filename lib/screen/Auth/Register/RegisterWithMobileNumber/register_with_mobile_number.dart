import 'package:service/export.dart';
import 'package:service/service/authentication.dart';

final _formKey = GlobalKey<FormState>();

class RegisterWithMobileNumber extends StatefulWidget {
  const RegisterWithMobileNumber({super.key});

  static String verify = "";
  static String nameSend = "";
  static String phoneSend = "";

  @override
  State<RegisterWithMobileNumber> createState() =>
      _RegisterWithMobileNumberState();
}

class _RegisterWithMobileNumberState extends State<RegisterWithMobileNumber> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countrycode = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    countrycode.dispose();
    super.dispose();
  }

  void sendMobileOTP() async {
    setState(() {
      isLoading = true;
    });

    final fullPhone = "${countrycode.text.trim()}${phoneController.text.trim()}";
    RegisterWithMobileNumber.phoneSend = fullPhone;
    RegisterWithMobileNumber.nameSend = nameController.text.trim();

    final sent = await AuthServices().requestMobileOTP(fullPhone);

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });

    if (sent) {
      RegisterWithMobileNumber.verify = "verification-session-id";
      Navigator.pushNamed(context, 'otpphone');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send OTP. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    RegisterWithMobileNumber.nameSend = nameController.text.toString();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 75, left: 25, right: 25, bottom: 25),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeadingTextWidget(text: createAnAccToGetStarted),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name
                    MyTextField(
                      controller: nameController,
                      keyboardtype: TextInputType.name,
                      hintText: enterYourName,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter your name'
                          : null,
                    ),

                    const SizedBox(height: 15),

                    // Phone
                    MyTextField(
                      controller: phoneController,
                      keyboardtype: TextInputType.number,
                      validator: (phone) => (phone == null || phone.length != 10)
                          ? 'Phone Number should be equal to 10 digits'
                          : null,
                      hintText: enterYouPhoneNumber,
                    ),

                    const SizedBox(height: 25),

                    // Register Button
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : MyTextButton(
                            text: signUp,
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                sendMobileOTP();
                              }
                            },
                          ),

                    const SizedBox(height: 40),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.black38,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          orSignUpWith,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            textStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyInkWellIcon(
                          location: emailLogo,
                          onPressed: () {
                            Navigator.pushNamed(context, 'regemail');
                          },
                        ),
                        MyInkWellIcon(
                          location: googleLogo,
                          onPressed: () async {
                            final nav = Navigator.of(context);
                            final success = await AuthServices().signInGoogle();
                            if (success) {
                              nav.pushNamed('profile_step1');
                            }
                          },
                        ),
                      ],
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.width < 400 ? 25 : 80,
                    ),

                    Column(
                      children: [
                        MyTextWidget(
                          text: alreadyHaveAnAccount,
                        ),
                        MyInkWellButton(
                          text: "Login Now",
                          onPressed: () {
                            Navigator.pushNamed(context, 'loginemail');
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
