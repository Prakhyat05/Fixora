// ignore_for_file: prefer_const_constructors

import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import "package:service/screen/Auth/verification/otp_mobile.dart";
import "package:service/screen/ComingSoon.dart";
import "package:service/screen/Dashboard1/app_language.dart";
import "package:service/screen/Dashboard1/empty_state.dart";
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
      title: 'RapsApp',
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
        if (!kIsWeb) return child ?? const SizedBox.shrink();

        final mediaQuery = MediaQuery.of(context);
        final isDesktop = mediaQuery.size.width > 500;
        if (!isDesktop) return child ?? const SizedBox.shrink();

        final availableHeight = mediaQuery.size.height * 0.94;
        final targetHeight = availableHeight > 880.0
            ? 880.0
            : (availableHeight < 620.0 ? 620.0 : availableHeight);
        final targetWidth = (targetHeight * 0.48).clamp(380.0, 420.0);

        final boundedChild = MediaQuery(
          data: mediaQuery.copyWith(
            size: Size(targetWidth, targetHeight),
          ),
          child: child ?? const SizedBox.shrink(),
        );

        return Scaffold(
          backgroundColor: const Color(0xFF0F172A),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF00A896).withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'RapsApp — Live Mobile Preview',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      width: targetWidth,
                      height: targetHeight,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(color: const Color(0xFF334155), width: 8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.55),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: boundedChild,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
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
        'comingsoon': (context) => Comingsoon(),
        'emptystate': (context) => ProviderDashboard(),
        'otpmobile': (context) => OtpMobile(),
      },
      //home: user != null ? const Dashboard() : const LoginWithEmail(),
    );
  }
}
