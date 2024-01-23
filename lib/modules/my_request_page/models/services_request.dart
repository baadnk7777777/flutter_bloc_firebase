import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesRequest {
  final String? id;
  final Timestamp timestamp;
  final String issue;
  final String serviceType;
  final String status;
  final int rating;

  ServicesRequest({
    required this.issue,
    required this.serviceType,
    required this.status,
    required this.rating,
    required this.timestamp,
    this.id,
  });
  factory ServicesRequest.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ServicesRequest(
      id: snapshot.id,
      issue: data['issue'] ?? '',
      serviceType: data['service_type'] ?? '',
      status: data['status'] ?? '',
      rating: data['rating'] ?? 0,
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
