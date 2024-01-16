part of 'database_bloc.dart';

sealed class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object> get props => [];
}

final class DatabaseInitial extends DatabaseState {}

class DatabaseSuccess extends DatabaseState {
  final List<UserModel> listOfuserData;
  final String? displayName;

  const DatabaseSuccess(
      {required this.listOfuserData, required this.displayName});

  @override
  List<Object> get props => [listOfuserData, displayName!];
}

class DatabaseError extends DatabaseState {
  @override
  List<Object> get props => [];
}
