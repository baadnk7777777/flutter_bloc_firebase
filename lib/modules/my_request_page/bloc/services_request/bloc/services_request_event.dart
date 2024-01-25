part of 'services_request_bloc.dart';

@immutable
abstract class ServicesRequestEvent extends Equatable {
  const ServicesRequestEvent();

  @override
  List<Object> get props => [];
}

class FetchServicesRequest extends ServicesRequestEvent {}
