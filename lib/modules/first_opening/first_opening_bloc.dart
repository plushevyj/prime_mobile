import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'first_opening_event.dart';
part 'first_opening_state.dart';

class FirstOpeningBloc extends Bloc<FirstOpeningEvent, FirstOpeningState> {
  FirstOpeningBloc() : super(const FirstOpeningInitial()) {
    on<CheckOpeningEvent>(_checkOpeningEvent);
  }

  void _checkOpeningEvent(
      CheckOpeningEvent event, Emitter<FirstOpeningState> emit) async {
    var box = Hive.box('first_opening_box');
    print(box.get('first_opening_box'));
  }
}
