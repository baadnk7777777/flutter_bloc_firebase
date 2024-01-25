import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/models/services_request.dart';

abstract class AddRequestRepository {
  Future<void> addRequest(
      String issue, String uId, int rating, String serviceType, String status);
}
