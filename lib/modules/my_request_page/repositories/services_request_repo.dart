import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/models/services_request.dart';

abstract class ServicesRequestRepository {
  Future<Either<String, List<ServicesRequest>>> getServicesRequestAll();
}
