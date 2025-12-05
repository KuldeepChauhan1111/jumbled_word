import 'package:jumbled_word/features/jumbled_word/domain/entities/word_entity.dart';
import 'package:jumbled_word/features/jumbled_word/domain/repo/word_repo.dart';

class SolveJumbleWord {
  final WordRepository wordRepo;

  SolveJumbleWord(this.wordRepo);

  Future<List<WordEntity>> call(String input) {
    return wordRepo.solveJumble(input);
  }
}
