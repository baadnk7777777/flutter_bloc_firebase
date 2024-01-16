part of 'database_bloc.dart';

sealed class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

class DatabaseFetched extends DatabaseEvent {
  final String? displayName;

  const DatabaseFetched(this.displayName);

  @override
  List<Object> get props => [displayName!];
}
