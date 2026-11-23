import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service/common/components/my_appbar_back_button.dart';

class RewardBadge {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const RewardBadge({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class RewardPerk {
  final String title;
  final String description;
  final String points;
  final String code;
  final IconData icon;
  bool isClaimed;

  RewardPerk({
    required this.title,
    required this.description,
    required this.points,
    required this.code,
    required this.icon,
    this.isClaimed = false,
  });
}

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  final List<RewardBadge> _badges = const [
    RewardBadge(
      title: "Master Pro",
      subtitle: "150+ 5-Star Jobs",
      icon: Icons.workspace_premium,
      color: Colors.amber,
    ),
    RewardBadge(
      title: "Fast Responder",
      subtitle: "< 5 Min Acceptance",
      icon: Icons.bolt,
      color: Colors.blue,
    ),
    RewardBadge(
      title: "Verified Pro",
      subtitle: "Full KYC Cleared",
      icon: Icons.verified_user,
      color: Color(0xFF00A896),
    ),
    RewardBadge(
      title: "Punctual Star",
      subtitle: "99.2% On-Time",
      icon: Icons.access_time_filled,
      color: Colors.deepPurple,
    ),
  ];

  final List<RewardPerk> _perks = [
    RewardPerk(
      title: "₹500 Tool Allowance Voucher",
      description: "Redeemable at authorized hardware & electrical tool stores.",
      points: "500 Pts",
      code: "FIXORA-TOOL500",
      icon: Icons.construction,
    ),
    RewardPerk(
      title: "0% Commission Weekend Pass",
      description: "Keep 100% of all customer earnings for any upcoming Saturday & Sunday.",
      points: "750 Pts",
      code: "ZERO-COMM-FIX",
      icon: Icons.money_off,
    ),
    RewardPerk(
      title: "₹250 Fuel Cashback Coupon",
      description: "Instant fuel reimbursement credited to your registered UPI ID.",
      points: "400 Pts",
      code: "FUEL-CASH250",
      icon: Icons.local_gas_station,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6F2F2),
      appBar: AppBar(
        leading: const MyAppBarBackButton(),
        leadingWidth: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Rewards & Badges",
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Main Points Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00A896), Color(0xFF028090)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00A896).withOpacity(0.35),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Reward Points",
                          style: GoogleFonts.montserrat(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                "Gold Partner",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "1,850",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "PTS",
                          style: GoogleFonts.montserrat(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Progress to Next Tier
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Next: Platinum Partner (2,000 PTS)",
                          style: GoogleFonts.montserrat(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          "150 pts needed",
                          style: GoogleFonts.montserrat(
                            color: Colors.amberAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: const LinearProgressIndicator(
                        value: 1850 / 2000,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            // White Content Card
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges Section
                  Text(
                    "Earned Badges",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _badges.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.3,
                    ),
                    itemBuilder: (context, index) {
                      final b = _badges[index];
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: b.color.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(b.icon, color: b.color, size: 22),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    b.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    b.subtitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.grey.shade600,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  // Redeemable Perks Section
                  Text(
                    "Redeemable Perks",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _perks.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final p = _perks[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00A896).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(p.icon, color: const Color(0xFF00A896), size: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p.title,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        p.points,
                                        style: GoogleFonts.montserrat(
                                          color: const Color(0xFF00A896),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              p.description,
                              style: GoogleFonts.montserrat(
                                color: Colors.black54,
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    p.code,
                                    style: GoogleFonts.courierPrime(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: p.isClaimed
                                        ? Colors.grey.shade400
                                        : const Color(0xFF00A896),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      p.isClaimed = true;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: const Color(0xFF00A896),
                                        content: Text(
                                          "Perk Claimed! Voucher code '${p.code}' is now active on your account.",
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    p.isClaimed ? "Claimed" : "Claim Perk",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
