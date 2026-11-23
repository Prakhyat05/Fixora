// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:service/export.dart';

class Earning extends StatefulWidget {
  const Earning({super.key});

  @override
  State<Earning> createState() => _EarningState();
}

class _EarningState extends State<Earning> {
  double _withdrawableBalance = 7000.0;

  void _showWithdrawalSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        bool isProcessing = false;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Instant UPI Payout",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.account_balance, color: Color(0xFF00A896), size: 28),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "State Bank of India (SBI)",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "A/C: ****1234 • IFSC: SBIN0001234",
                              style: GoogleFonts.montserrat(
                                color: Colors.grey.shade600,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              "UPI ID: prakhyat@oksbi",
                              style: GoogleFonts.montserrat(
                                color: const Color(0xFF00A896),
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Withdrawable Revenue:",
                        style: GoogleFonts.montserrat(fontSize: 13, color: Colors.black54),
                      ),
                      Text(
                        _withdrawableBalance > 0
                            ? "₹${_withdrawableBalance.toStringAsFixed(2)}"
                            : "₹0.00",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF00A896),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A896),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: isProcessing || _withdrawableBalance <= 0
                          ? null
                          : () async {
                              final navigator = Navigator.of(ctx);
                              final messenger = ScaffoldMessenger.of(context);
                              setModalState(() {
                                isProcessing = true;
                              });
                              await Future.delayed(const Duration(milliseconds: 1400));
                              if (!mounted) return;
                              setState(() {
                                _withdrawableBalance = 0.0;
                              });
                              navigator.pop();
                              messenger.showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xFF00A896),
                                  content: Text(
                                    "₹7,000.00 transferred successfully to prakhyat@oksbi! UTR: 482910395",
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            },
                      child: isProcessing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              _withdrawableBalance > 0
                                  ? "Transfer ₹${_withdrawableBalance.toStringAsFixed(0)} to UPI Now"
                                  : "Funds Transferred",
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD6F2F2),
      appBar: AppBar(
        leading: MyAppBarBackButton(),
        leadingWidth: 100,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Earning Text
              MyHeadingTextWidget(text: 'Earnings'),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 120),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 10,
                            offset: Offset(0, 1.5),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width < 400
                              ? 70
                              : 100,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width < 400
                              ? 300
                              : 350,
                          height: MediaQuery.of(context).size.width < 400
                              ? 150
                              : 175,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 10,
                                  offset: Offset(0, 1.5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        MyDescTextWidget(
                                          text: 'This Month',
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  400
                                              ? 13
                                              : 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              leftImage,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? 15
                                                  : 20,
                                              height: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? 15
                                                  : 20,
                                            ),
                                            MySecondHeading(
                                              text: '₹7000.00',
                                              fontsize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? 22
                                                  : 25,
                                            ),
                                            Image.asset(
                                              rightImage,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? 15
                                                  : 20,
                                              height: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? 15
                                                  : 20,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyDescTextWidget(
                                              text: 'Services',
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? 15
                                                  : 18,
                                            ),
                                            MySecondHeading(
                                              fontWeight: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                              text: '204 Completed',
                                              fontsize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? 12
                                                  : 16,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            MyDescTextWidget(
                                              text: 'Duration',
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? 15
                                                  : 18,
                                              align: TextAlign.center,
                                            ),
                                            MySecondHeading(
                                              text: '88 hrs',
                                              fontWeight: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                              fontsize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      400
                                                  ? 12
                                                  : 16,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                        // Instant Payout Action Button
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.flash_on, color: Colors.amberAccent, size: 20),
                            label: Text(
                              _withdrawableBalance > 0
                                  ? "Instant UPI Withdrawal (₹${_withdrawableBalance.toStringAsFixed(0)})"
                                  : "Balance Settled (₹0.00)",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00A896),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 2,
                            ),
                            onPressed: _showWithdrawalSheet,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Options
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyTextWidget(
                                text: 'Transaction History',
                                align: TextAlign.start,
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width < 400
                                        ? 18
                                        : 22,
                              ),
                              Divider(),
                              MyTextWidget(
                                text: 'Prakhyat Prakhar (Diagnostic & Repair)',
                                align: TextAlign.start,
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width < 400
                                        ? 14
                                        : 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyDescTextWidget(
                                    text: 'Paid on 12 june, 6:30pm',
                                    fontSize:
                                        MediaQuery.of(context).size.width < 400
                                            ? 12
                                            : 15,
                                  ),
                                  MySecondHeading(text: '₹750.00')
                                ],
                              ),
                              Divider(),
                              MyTextWidget(
                                text: 'Prakhyat Prakhar (Diagnostic & Repair)',
                                align: TextAlign.start,
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width < 400
                                        ? 14
                                        : 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyDescTextWidget(
                                    text: 'Paid on 12 june, 6:30pm',
                                    fontSize:
                                        MediaQuery.of(context).size.width < 400
                                            ? 12
                                            : 15,
                                  ),
                                  MySecondHeading(text: '₹750.00')
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: MyInkWellButton(
                                      text: 'View Older', onPressed: () {}))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 25,
                    child: SizedBox(
                      width:
                          MediaQuery.of(context).size.width < 400 ? 300 : 350,
                      height:
                          MediaQuery.of(context).size.width < 400 ? 150 : 175,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    MyDescTextWidget(
                                      text: 'Today',
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  400
                                              ? 13
                                              : 15,
                                    ),
                                    MySecondHeading(
                                      text: '₹900.00',
                                      fontsize:
                                          MediaQuery.of(context).size.width <
                                                  400
                                              ? 22
                                              : 25,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyDescTextWidget(
                                          text: 'Services',
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  400
                                              ? 15
                                              : 18,
                                        ),
                                        MySecondHeading(
                                          text: '4 Completed',
                                          fontWeight: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  400
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                          fontsize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  400
                                              ? 12
                                              : 16,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        MyDescTextWidget(
                                          text: 'Duration',
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  400
                                              ? 15
                                              : 18,
                                          align: TextAlign.center,
                                        ),
                                        MySecondHeading(
                                          text: '6 hrs',
                                          fontWeight: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  400
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                          fontsize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  400
                                              ? 12
                                              : 16,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
