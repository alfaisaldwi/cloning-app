abstract class HomeState {
  final bool isPayungPribadi;
  HomeState(this.isPayungPribadi);
}

class InitialState extends HomeState {
  InitialState() : super(true);
}

class ToggledState extends HomeState {
  ToggledState(bool isPayungPribadi) : super(isPayungPribadi);
}
