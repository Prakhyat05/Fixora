import 'package:service/service/authentication.dart';
import 'package:service/service/globals.dart';

Future<bool> requestOTP([String? email]) async {
  return await AuthServices().requestOTP(email ?? AuthServices.currentEmail ?? Globals.demoEmail);
}

Future<bool> submitOTP(String otp) async {
  return await AuthServices().submitOTP(otp);
}
