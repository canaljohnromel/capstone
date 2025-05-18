import 'package:capstone/compose_screen.dart';
import 'package:capstone/menu.dart';
import 'package:capstone/models/announcement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Announcement? selectedAnnouncement;

String timeAgo(DateTime date) {
  final Duration diff = DateTime.now().difference(date);
  if (diff.inMinutes < 1) return 'Just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
}

Future<List<Announcement>> fetchAnnouncements() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('announcements')
      .orderBy('timestamp', descending: true)
      .get();

  return snapshot.docs
      .map((doc) => Announcement.fromMap(doc.data()))
      .toList();
}

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  Announcement? selectedAnnouncement;

  // Time ago helper
  String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Row(
        children: [
          SidebarMenu(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pages / Announcements',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey[400])),
                  const SizedBox(height: 0),
                  Text('Announcements',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  Expanded(
                    child: Row(
                      children: [
                        // LEFT PANEL
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                // Search bar
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2A2A2A),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.search, color: Colors.white),
                                      border: InputBorder.none,
                                      hintText: 'Search by chats and people',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Announcements list with StreamBuilder
                                Expanded(
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('announcements')
                                        .orderBy('timestamp', descending: true)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                        return const Center(child: Text('No announcements yet', style: TextStyle(color: Colors.grey)));
                                      }

                                      final announcements = snapshot.data!.docs.map((doc) {
                                        final data = doc.data() as Map<String, dynamic>;
                                        return Announcement.fromMap(data);
                                      }).toList();

                                      return ListView.builder(
                                        itemCount: announcements.length,
                                        itemBuilder: (context, index) {
                                          final ann = announcements[index];
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedAnnouncement = ann;
                                              });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(vertical: 8),
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF121212),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        ann.title,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        timeAgo(ann.timestamp),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey[500],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    ann.message,
                                                    style: TextStyle(color: Colors.grey[400]),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Text(
                                                      ann.recipient,
                                                      style: TextStyle(color: Colors.grey[500]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),

                                // Compose button
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2A2A2A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                    onPressed: () {
                                      // open compose dialog
                                    },
                                    icon: const Icon(Icons.add, color: Colors.white),
                                    label: const Text(
                                      'Compose',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // RIGHT PANEL
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: selectedAnnouncement == null
                                ? const Center(
                              child: Text(
                                'Select an announcement to view details.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                                : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedAnnouncement!.title,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  timeAgo(selectedAnnouncement!.timestamp),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Divider(color: Colors.grey),
                                const SizedBox(height: 16),
                                Text(
                                  selectedAnnouncement!.message,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'Recipient: ${selectedAnnouncement!.recipient}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}