part of 'bottom_nav_bloc.dart';

/// All events of Localization
abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object?> get props => [];
}

/// Event when user tries to change localization
class ChangeTab extends BottomNavEvent {
  const ChangeTab(this.selectedTab);
  final int selectedTab;

  @override
  List<Object> get props => [selectedTab];
}

