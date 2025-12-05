import 'package:jumbled_word/features/jumbled_word/domain/entities/word_entity.dart';

abstract class WordRepository {
  Future<List<WordEntity>> solveJumble(String input);
}
