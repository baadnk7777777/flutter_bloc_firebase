part of 'landing_page_bloc.dart';

@immutable
abstract class LandingPageEvent extends Equatable {}

class TabChange extends LandingPageEvent {
  final int tabIndex;
  final NavbarItem navbarItem;
  TabChange(this.navbarItem, {required this.tabIndex});
  @override
  List<Object?> get props => [tabIndex];
}
