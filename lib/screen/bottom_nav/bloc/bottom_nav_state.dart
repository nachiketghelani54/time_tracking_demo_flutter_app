part of 'bottom_nav_bloc.dart';

/// State when user tries to change localization
abstract class BottomNavState extends Equatable {
   BottomNavState(this.selectedTab);

   int selectedTab = 0;

  @override
  List<Object?> get props => [selectedTab];
}

class LoadingState extends BottomNavState {
  LoadingState(super.selectedTab);


  @override
  List<Object> get props => [];
}

class BottomNavSuccess extends BottomNavState {
   BottomNavSuccess({int? locale}) : super(locale!);

  @override
  List<Object?> get props => [selectedTab];
}

class BottomNavError extends BottomNavState {
   BottomNavError({this.errorMessage}) : super(0);

  final String? errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
