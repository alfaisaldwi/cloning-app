abstract class BottomNavState {
  final bool isExpanded;
  final int currentIndex;

  BottomNavState(this.isExpanded, this.currentIndex);
}

class BottomNavInitial extends BottomNavState {
  BottomNavInitial() : super(false, 0);
}

class BottomNavUpdated extends BottomNavState {
  BottomNavUpdated(bool isExpanded, int currentIndex) : super(isExpanded, currentIndex);
}