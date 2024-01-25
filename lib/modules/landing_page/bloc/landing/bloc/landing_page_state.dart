part of 'landing_page_bloc.dart';

enum NavbarItem { home, chats, notifications, profile }

@immutable
abstract class LandingPageState extends Equatable {
  final NavbarItem navbarItem;
  final int tabIndex;

  const LandingPageState({required this.navbarItem, required this.tabIndex});

  @override
  List<Object?> get props => [tabIndex, navbarItem];
}

class LandingPageInitial extends LandingPageState {
  const LandingPageInitial(
      {required super.navbarItem, required super.tabIndex});
}
