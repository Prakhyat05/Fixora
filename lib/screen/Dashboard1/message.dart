import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service/common/constants/string.dart';

class ConversationItem {
  final String name;
  final String role;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final bool isSupport;

  const ConversationItem({
    required this.name,
    required this.role,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    this.isSupport = false,
  });
}

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<ConversationItem> _conversations = const [
    ConversationItem(
      name: "Prakhyat Prakhar",
      role: "Client • Urban Estate",
      lastMessage: "Hi Prakhyat, yes! I'm around 5 minutes away, just approaching Main Market.",
      time: "09:16 AM",
      unreadCount: 1,
      isOnline: true,
    ),
    ConversationItem(
      name: "Anita Sharma",
      role: "Client • Model Town",
      lastMessage: "Please bring a 16A switch socket if possible. The old one is burnt.",
      time: "Yesterday",
      unreadCount: 0,
      isOnline: false,
    ),
    ConversationItem(
      name: "Fixora Support Desk",
      role: "Official Support Partner",
      lastMessage: "Your monthly partner reward voucher is active! Tap here to claim.",
      time: "Nov 22",
      unreadCount: 0,
      isOnline: true,
      isSupport: true,
    ),
    ConversationItem(
      name: "Vikram Singh",
      role: "Client • Phase 2",
      lastMessage: "Thanks for fixing the main breaker so promptly! Left a 5-star review.",
      time: "Nov 20",
      unreadCount: 0,
      isOnline: false,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _conversations.where((c) {
      final q = _searchQuery.toLowerCase();
      return c.name.toLowerCase().contains(q) ||
          c.lastMessage.toLowerCase().contains(q);
    }).toList();

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search chats & clients...",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
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
          // Conversation List
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Text(
                      "No messages found",
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    itemCount: filteredList.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: Color(0xFFF3F4F6)),
                    itemBuilder: (context, index) {
                      final chat = filteredList[index];
                      return InkWell(
                        onTap: () {
                          if (chat.isSupport) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Row(
                                  children: [
                                    const Icon(Icons.support_agent, color: Color(0xFF00A896)),
                                    const SizedBox(width: 8),
                                    Text("Fixora Support", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                content: Text(
                                  "Fixora Partner Care is available 24/7.\nCall: +91 1800-FIXORA-01\nEmail: support@fixora.com",
                                  style: GoogleFonts.montserrat(fontSize: 13),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text("Close"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00A896),
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                      Navigator.pushNamed(context, 'call');
                                    },
                                    child: const Text("Call Support"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            Navigator.pushNamed(context, 'chat');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 26,
                                    backgroundColor: const Color(0xFFE0F2F1),
                                    child: chat.isSupport
                                        ? const Icon(Icons.support_agent, color: Color(0xFF00A896), size: 28)
                                        : Image.asset(profileImage, width: 44, height: 44),
                                  ),
                                  if (chat.isOnline)
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 13,
                                        height: 13,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          chat.name,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: chat.unreadCount > 0 ? FontWeight.bold : FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          chat.time,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 11,
                                            color: chat.unreadCount > 0
                                                ? const Color(0xFF00A896)
                                                : Colors.grey.shade500,
                                            fontWeight: chat.unreadCount > 0
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      chat.role,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 11,
                                        color: chat.isSupport
                                            ? const Color(0xFF00A896)
                                            : Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            chat.lastMessage,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              color: chat.unreadCount > 0
                                                  ? Colors.black87
                                                  : Colors.grey.shade600,
                                              fontWeight: chat.unreadCount > 0
                                                  ? FontWeight.w500
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        if (chat.unreadCount > 0)
                                          Container(
                                            margin: const EdgeInsets.only(left: 6),
                                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF00A896),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              "${chat.unreadCount}",
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
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
