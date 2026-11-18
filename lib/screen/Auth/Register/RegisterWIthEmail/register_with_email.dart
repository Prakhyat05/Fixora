import 'package:service/export.dart';
import 'package:service/screen/snackBar.dart';
import 'package:service/service/authentication.dart';

final _formKey = GlobalKey<FormState>();

class RegisterWithEmail extends StatefulWidget {
  const RegisterWithEmail({super.key});
  static String nameSend = "";
  static String emailSend = "";

  @override
  State<RegisterWithEmail> createState() => _RegisterWithEmailState();
}

class _RegisterWithEmailState extends State<RegisterWithEmail> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });

    final res = await AuthServices().signUPUser(
      email: emailController.text.trim(),
      password: passwordController.text,
      name: nameController.text.trim(),
    );

    if (!mounted) return;

    if (res == "success") {
      await AuthServices().requestOTP(emailController.text.trim());
      if (!mounted) return;
      await Navigator.pushNamed(context, 'otpemail');
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    RegisterWithEmail.nameSend = nameController.text.toString();
    RegisterWithEmail.emailSend = emailController.text.toString();
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
                      validator: (value) =>
                          (value == null || value.isEmpty) ? 'Please enter your name' : null,
                    ),

                    const SizedBox(height: 15),

                    // Email
                    MyTextField(
                      controller: emailController,
                      keyboardtype: TextInputType.emailAddress,
                      hintText: enterYourEmail,
                      validator: validateEmail,
                    ),

                    const SizedBox(height: 15),

                    // Password
                    MyPasswordTextField(
                      controller: passwordController,
                      obsecureText: true,
                      hintText: enterYourPassword,
                      validator: (password) => (password == null || password.length < 6)
                          ? 'Password should be at least 6 characters'
                          : null,
                    ),

                    const SizedBox(height: 25),

                    // Register Button
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : MyTextButton(
                            text: signUp,
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                signUpUser();
                              }
                            },
                          ),

                    const SizedBox(height: 40),

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

                    // Social Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyInkWellIcon(
                          onPressed: () {
                            Navigator.pushNamed(context, 'regphone');
                          },
                          location: phoneLogo,
                        ),
                        MyInkWellIcon(
                          onPressed: () async {
                            final nav = Navigator.of(context);
                            final success = await AuthServices().signInGoogle();
                            if (success) {
                              nav.pushNamed('profile_step1');
                            }
                          },
                          location: googleLogo,
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
