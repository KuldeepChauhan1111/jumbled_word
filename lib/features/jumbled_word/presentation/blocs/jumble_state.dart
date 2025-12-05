abstract class JumbleState {}

class JumbleInitial extends JumbleState {}

class JumbleLoading extends JumbleState {}

class JumbleLoaded extends JumbleState {
  final List<String> words;
  JumbleLoaded(this.words);
}

class JumbleEmpty extends JumbleState {}

class JumbleError extends JumbleState {
  final String message;
  JumbleError(this.message);
}

