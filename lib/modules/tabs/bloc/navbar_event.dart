abstract class BottomNavEvent {}

class ToggleBottomNavEvent extends BottomNavEvent {}

class ChangeIndexEvent extends BottomNavEvent {
  final int newIndex;

  ChangeIndexEvent(this.newIndex);
}