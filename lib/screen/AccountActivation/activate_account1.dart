import 'package:service/export.dart';
import 'package:service/service/authentication.dart';
import 'package:service/service/globals.dart';

class ActivateAccount1 extends StatefulWidget {
  const ActivateAccount1({super.key});

  @override
  State<ActivateAccount1> createState() => _ActivateAccount1State();
}

class _ActivateAccount1State extends State<ActivateAccount1> {
  bool showOptions = false;
  late final Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _startRazorpayPayment() {
    try {
      final userEmail = AuthServices.currentEmail ?? Globals.demoEmail;
      final userPhone = AuthServices.currentPhone ?? Globals.demoPhone;

      final options = {
        'key': Globals.razorpayKey,
        'amount': 100 * 39, // Rs. 39 nominal activation fee
        'name': 'FIXORA',
        'description': 'Provider Account Activation',
        'method': {
          'netbanking': false,
          'card': false,
          'upi': true,
          'wallet': false,
          'paylater': false,
        },
        'prefill': {
          'contact': userPhone,
          'email': userEmail,
        },
      };
      _razorpay.open(options);
    } catch (_) {
      // In web/desktop or environments without native Razorpay, simulate success
      _simulateDemoActivation();
    }
  }

  void _simulateDemoActivation() {
    Navigator.pushReplacementNamed(context, 'accs');
  }

  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    _showAlertDialog(
      "Payment Notice",
      "Payment processing was interrupted or simulated.\nYou can also proceed using Demo Activation.",
    );
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    Navigator.pushReplacementNamed(context, 'accs');
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              child: const Text("Continue"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const MyAppBarBackButton(),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyHeadingTextWidget(text: 'Activate Your Account'),
              const MyDescTextWidget(text: 'Pay a Nominal Fee of ₹39 to Get Started'),
              const SizedBox(height: 30),
              const MySecondHeading(text: 'Select payment option'),
              const SizedBox(height: 20),

              // UPI Option
              MyGestureButton(
                onPressed: _startRazorpayPayment,
                hintText: 'Pay ₹39 using UPI / Razorpay',
              ),

              const SizedBox(height: 15),

              // Direct UPI ID Option
              MyGestureButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'aa_2');
                },
                hintText: 'Pay using Custom UPI ID',
              ),

              const SizedBox(height: 25),

              // Demo Activation Shortcut for Recruiters
              Center(
                child: TextButton.icon(
                  icon: const Icon(Icons.check_circle_outline, color: Color(0xFF00A896)),
                  label: const Text(
                    "Simulate Instant Activation (Demo)",
                    style: TextStyle(
                      color: Color(0xFF00A896),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: _simulateDemoActivation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
