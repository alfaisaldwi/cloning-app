import 'package:fast8_test/modules/home/bloc/home_event.dart';
import 'package:fast8_test/modules/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<TogglePayungEvent>((event, emit) {
      emit(ToggledState(!state.isPayungPribadi));
    });
  }
}
