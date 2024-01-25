import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/models/services_request.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/repositories/impl/services_request_repo_impl.dart';

part 'services_request_event.dart';
part 'services_request_state.dart';

class ServicesRequestBloc
    extends Bloc<ServicesRequestEvent, ServicesRequestState> {
  final ServicesRequestRepositoryImpl servicesRequestRepositoryImpl;
  ServicesRequestBloc({required this.servicesRequestRepositoryImpl})
      : super(ServicesRequestInitial()) {
    on<FetchServicesRequest>(_onFetchServicesRequest);
  }

  Future<void> _onFetchServicesRequest(
      FetchServicesRequest event, Emitter emit) async {
    emit(state.copyWith(
      status: StateStatus.loading,
    ));

    final Either<String, List<ServicesRequest>> result =
        await servicesRequestRepositoryImpl.getServicesRequestAll();
    result.fold(
        (left) => emit(state.copyWith(
              status: StateStatus.failure,
              servicesRequestList: <ServicesRequest>[],
            )), (List<ServicesRequest> right) {
      List<ServicesRequest> newRequest = right
          .where((newRequest) => !state.servicesRequestList
              .any((exitstingRequest) => newRequest.id == exitstingRequest.id))
          .toList();
      emit(state.copyWith(
        status: StateStatus.success,
        servicesRequestList: List.from(state.servicesRequestList)
          ..addAll(newRequest),
      ));
    });
  }
}
