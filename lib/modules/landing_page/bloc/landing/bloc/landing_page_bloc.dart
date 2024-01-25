import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'landing_page_event.dart';
part 'landing_page_state.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  LandingPageBloc()
      : super(
          const LandingPageInitial(tabIndex: 0, navbarItem: NavbarItem.home),
        ) {
    on<TabChange>(_getNavBarItem);
  }

  _getNavBarItem(TabChange event, Emitter emit) {
    switch (event.navbarItem) {
      case NavbarItem.home:
        emit(
          const LandingPageInitial(navbarItem: NavbarItem.home, tabIndex: 0),
        );

      case NavbarItem.chats:
        emit(
          const LandingPageInitial(navbarItem: NavbarItem.chats, tabIndex: 1),
        );

        break;
      default:
    }
  }
}
