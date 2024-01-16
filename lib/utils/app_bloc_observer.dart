import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    // เมธอทนี้ถูกเรียกเมื่อ Bloc มีการเปลี่ยนแปลงสถานะ เป็นส่วนนึงในการติดตามสถานะของ Bloc.
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // เมธอทนี้จะถูกเรียกเมื่อเกิดการเปลี่ยนแปลงสถานะ Transition.

    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print(error);
  }
}
