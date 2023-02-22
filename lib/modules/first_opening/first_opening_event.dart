part of 'first_opening_bloc.dart';

abstract class FirstOpeningEvent extends Equatable {
  const FirstOpeningEvent();

  @override
  List<Object> get props => [];
}

class CheckOpeningEvent extends FirstOpeningEvent {
  const CheckOpeningEvent();
}
