import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/modules/add_request_page/repositories/impl/add_request_repo_impl/add_request_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/get_start_page/get_start_import.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/models/services_request.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/repositories/impl/services_request_repo_impl.dart';

part 'add_request_event.dart';
part 'add_request_state.dart';

class AddRequestBloc extends Bloc<AddRequestEvent, AddRequestState> {
  final AddRequestRepositoyImpl addRequestRepositoyImpl;
  AddRequestBloc({required this.addRequestRepositoyImpl})
      : super(AddRequestInitial()) {
    on<AddRequest>(_onAddRequest);
    on<RequestTypeChanged>(_onRequestTypeChanged);
    on<RequestIssuesChanged>(_onRequestIssuesChanged);
    on<RequestSubmitted>(_onRequestSubmitted);
  }

  void _onAddRequest(AddRequest event, Emitter<AddRequestState> emit) {}
  void _onRequestTypeChanged(
      RequestTypeChanged event, Emitter<AddRequestState> emit) {
    emit(state.copyWith(
      status: StateStatus.initial,
      serviceType: event.type,
    ));
  }

  void _onRequestIssuesChanged(
      RequestIssuesChanged event, Emitter<AddRequestState> emit) {
    emit(state.copyWith(
      status: StateStatus.initial,
      issue: event.issues,
    ));
  }

  void _onRequestSubmitted(
      RequestSubmitted event, Emitter<AddRequestState> emit) async {
    emit(
      state.copyWith(
        status: StateStatus.loading,
        isFormValid: state.serviceType.isNotEmpty && state.issue.isNotEmpty,
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (state.isFormValid) {
      addRequestRepositoyImpl.addRequest(
          state.issue, event.uId, state.rating, state.serviceType, 'waiting');

      emit(state.copyWith(
        status: StateStatus.success,
        issue: '',
        serviceType: '',
        isFormValid: false,
      ));
    } else {
      emit(state.copyWith(
        status: StateStatus.failure,
        isFormValid: false,
      ));
    }
  }
}
