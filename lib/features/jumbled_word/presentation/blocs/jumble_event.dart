abstract class JumbleEvent {}

class SearchJumbledEvent extends JumbleEvent {
  final String word;

  SearchJumbledEvent(this.word);

}
