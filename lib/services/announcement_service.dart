import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/announcement.dart';

class FirestoreService {
  Future<List<Announcement>> fetchAnnouncements() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('announcements')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Announcement.fromMap(doc.data()))
        .toList();
  }
}
