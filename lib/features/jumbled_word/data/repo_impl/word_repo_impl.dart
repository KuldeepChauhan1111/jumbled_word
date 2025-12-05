import 'package:jumbled_word/features/jumbled_word/data/datasoruce/loacl_word_datasource.dart';
import 'package:jumbled_word/features/jumbled_word/data/models/word_model.dart';
import 'package:jumbled_word/features/jumbled_word/domain/entities/word_entity.dart';
import 'package:jumbled_word/features/jumbled_word/domain/repo/word_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordRepositoryImpl implements WordRepository {
  final LocalWordDataSource dataSource;

  WordRepositoryImpl(this.dataSource);

  @override
  Future<List<WordEntity>> solveJumble(String input) async {
    final allWords = await dataSource.loadWords();
    final inputFreq = _charFrequency(input);

    final matches = <WordModel>[];

    for (final word in allWords) {
      if (word.length != input.length) continue;

      if (_isSameFrequency(inputFreq, _charFrequency(word))) {
        matches.add(WordModel(word));
      }
    }

    matches.sort((a, b) => a.word.compareTo(b.word));
    return matches;
  }

  Map<String, int> _charFrequency(String word) {
    final map = <String, int>{};

    for (final ch in word.split('')) {
      map[ch] = (map[ch] ?? 0) + 1;
    }

    return map;
  }

  bool _isSameFrequency(Map<String, int> a, Map<String, int> b) {
    if (a.length != b.length) return false;

    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }

    return true;
  }


}
