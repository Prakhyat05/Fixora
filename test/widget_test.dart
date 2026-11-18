import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service/main.dart';
import 'package:service/screen/splash/splash_screen_1.dart';
import 'package:service/service/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({'onboarding': true});
    Globals.demoMode = true;
  });

  testWidgets('SplashScreen renders RAPSAPP branding title',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const SplashScreenOne(),
        routes: {
          'loginemail': (context) => const Scaffold(),
          'dashboard': (context) => const Scaffold(),
        },
      ),
    );

    expect(find.text('RAPSAPP'), findsOneWidget);
    expect(find.text('Hyperlocal Service Marketplace'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });

  testWidgets('MyApp boots successfully with Material theme',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(hasSeenOnboarding: true));
    expect(find.byType(MaterialApp), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
