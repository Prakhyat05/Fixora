import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:service/service/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum WeekDays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

class AuthServices {
  static String? authToken;
  static String? currentEmail;
  static String? currentPhone;
  static String? currentName;

  static final AuthServices _singleton = AuthServices._internal();

  factory AuthServices() {
    return _singleton;
  }

  AuthServices._internal();

  Future<void> sync() async {
    try {
      final pref = await SharedPreferences.getInstance();
      if (authToken == null) {
        authToken = pref.getString("auth-token");
      } else {
        await pref.setString("auth-token", authToken!);
      }
      currentEmail = pref.getString("auth-email") ?? currentEmail;
      currentPhone = pref.getString("auth-phone") ?? currentPhone;
      currentName = pref.getString("auth-name") ?? currentName;
    } catch (_) {}
  }

  Future<void> logout() async {
    authToken = null;
    currentEmail = null;
    currentPhone = null;
    currentName = null;
    try {
      final pref = await SharedPreferences.getInstance();
      await pref.remove("auth-token");
      await pref.remove("auth-email");
      await pref.remove("auth-phone");
      await pref.remove("auth-name");
    } catch (_) {}
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// Standard Sign In returning a response string ("success" on success)
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    currentEmail = email;
    try {
      final resp = await http
          .put(
            Uri.parse("${Globals.backendURL}/auth/sign_in"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 4));

      if (resp.statusCode == 200) {
        final setCookie = resp.headers["set-cookie"];
        if (setCookie != null) {
          try {
            final cookies = Cookie.fromSetCookieValue(setCookie);
            if (cookies.name == "auth-token") {
              authToken = cookies.value;
            }
          } catch (_) {}
        }
        authToken ??= "session-token-${DateTime.now().millisecondsSinceEpoch}";
        final pref = await SharedPreferences.getInstance();
        await pref.setString("auth-token", authToken!);
        await pref.setString("auth-email", email);
        return "success";
      } else {
        if (Globals.demoMode) {
          authToken = "demo-token";
          return "success";
        }
        return "Invalid credentials";
      }
    } catch (e) {
      if (Globals.demoMode) {
        authToken = "demo-token";
        final pref = await SharedPreferences.getInstance();
        await pref.setString("auth-token", authToken!);
        await pref.setString("auth-email", email);
        return "success";
      }
      return "Network error: Unable to reach server";
    }
  }

  Future<void> signIn(String email, String password) async {
    await logInUser(email: email, password: password);
  }

  /// Standard Sign Up returning a response string ("success" on success)
  Future<String> signUPUser({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    currentEmail = email;
    currentName = name;
    currentPhone = phone;

    try {
      final resp = await http
          .post(
            Uri.parse("${Globals.backendURL}/auth/sign_up"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "email": email,
              "password": password,
              "name": name,
              "phone": phone ?? "",
            }),
          )
          .timeout(const Duration(seconds: 4));

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        authToken ??= "signup-token-${DateTime.now().millisecondsSinceEpoch}";
        final pref = await SharedPreferences.getInstance();
        await pref.setString("auth-token", authToken!);
        await pref.setString("auth-email", email);
        await pref.setString("auth-name", name);
        return "success";
      } else {
        if (Globals.demoMode) {
          authToken = "demo-signup-token";
          return "success";
        }
        return "Registration failed (${resp.statusCode})";
      }
    } catch (e) {
      if (Globals.demoMode) {
        authToken = "demo-signup-token";
        return "success";
      }
      return "Network error: Unable to reach server";
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String phone,
    String name,
  ) async {
    await signUPUser(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }

  Future<bool> requestOTP([String? email]) async {
    final targetEmail = email ?? currentEmail ?? Globals.demoEmail;
    try {
      final resp = await http
          .post(
            Uri.parse("${Globals.backendURL}/auth/new_otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": targetEmail}),
          )
          .timeout(const Duration(seconds: 4));
      return resp.statusCode == 200 || Globals.demoMode;
    } catch (_) {
      return Globals.demoMode;
    }
  }

  Future<bool> checkOTP(String email, String otp) async {
    try {
      final resp = await http
          .post(
            Uri.parse("${Globals.backendURL}/auth/verify_otp"),
            headers: {
              "Content-Type": "application/json",
              if (authToken != null)
                "Cookie": Cookie("auth-token", authToken!).toString(),
            },
            body: jsonEncode({"email": email, "otp": otp}),
          )
          .timeout(const Duration(seconds: 4));
      return resp.statusCode == 200 || Globals.demoMode;
    } catch (_) {
      return Globals.demoMode;
    }
  }

  Future<bool> submitOTP(String otp) async {
    final email = currentEmail ?? Globals.demoEmail;
    return await checkOTP(email, otp);
  }

  Future<bool> requestMobileOTP(String phone) async {
    currentPhone = phone;
    try {
      final resp = await http
          .post(
            Uri.parse("${Globals.backendURL}/auth/mobile_otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"phone": phone}),
          )
          .timeout(const Duration(seconds: 4));
      return resp.statusCode == 200 || Globals.demoMode;
    } catch (_) {
      return Globals.demoMode;
    }
  }

  Future<bool> verifyMobileOTP(String phone, String otp) async {
    currentPhone = phone;
    try {
      final resp = await http
          .post(
            Uri.parse("${Globals.backendURL}/auth/verify_mobile_otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"phone": phone, "otp": otp}),
          )
          .timeout(const Duration(seconds: 4));
      if (resp.statusCode == 200) {
        authToken ??= "mobile-auth-token";
        return true;
      }
      return Globals.demoMode;
    } catch (_) {
      if (Globals.demoMode) {
        authToken ??= "demo-mobile-token";
        return true;
      }
      return false;
    }
  }

  Future<dynamic> getProfile() async {
    if (authToken == null && !Globals.demoMode) {
      return null;
    }
    try {
      final resp = await http
          .get(
            Uri.parse("${Globals.backendURL}/profile"),
            headers: {
              if (authToken != null)
                "Cookie": Cookie("auth-token", authToken!).toString(),
            },
          )
          .timeout(const Duration(seconds: 4));
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      }
    } catch (_) {}

    if (Globals.demoMode) {
      return {
        "name": currentName ?? Globals.demoName,
        "email": currentEmail ?? Globals.demoEmail,
        "phone": currentPhone ?? Globals.demoPhone,
        "rating": 4.9,
        "completed_jobs": 150,
      };
    }
    return null;
  }

  Future<dynamic> getUser() async {
    if (authToken == null && !Globals.demoMode) {
      return null;
    }
    try {
      final resp = await http
          .get(
            Uri.parse("${Globals.backendURL}/users"),
            headers: {
              if (authToken != null)
                "Cookie": Cookie("auth-token", authToken!).toString(),
            },
          )
          .timeout(const Duration(seconds: 4));
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      }
    } catch (_) {}

    if (Globals.demoMode && authToken != null) {
      return {
        "name": currentName ?? Globals.demoName,
        "email": currentEmail ?? Globals.demoEmail,
      };
    }
    return null;
  }

  Future<bool> signInGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        try {
          await http
              .post(
                Uri.parse("${Globals.backendURL}/auth/google"),
                headers: {"Content-Type": "application/json"},
                body: jsonEncode(
                    {"credential": googleSignInAuthentication.accessToken}),
              )
              .timeout(const Duration(seconds: 4));
        } catch (_) {}
        authToken = "google-auth-token";
        currentEmail = googleSignInAccount.email;
        currentName = googleSignInAccount.displayName;
        return true;
      }
    } catch (_) {
      if (Globals.demoMode) {
        authToken = "demo-google-token";
        currentEmail = Globals.demoEmail;
        currentName = Globals.demoName;
        return true;
      }
    }
    return false;
  }

  Future<dynamic> createProfile(
    String adhaar,
    String city,
    String district,
    int pinCode,
    String town,
    String accountNumber,
    String branch,
    String ifsc,
  ) async {
    try {
      final resp = await http
          .post(
            Uri.parse("${Globals.backendURL}/profile"),
            headers: {
              "Content-Type": "application/json",
              if (authToken != null)
                "Cookie": Cookie("auth-token", authToken!).toString(),
            },
            body: jsonEncode({
              "adhaar": adhaar,
              "city": city,
              "district": district,
              "pin_code": pinCode,
              "town": town,
              "account_number": accountNumber,
              "branch": branch,
              "ifsc": ifsc,
            }),
          )
          .timeout(const Duration(seconds: 5));
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return jsonDecode(resp.body);
      }
    } catch (_) {}

    if (Globals.demoMode) {
      return {"status": "success", "message": "Profile created successfully"};
    }
    return null;
  }

  Future<dynamic> setProfilePhoto(dynamic pic) async {
    if (pic == null) return null;
    try {
      if (pic is File && !await pic.exists()) return null;
      final bytes = pic is File ? await pic.readAsBytes() : null;
      if (bytes == null) return null;
      return await http
          .post(
            Uri.parse("${Globals.backendURL}/profile/photo"),
            headers: {
              if (authToken != null)
                "Cookie": Cookie("auth-token", authToken!).toString(),
            },
            body: bytes,
          )
          .timeout(const Duration(seconds: 5));
    } catch (_) {
      return null;
    }
  }

  Future<dynamic> addService(
    String name,
    int rate,
    List<WeekDays> workingDays,
    TimeOfDay workingHoursStart,
    TimeOfDay workingHoursEnd,
  ) async {
    var internalWorkingDays = 0;
    for (final day in workingDays) {
      internalWorkingDays |= 1 << day.index;
    }
    final startTimeStr =
        "${workingHoursStart.hour.toString().padLeft(2, '0')}:${workingHoursStart.minute.toString().padLeft(2, '0')}";
    final endTimeStr =
        "${workingHoursEnd.hour.toString().padLeft(2, '0')}:${workingHoursEnd.minute.toString().padLeft(2, '0')}";

    try {
      return await http
          .post(
            Uri.parse("${Globals.backendURL}/profile/services"),
            headers: {
              "Content-Type": "application/json",
              if (authToken != null)
                "Cookie": Cookie("auth-token", authToken!).toString(),
            },
            body: jsonEncode({
              "name": name,
              "rate": rate,
              "working_days": internalWorkingDays,
              "working_hours_start": startTimeStr,
              "working_hours_end": endTimeStr,
            }),
          )
          .timeout(const Duration(seconds: 5));
    } catch (_) {
      return null;
    }
  }

  Future<dynamic> getServices() async {
    try {
      final resp = await http
          .get(
            Uri.parse("${Globals.backendURL}/profile/services"),
            headers: {
              if (authToken != null)
                "Cookie": Cookie("auth-token", authToken!).toString(),
            },
          )
          .timeout(const Duration(seconds: 4));
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      }
    } catch (_) {}

    if (Globals.demoMode) {
      return [
        {"name": "Electrician", "rate": 75, "active": true},
        {"name": "Plumber", "rate": 60, "active": true},
      ];
    }
    return [];
  }

  Future<dynamic> getProfilePhoto(dynamic pic) async {
    try {
      final resp = await http
          .get(
            Uri.parse("${Globals.backendURL}/profile/photo"),
            headers: {
              if (authToken != null)
                "Cookie": Cookie("auth-token", authToken!).toString(),
            },
          )
          .timeout(const Duration(seconds: 4));
      return resp.bodyBytes;
    } catch (_) {
      return null;
    }
  }

  bool isSignedIn() {
    return authToken != null;
  }
}
