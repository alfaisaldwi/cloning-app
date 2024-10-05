import 'package:fast8_test/modules/tabs/bloc/navbar_event.dart';
import 'package:fast8_test/modules/tabs/bloc/navbar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavInitial()) {
    on<ToggleBottomNavEvent>((event, emit) {
      final currentState = state;
      if (currentState is BottomNavUpdated) {
        emit(BottomNavUpdated(!currentState.isExpanded, currentState.currentIndex));
      } else if (currentState is BottomNavInitial) {
        emit(BottomNavUpdated(!currentState.isExpanded, currentState.currentIndex));
      }
    });

    on<ChangeIndexEvent>((event, emit) {
      final currentState = state;
      if (currentState is BottomNavUpdated) {
        emit(BottomNavUpdated(currentState.isExpanded, event.newIndex));
      } else if (currentState is BottomNavInitial) {
        emit(BottomNavUpdated(currentState.isExpanded, event.newIndex));
      }
    });
  }


}
