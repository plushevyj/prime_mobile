part of 'first_opening_bloc.dart';

abstract class FirstOpeningState extends Equatable {
  const FirstOpeningState();

  @override
  List<Object> get props => [];
}

class FirstOpeningInitial extends FirstOpeningState {
  const FirstOpeningInitial();
}

class FirstOpeningApplication extends FirstOpeningState {
  const FirstOpeningApplication(this.firstOpening);
  final bool firstOpening;

  @override
  List<Object> get props => [firstOpening];
}
