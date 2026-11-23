// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:service/export.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentTabIndex = 0;
  bool isOnline = true;
  bool serviceRequest = true;
  bool reviews = true;
  bool earning = true;
  bool newNotification = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        drawer: _buildDrawer(),
        body: _buildCurrentTab(),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildCurrentTab() {
    switch (_currentTabIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return const ViewAppointments();
      case 2:
        return const Earning();
      case 3:
        return const NotificationPage();
      case 4:
        return const DashboardUserProfile();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedIndex: _currentTabIndex,
            indicatorColor: const Color(0xFF00A896).withOpacity(0.15),
            onDestinationSelected: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: Colors.black54),
                selectedIcon: Icon(Icons.home, color: Color(0xFF00A896)),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today_outlined, color: Colors.black54),
                selectedIcon: Icon(Icons.calendar_today, color: Color(0xFF00A896)),
                label: 'Jobs',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined, color: Colors.black54),
                selectedIcon: Icon(Icons.account_balance_wallet, color: Color(0xFF00A896)),
                label: 'Wallet',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text('1'),
                  backgroundColor: Color(0xFF00A896),
                  child: Icon(Icons.chat_bubble_outline, color: Colors.black54),
                ),
                selectedIcon: Badge(
                  label: Text('1'),
                  backgroundColor: Color(0xFF00A896),
                  child: Icon(Icons.chat_bubble, color: Color(0xFF00A896)),
                ),
                label: 'Messages',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline, color: Colors.black54),
                selectedIcon: Icon(Icons.person, color: Color(0xFF00A896)),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    MyDrawerHeader(),
                    MyDrawerList(),
                  ],
                ),
              ),
            ),
            const MyDrawerBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return CustomScrollView(
      slivers: [
        // App Bar with Online Toggle
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isOnline
                    ? [const Color(0xFFE6F7F5), Colors.white]
                    : [const Color(0xFFF1F5F9), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile Avatar + Name
                    Row(
                      children: [
                        Builder(
                          builder: (ctx) => InkWell(
                            onTap: () => Scaffold.of(ctx).openDrawer(),
                            borderRadius: BorderRadius.circular(25),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  child: Image.asset('assets/images/Dashboard/Profile.png'),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: isOnline ? Colors.green : Colors.grey,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Prakhyat Prakhar",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified, color: Color(0xFF00A896), size: 16),
                              ],
                            ),
                            Text(
                              isOnline ? "Active • Level 4 Partner" : "Offline • Standby Mode",
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                color: isOnline ? const Color(0xFF00A896) : Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Header Actions: Online Switch & Notification Bell
                    Row(
                      children: [
                        // Live Online/Offline Switcher
                        InkWell(
                          onTap: () {
                            setState(() {
                              isOnline = !isOnline;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                backgroundColor: isOnline ? const Color(0xFF00A896) : Colors.black87,
                                content: Text(
                                  isOnline
                                      ? "You are now ONLINE. Dispatch radar active!"
                                      : "You are now OFFLINE. New bookings paused.",
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isOnline ? const Color(0xFF00A896) : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isOnline ? Icons.radar : Icons.power_settings_new,
                                  size: 14,
                                  color: isOnline ? Colors.white : Colors.black54,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isOnline ? "ONLINE" : "OFFLINE",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isOnline ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined, color: Colors.black87),
                          onPressed: () {
                            Navigator.pushNamed(context, 'notificationPage');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Search Bar
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: MySearchTextField(),
          ),
        ),

        // Quick Stats Strip
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Overview",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "Patiala Zone",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricTile(
                        title: "Today's Payout",
                        value: "₹1,850",
                        subtitle: "+18% vs avg",
                        icon: Icons.currency_rupee,
                        color: const Color(0xFF00A896),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildMetricTile(
                        title: "Jobs Done",
                        value: "4 Completed",
                        subtitle: "98% on-time",
                        icon: Icons.task_alt,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricTile(
                        title: "Acceptance",
                        value: "98.5%",
                        subtitle: "High priority",
                        icon: Icons.speed,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildMetricTile(
                        title: "Rating",
                        value: "4.92 ⭐",
                        subtitle: "152 verified",
                        icon: Icons.star_half,
                        color: Colors.amber.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Active Service Dispatch Radar Card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Incoming Service Radar",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (isOnline && !serviceRequest)
                      TextButton.icon(
                        icon: const Icon(Icons.refresh, size: 14),
                        label: Text(
                          "Simulate Job",
                          style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            serviceRequest = true;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                if (!isOnline)
                  _buildOfflineCard()
                else if (serviceRequest)
                  _buildActiveDispatchCard()
                else
                  _buildScanningRadarCard(),
              ],
            ),
          ),
        ),

        // Recent Verified Reviews
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Customer Reviews",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'reviews');
                      },
                      child: Text(
                        "View all",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF00A896),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildReviewCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
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
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.montserrat(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveDispatchCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF00A896), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00A896).withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with Timer Alert
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF00A896),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flash_on, color: Colors.amberAccent, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      "Instant Service Request",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer_outlined, color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        "45s",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Job Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prakhyat Prakhar",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Emergency Electrical Diagnostic",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: const Color(0xFF00A896),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "₹750",
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0E2A38),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.grey, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "Flat 402, Urban Estate, Patiala (0.8 km away)",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.schedule, color: Colors.grey, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      "Est. Duration: 1.5 - 2 Hours • Mutual OTP Handshake",
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red.shade700,
                          side: BorderSide(color: Colors.red.shade300),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            serviceRequest = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Service request declined. Searching for next request..."),
                            ),
                          );
                        },
                        child: Text(
                          "Decline",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A896),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'clientOnGoingJob');
                        },
                        child: Text(
                          "Accept & Navigate",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanningRadarCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF00A896).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.radar, color: Color(0xFF00A896), size: 36),
          ),
          const SizedBox(height: 12),
          Text(
            "Live Radar Active",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Listening for customer service requests within 5 km of Patiala...",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.nightlight_round, color: Colors.grey, size: 36),
          ),
          const SizedBox(height: 12),
          Text(
            "You are currently Offline",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Switch Online in the top right to start receiving instant job requests.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.power_settings_new, size: 18),
            label: Text("Go Online Now", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A896),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              setState(() {
                isOnline = true;
                serviceRequest = true;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFE0F2F1),
                child: Image.asset('assets/images/Dashboard/Profile.png'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Rohan Verma",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, color: Colors.green, size: 14),
                      ],
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(Icons.star, color: Colors.amber, size: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "2h ago",
                style: GoogleFonts.montserrat(fontSize: 11, color: Colors.grey.shade500),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Prakhyat was punctual, diagnosed the circuit fault in under 15 minutes, and solved the tripping issue professionally. Highly recommended!",
            style: GoogleFonts.montserrat(
              fontSize: 13,
              color: Colors.black87,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
