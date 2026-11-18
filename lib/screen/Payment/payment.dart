import 'package:service/export.dart';
import 'package:service/service/authentication.dart';
import 'package:service/service/globals.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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

  void _startPayment() {
    try {
      final userEmail = AuthServices.currentEmail ?? Globals.demoEmail;
      final userPhone = AuthServices.currentPhone ?? Globals.demoPhone;

      final options = {
        'key': Globals.razorpayKey,
        'amount': 100 * 70, // Rs. 70
        'name': 'RAPSAPP',
        'description': 'Service Booking Fee',
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
      _simulateDemoPayment();
    }
  }

  void _simulateDemoPayment() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment Successful (Demo Mode)')),
    );
    Navigator.pushReplacementNamed(context, 'dashboard');
  }

  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    _showAlertDialog(
      "Payment Notice",
      "Payment could not be completed via gateway. You can use the Demo Payment option.",
    );
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    _showAlertDialog("Payment Successful", "Payment ID: ${response.paymentId}");
    Navigator.pushReplacementNamed(context, 'dashboard');
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
        leading: const MyAppBarBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.payment,
                size: 80,
                color: Color(0xFF00A896),
              ),
              const SizedBox(height: 20),
              const MyHeadingTextWidget(text: 'Service Checkout'),
              const SizedBox(height: 10),
              const MyDescTextWidget(text: 'Complete payment to confirm your booking'),
              const SizedBox(height: 30),
              MyTextButton(
                text: 'Pay ₹70 via Gateway',
                onPressed: _startPayment,
              ),
              const SizedBox(height: 15),
              OutlinedButton.icon(
                icon: const Icon(Icons.check, color: Color(0xFF00A896)),
                label: const Text(
                  'Demo Payment (Instant Confirmation)',
                  style: TextStyle(color: Color(0xFF00A896)),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Color(0xFF00A896)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _simulateDemoPayment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
