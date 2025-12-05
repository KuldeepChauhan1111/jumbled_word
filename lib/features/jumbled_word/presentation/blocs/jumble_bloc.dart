import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumbled_word/core/storage/local_cache.dart';
import 'package:jumbled_word/features/jumbled_word/domain/repo/word_repo.dart';
import 'package:jumbled_word/features/jumbled_word/domain/usecase/solve_jumble_word.dart';
import 'jumble_event.dart';
import 'jumble_state.dart';

class JumbleBloc extends Bloc<JumbleEvent, JumbleState> {
  final SolveJumbleWord solveJumbleWord;
  final WordRepository wordRepository;


  JumbleBloc(this.solveJumbleWord,this.wordRepository) : super(JumbleInitial()) {
    on<SearchJumbledEvent>(_onSearch);

  }

  void _onSearch(SearchJumbledEvent event, Emitter emit) async {
    emit(JumbleLoading());

    final input = event.word.toLowerCase();

    final results = await solveJumbleWord(input);

    if (results.isEmpty) {
      emit(JumbleEmpty());
    } else {
      await LocalCache.saveLastSearch(event.word, results.map((e) => e.word).toList());

      emit(JumbleLoaded(results.map((e) => e.word).toList()));
    }
  }

}
