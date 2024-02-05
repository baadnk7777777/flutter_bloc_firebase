import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/database_repo.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;

  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseFetched>(_fetchUserData);
  }

  _fetchUserData(DatabaseFetched event, Emitter<DatabaseState> emit) async {
    List<UserModel> listOfUserData =  await _databaseRepository.retrieveUserData();
    emit(DatabaseSuccess( listOfuserData: listOfUserData, displayName: event.displayName));
  }
}
