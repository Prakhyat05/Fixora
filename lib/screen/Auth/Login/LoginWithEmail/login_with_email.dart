import 'package:service/export.dart';
import 'package:service/screen/snackBar.dart';
import 'package:service/service/authentication.dart';
import 'package:service/service/globals.dart';

final _formKey = GlobalKey<FormState>();

class LoginWithEmail extends StatefulWidget {
  const LoginWithEmail({super.key});

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void logInUser() async {
    setState(() {
      isLoading = true;
    });

    final res = await AuthServices().logInUser(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    if (!mounted) return;

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  void loginAsDemo() async {
    emailController.text = Globals.demoEmail;
    passwordController.text = Globals.demoPassword;
    logInUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 75, left: 25, right: 25, bottom: 25),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeadingTextWidget(text: welcomeBackMessage),
              const SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 25),

                    // Email Field
                    MyTextField(
                      controller: emailController,
                      keyboardtype: TextInputType.emailAddress,
                      hintText: enterYourEmail,
                      validator: validateEmail,
                    ),

                    const SizedBox(height: 15),

                    // Password Field
                    MyPasswordTextField(
                      controller: passwordController,
                      obsecureText: true,
                      hintText: enterYourPassword,
                      validator: (password) => (password == null || password.length < 6)
                          ? 'Password should be at least 6 characters'
                          : null,
                    ),

                    const SizedBox(height: 25),

                    // Login Button
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : MyTextButton(
                            text: login,
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                logInUser();
                              }
                            },
                          ),

                    const SizedBox(height: 12),

                    // Demo Login Shortcut for Recruiters
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF00A896), width: 1.5),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.bolt, color: Color(0xFF00A896)),
                      label: Text(
                        "Quick Demo Login (For Recruiters)",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF00A896),
                          fontSize: 14,
                        ),
                      ),
                      onPressed: loginAsDemo,
                    ),

                    const SizedBox(height: 15),

                    // Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'forgetpassword');
                          },
                          child: Text(
                            forgetPassword,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              textStyle: const TextStyle(
                                color: Colors.black38,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.width < 400 ? 15 : 25,
                    ),

                    // Divider
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
                          orLoginWith,
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

                    // Social Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyInkWellIcon(
                          location: phoneLogo,
                          onPressed: () {
                            Navigator.pushNamed(context, 'loginphone');
                          },
                        ),
                        MyInkWellIcon(
                          location: googleLogo,
                          onPressed: () async {
                            final nav = Navigator.of(context);
                            final success = await AuthServices().signInGoogle();
                            if (success) {
                              nav.pushReplacementNamed('dashboard');
                            }
                          },
                        ),
                      ],
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.width < 400 ? 25 : 60,
                    ),

                    Column(
                      children: [
                        MyTextWidget(text: dontHaveAnAcc),
                        MyInkWellButton(
                          text: regNow,
                          onPressed: () {
                            Navigator.pushNamed(context, 'regemail');
                          },
                        ),
                      ],
                    ),
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
