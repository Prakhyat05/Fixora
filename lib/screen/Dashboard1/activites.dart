import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityItem {
  final String title;
  final String description;
  final String time;
  final String tag;
  final Color tagColor;
  final IconData icon;
  final Color iconColor;

  const ActivityItem({
    required this.title,
    required this.description,
    required this.time,
    required this.tag,
    required this.tagColor,
    required this.icon,
    required this.iconColor,
  });
}

class Activites extends StatefulWidget {
  const Activites({super.key});

  @override
  State<Activites> createState() => _ActivitesState();
}

class _ActivitesState extends State<Activites> {
  int _selectedFilter = 0;
  final List<String> _filters = ["All", "Jobs", "Handshakes", "Payouts"];

  final List<ActivityItem> _allActivities = const [
    ActivityItem(
      title: "Job Accepted — Electrical Repair",
      description: "Service request for Flat 402, Urban Estate, Patiala accepted.",
      time: "10 mins ago",
      tag: "In Progress",
      tagColor: Color(0xFF00A896),
      icon: Icons.electric_bolt,
      iconColor: Color(0xFF00A896),
    ),
    ActivityItem(
      title: "Dual-OTP Handshake Verified",
      description: "Pre-service security PIN verified successfully with customer.",
      time: "25 mins ago",
      tag: "Verified",
      tagColor: Colors.blue,
      icon: Icons.verified_user,
      iconColor: Colors.blue,
    ),
    ActivityItem(
      title: "Instant UPI Payout Credited",
      description: "₹750 credited directly to your bank account via UPI transfer.",
      time: "Yesterday, 04:30 PM",
      tag: "Settled",
      tagColor: Colors.green,
      icon: Icons.currency_rupee,
      iconColor: Colors.green,
    ),
    ActivityItem(
      title: "KYC & Banking Approved",
      description: "Aadhaar and bank IFSC verification cleared for active jobs.",
      time: "2 days ago",
      tag: "Complete",
      tagColor: Colors.indigo,
      icon: Icons.badge,
      iconColor: Colors.indigo,
    ),
    ActivityItem(
      title: "5-Star Rating Received",
      description: "Rohan Verma rated your plumbing service 5.0 with positive feedback.",
      time: "3 days ago",
      tag: "Rated 5.0",
      tagColor: Colors.amber,
      icon: Icons.star,
      iconColor: Colors.amber,
    ),
  ];

  List<ActivityItem> get _filteredActivities {
    if (_selectedFilter == 1) {
      return _allActivities.where((a) => a.tag == "In Progress").toList();
    } else if (_selectedFilter == 2) {
      return _allActivities.where((a) => a.tag == "Verified" || a.tag == "Complete").toList();
    } else if (_selectedFilter == 3) {
      return _allActivities.where((a) => a.tag == "Settled").toList();
    }
    return _allActivities;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: List.generate(_filters.length, (index) {
                final isSelected = _selectedFilter == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      _filters[index],
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFF00A896),
                    backgroundColor: const Color(0xFFF0F4F8),
                    checkmarkColor: Colors.white,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = index;
                      });
                    },
                  ),
                );
              }),
            ),
          ),
          // Activities List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filteredActivities.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFE5E7EB)),
              itemBuilder: (context, index) {
                final activity = _filteredActivities[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: activity.iconColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(activity.icon, color: activity.iconColor, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    activity.title,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: activity.tagColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    activity.tag,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: activity.tagColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              activity.description,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black54,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              activity.time,
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                color: Colors.grey.shade500,
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
          ),
        ],
      ),
    );
  }
}
