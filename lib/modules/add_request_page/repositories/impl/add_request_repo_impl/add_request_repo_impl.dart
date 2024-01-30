import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/add_request_page/repositories/add_request_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/models/services_request.dart';
import 'package:flutter_bloc_firebase_2/network/firebase_network.dart';
import 'package:flutter_bloc_firebase_2/utils/custom_logger.dart';

class AddRequestRepositoyImpl implements AddRequestRepository {
  final FirebaseNetwork _firebaseClient;

  AddRequestRepositoyImpl({required FirebaseNetwork firebaseClient})
      : _firebaseClient = firebaseClient;

  @override
  Future<void> addRequest(String issue, String uId, int rating,
      String serviceType, String status) async {
    try {
      await _firebaseClient.addRequest(issue, uId, rating, serviceType, status);
      AppLogger.log(serviceType, 'On request submitted', '✅');
    } catch (e) {
      AppLogger.logE('Failed to add request', 'AddRequest', '');
    }
  }
}
