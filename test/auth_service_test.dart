import 'package:flutter_test/flutter_test.dart';
import 'package:service/service/authentication.dart';
import 'package:service/service/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    Globals.demoMode = true;
  });

  group('AuthServices & Session Management', () {
    test('Singleton instance returns the same object', () {
      final auth1 = AuthServices();
      final auth2 = AuthServices();
      expect(identical(auth1, auth2), isTrue);
    });

    test('Initial authentication state is not signed in', () {
      final auth = AuthServices();
      auth.logout();
      expect(auth.isSignedIn(), isFalse);
    });

    test('Demo login succeeds and sets authentication token', () async {
      final auth = AuthServices();
      final result = await auth.logInUser(
        email: Globals.demoEmail,
        password: Globals.demoPassword,
      );

      expect(result, equals('success'));
      expect(auth.isSignedIn(), isTrue);
      expect(AuthServices.authToken, isNotNull);
    });

    test('Demo signup succeeds and saves user credentials', () async {
      final auth = AuthServices();
      final result = await auth.signUPUser(
        email: 'testprovider@rapsapp.com',
        password: 'Password@123',
        name: 'Test Provider',
        phone: '9988776655',
      );

      expect(result, equals('success'));
      expect(auth.isSignedIn(), isTrue);
      expect(AuthServices.currentEmail, equals('testprovider@rapsapp.com'));
      expect(AuthServices.currentName, equals('Test Provider'));
    });

    test('OTP request and verification in demo mode', () async {
      final auth = AuthServices();
      final requestSuccess = await auth.requestOTP('test@rapsapp.com');
      expect(requestSuccess, isTrue);

      final verifySuccess = await auth.checkOTP('test@rapsapp.com', '123456');
      expect(verifySuccess, isTrue);
    });

    test('Mobile OTP verification succeeds and establishes session', () async {
      final auth = AuthServices();
      final requestSuccess = await auth.requestMobileOTP('9876543210');
      expect(requestSuccess, isTrue);

      final verifySuccess = await auth.verifyMobileOTP('9876543210', '1234');
      expect(verifySuccess, isTrue);
      expect(auth.isSignedIn(), isTrue);
    });

    test('Profile fetch returns structured provider profile', () async {
      final auth = AuthServices();
      final profile = await auth.getProfile();
      expect(profile, isNotNull);
      expect(profile['rating'], isNotNull);
      expect(profile['completed_jobs'], isNotNull);
    });

    test('Logout clears session token and user info', () async {
      final auth = AuthServices();
      await auth.logout();
      expect(auth.isSignedIn(), isFalse);
      expect(AuthServices.authToken, isNull);
    });
  });
}
