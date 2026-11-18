import 'package:flutter/material.dart';
import 'package:service/common/components/my_appbar_back_button.dart';
import 'package:service/common/components/my_text_button.dart';
import 'package:service/common/components/my_text_widget.dart';
import 'package:service/common/components/my_textfiled.dart';

class ActivateAccount2 extends StatefulWidget {
  const ActivateAccount2({super.key});

  @override
  State<ActivateAccount2> createState() => _ActivateAccount2State();
}

class _ActivateAccount2State extends State<ActivateAccount2> {
  final TextEditingController upiID = TextEditingController();
  bool isProcessing = false;

  @override
  void dispose() {
    upiID.dispose();
    super.dispose();
  }

  void _verifyAndPay() async {
    final upi = upiID.text.trim();
    if (upi.isEmpty || !upi.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid UPI ID (e.g. yourname@upi)')),
      );
      return;
    }

    setState(() {
      isProcessing = true;
    });

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    Navigator.pushReplacementNamed(context, 'accs');
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
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(
                      color: Colors.black54,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          SizedBox(width: 15),
                          MyTextWidget(
                            text: 'Pay using UPI ID (₹39)',
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          'assets/images/profile/Cross.png',
                          width: 20,
                          height: 20,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTextField(
                        controller: upiID,
                        keyboardtype: TextInputType.text,
                        hintText: 'Enter your UPI ID (e.g. mobile@upi)',
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: isProcessing
                            ? const Center(child: CircularProgressIndicator())
                            : MyTextButton(
                                text: 'Verify and Pay ₹39',
                                onPressed: _verifyAndPay,
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
