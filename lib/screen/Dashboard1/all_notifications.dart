import 'package:service/export.dart';

class AllNotifications extends StatefulWidget {
  const AllNotifications({super.key});

  @override
  State<AllNotifications> createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Notification 1: Chat message from client
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'chat');
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: greyWithOpacity0_5,
                            child: Image.asset(
                              profileImage,
                              height: 50,
                              width: 50,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MySecondHeading(
                                text: 'Prakhyat Prakhar (Client)',
                                fontWeight: MediaQuery.of(context).size.width < 400
                                    ? fontWeight400
                                    : fontWeight500,
                                fontsize: MediaQuery.of(context).size.width < 400
                                    ? 15
                                    : 16,
                              ),
                              const SizedBox(height: 2),
                              MyTextWidget(
                                text: 'Sent you a new message regarding Flat 402',
                                fontWeight: fontWeight400,
                                fontSize: MediaQuery.of(context).size.width < 400
                                    ? 11
                                    : 12,
                              ),
                              const SizedBox(height: 2),
                              MyTextWidget(
                                text: '10 mins ago',
                                fontWeight: fontWeight400,
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: MyTextWidget(
                          fontWeight: fontWeight500,
                          text: '09:16 AM',
                          fontSize: 11,
                          color: const Color(0xFF00A896),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 16),
              // Notification 2: Milestone & Rewards
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'rewards');
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.military_tech, color: Colors.amber, size: 28),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MySecondHeading(
                                text: 'Milestone Achieved! 🎉',
                                fontWeight: MediaQuery.of(context).size.width < 400
                                    ? fontWeight400
                                    : fontWeight500,
                                fontsize: MediaQuery.of(context).size.width < 400
                                    ? 15
                                    : 16,
                              ),
                              const SizedBox(height: 2),
                              MyTextWidget(
                                text: 'Completed 150 jobs! Claim your Gold Perks.',
                                fontWeight: fontWeight400,
                                fontSize: MediaQuery.of(context).size.width < 400
                                    ? 11
                                    : 12,
                              ),
                              const SizedBox(height: 2),
                              MyTextWidget(
                                text: '1 hour ago',
                                fontWeight: fontWeight400,
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: MyTextWidget(
                          fontWeight: fontWeight400,
                          text: '08:30 AM',
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 16),
              // Notification 3: UPI Settlement
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'earning');
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.currency_rupee, color: Colors.green, size: 26),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MySecondHeading(
                                text: 'UPI Payout Received 💰',
                                fontWeight: MediaQuery.of(context).size.width < 400
                                    ? fontWeight400
                                    : fontWeight500,
                                fontsize: MediaQuery.of(context).size.width < 400
                                    ? 15
                                    : 16,
                              ),
                              const SizedBox(height: 2),
                              MyTextWidget(
                                text: '₹750 credited instantly to linked bank account.',
                                fontWeight: fontWeight400,
                                fontSize: MediaQuery.of(context).size.width < 400
                                    ? 11
                                    : 12,
                              ),
                              const SizedBox(height: 2),
                              MyTextWidget(
                                text: 'Yesterday',
                                fontWeight: fontWeight400,
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: MyTextWidget(
                          fontWeight: fontWeight400,
                          text: '04:30 PM',
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
