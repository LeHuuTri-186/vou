abstract class BottomNavEvent {}

class UpdateTab extends BottomNavEvent {
  final int index;
  UpdateTab(this.index);
}



