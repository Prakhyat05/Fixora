import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service/common/components/my_appbar_back_button.dart';

class FaqItem {
  final String question;
  final String answer;
  final String category;

  const FaqItem({
    required this.question,
    required this.answer,
    required this.category,
  });
}

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    "All",
    "Safety & OTP",
    "Payments & UPI",
    "KYC & Account",
    "Job Disputes",
  ];

  final List<FaqItem> _faqList = const [
    FaqItem(
      category: "Safety & OTP",
      question: "How does the dual-OTP handshake protect me?",
      answer:
          "Fixora uses a two-stage cryptographic OTP verification. Before you start work, the customer shares a 4-digit start OTP to confirm your arrival and authorize the job. Once the task is finished, a second completion OTP releases payment instantly and prevents illegitimate refund claims.",
    ),
    FaqItem(
      category: "Payments & UPI",
      question: "When are my earnings deposited to my bank account?",
      answer:
          "All job payments are settled via automated UPI transfers directly to your linked bank account within 15 minutes of completion OTP verification. You can view all transaction receipts under Drawer > View Earnings.",
    ),
    FaqItem(
      category: "Job Disputes",
      question: "What happens if a customer cancels at the doorstep?",
      answer:
          "If a customer cancels within 15 minutes of your confirmed doorstep arrival, you are automatically credited a standard ₹150 doorstep convenience fee to compensate for fuel and travel time.",
    ),
    FaqItem(
      category: "KYC & Account",
      question: "How do I update my primary services or hourly rates?",
      answer:
          "Navigate to Drawer > Manage Services. Here you can toggle individual services on or off, edit your hourly billing rates, and update your weekly working days and hours.",
    ),
    FaqItem(
      category: "Safety & OTP",
      question: "Can I accept emergency or after-hours jobs?",
      answer:
          "Yes! In your profile settings, you can define your custom operating hours. Any emergency instant requests dispatched outside standard hours carry an automated 1.5x surge rate for verified providers.",
    ),
    FaqItem(
      category: "Payments & UPI",
      question: "What are the platform commission fees?",
      answer:
          "Fixora charges an industry-low 10% platform fee on completed jobs. You can also redeem '0% Commission Weekend Passes' using your reward points in Drawer > Rewards.",
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFaqs = _faqList.where((faq) {
      final matchesSearch = faq.question.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faq.answer.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategoryIndex == 0 ||
          faq.category == _categories[_selectedCategoryIndex];
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFD6F2F2),
      appBar: AppBar(
        leading: const MyAppBarBackButton(),
        leadingWidth: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Frequently Asked Questions",
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search & Filter Container
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search questions, OTP, payments...",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF00A896), size: 22),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = "";
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          // Category Pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: List.generate(_categories.length, (index) {
                final isSelected = _selectedCategoryIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      _categories[index],
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFF00A896),
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          // FAQs Accordion List
          Expanded(
            child: Container(
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
              child: filteredFaqs.isEmpty
                  ? Center(
                      child: Text(
                        "No matching questions found.",
                        style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 14),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                      itemCount: filteredFaqs.length + 1,
                      itemBuilder: (context, index) {
                        if (index == filteredFaqs.length) {
                          // Support Banner at the bottom
                          return Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFBBF7D0)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.help_center, color: Color(0xFF00A896), size: 36),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Still need assistance?",
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        "Our 24/7 Partner Support team is ready to help.",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00A896),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'call');
                                  },
                                  child: Text(
                                    "Call Us",
                                    style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        final item = filteredFaqs[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00A896).withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.question_answer_outlined,
                                    color: Color(0xFF00A896), size: 20),
                              ),
                              title: Text(
                                item.question,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: Text(
                                    item.answer,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      height: 1.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
