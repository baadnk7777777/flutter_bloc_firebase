part of 'services_request_bloc.dart';

class ServicesRequestState extends Equatable {
  final List<ServicesRequest> servicesRequestList;
  final StateStatus status;

  const ServicesRequestState({
    this.servicesRequestList = const <ServicesRequest>[],
    this.status = StateStatus.initial,
  });

  ServicesRequestState copyWith({
    List<ServicesRequest>? servicesRequestList,
    StateStatus? status,
  }) =>
      ServicesRequestState(
        servicesRequestList: servicesRequestList ?? this.servicesRequestList,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [servicesRequestList, status];
}

final class ServicesRequestInitial extends ServicesRequestState {}
