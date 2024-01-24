part of 'add_request_bloc.dart';

class AddRequestState extends Equatable {
  const AddRequestState({
    // this.addRequestsList = const <ServicesRequest>[],
    this.status = StateStatus.initial,
    this.issue = '',
    this.serviceType = '',
    this.rating = 0,
    this.isFormValid = false,
    this.timestamp,
    this.uId = '',
  });

  AddRequestState copyWith({
    StateStatus? status,
    String? issue,
    String? serviceType,
    int? rating,
    bool? isFormValid,
    Timestamp? timestamp,
    String? uId,
  }) =>
      AddRequestState(
        status: status ?? this.status,
        issue: issue ?? this.issue,
        serviceType: serviceType ?? this.serviceType,
        rating: rating ?? this.rating,
        isFormValid: isFormValid ?? this.isFormValid,
        timestamp: timestamp ?? this.timestamp,
        uId: uId ?? this.uId,
      );

  // final List<ServicesRequest> addRequestsList;
  final StateStatus status;
  final String issue;
  final String serviceType;
  final int rating;
  final bool isFormValid;
  final Timestamp? timestamp;
  final String uId;

  @override
  List<Object?> get props => [status, issue, serviceType, isFormValid, uId];
}

final class AddRequestInitial extends AddRequestState {}
