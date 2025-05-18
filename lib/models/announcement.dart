import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String recipient;
  final String title;
  final String message;
  final DateTime timestamp;

  Announcement({
    required this.recipient,
    required this.title,
    required this.message,
    required this.timestamp,
  });

  factory Announcement.fromMap(Map<String, dynamic> data) {
    return Announcement(
      recipient: data['recipient'] ?? 'Unknown',
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
