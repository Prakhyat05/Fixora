// ignore_for_file: prefer_const_constructors

import 'dart:ui' as ui;
import "package:service/screen/Auth/verification/otp_mobile.dart";
import "package:service/screen/ComingSoon.dart";
import "package:service/screen/Dashboard1/app_language.dart";
import "package:service/screen/Dashboard1/empty_state.dart";
import "package:service/screen/Dashboard1/rewards.dart";
import "package:service/screen/Dashboard1/faqs.dart";
import "package:shared_preferences/shared_preferences.dart";

import "export.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;

  runApp(MyApp(hasSeenOnboarding: onboarding));
}

class MyApp extends StatefulWidget {
  final bool hasSeenOnboarding;
  const MyApp({super.key, this.hasSeenOnboarding = false});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fixora',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          ui.PointerDeviceKind.mouse,
          ui.PointerDeviceKind.touch,
          ui.PointerDeviceKind.stylus,
          ui.PointerDeviceKind.trackpad,
        },
      ),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF00A896),
          secondary: Color(0xFF028090),
        ),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
      routes: {
        '/': (context) => SplashScreenOne(onboarding: widget.hasSeenOnboarding),
        'regemail': (context) => RegisterWithEmail(),
        'regphone': (context) => RegisterWithMobileNumber(),
        'loginemail': (context) => LoginWithEmail(),
        'loginphone': (context) => LoginWithMobileNumber(),
        'dashboard': (context) => Dashboard(),
        'profile': (context) => DashboardUserProfile(),
        'forgetpassword': (context) => ForgetPassword(),
        'otpemail': (context) => OTPEmail(),
        'otpphone': (context) => OTPPhone(),
        'otpemailverified': (context) => OTPVerified(),
        'otpphoneverified': (context) => OTPVerified(),
        'aa_1': (context) => ActivateAccount1(),
        'aa_2': (context) => ActivateAccount2(),
        'accs': (context) => AccountActivated(),
        'pay': (context) => Payment(),
        'call': (context) => Calling(),
        'chat': (context) => ChatPage(),
        'earning': (context) => Earning(),
        'clientOnGoingJob': (context) => ClientOnGoingJob(),
        'notification': (context) => NotificationPage(),
        'reviews': (context) => Reviews(),
        'profile_step1': (context) => Step1(),
        'profile_step2': (context) => Step2(),
        'profile_step3': (context) => Step3(),
        'profile_step4': (context) => Step4(),
        'profile_step5': (context) => Step5(),
        'view_appointments': (context) => ViewAppointments(),
        'manage_services': (context) => ServicePage(),
        'allReviews': (context) => Reviews(),
        'notificationPage': (context) => NotificationPage(),
        'serviceOTPVerification': (context) => ServiceOtpVerification(),
        'startingService': (context) => StartingAnimation(),
        'appLanguage': (context) => AppLanguage(),
        'rewards': (context) => const RewardsPage(),
        'faqs': (context) => const FaqPage(),
        'comingsoon': (context) => Comingsoon(),
        'emptystate': (context) => ProviderDashboard(),
        'otpmobile': (context) => OtpMobile(),
      },
      //home: user != null ? const Dashboard() : const LoginWithEmail(),
    );
  }
}
