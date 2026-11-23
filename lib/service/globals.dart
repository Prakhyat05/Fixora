class Globals {
  /// Base URL of the backend REST API
  static const String backendURL = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: "https://rapsapp-3b673.uc.r.appspot.com",
  );

  /// Razorpay key - can be overridden via dart-define or environment
  static const String razorpayKey = String.fromEnvironment(
    'RAZORPAY_KEY',
    defaultValue: "rzp_test_sampleKey123",
  );

  /// Demo mode flag: ensures the app is fully testable and functional offline
  /// or when the backend server is unreachable. Perfect for recruiter reviews.
  static bool demoMode = true;

  /// Default demo user details for quick recruiter testing
  static const String demoEmail = "provider@fixora.com";
  static const String demoPassword = "Password@123";
  static const String demoName = "Sandeep Kumar";
  static const String demoPhone = "9876543210";
}
