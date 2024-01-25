import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/models/services_request.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/repositories/services_request_repo.dart';

class ServicesRequestRepositoryImpl implements ServicesRequestRepository {
  final FirebaseClient _firebaseClient;

  ServicesRequestRepositoryImpl({required FirebaseClient firebaseClient})
      : _firebaseClient = firebaseClient;

  @override
  Future<Either<String, List<ServicesRequest>>> getServicesRequestAll() async {
    try {
      final List<ServicesRequest> request =
          await _firebaseClient.getAllServicesRequest();
      return Right(request);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
