import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumbled_word/features/jumbled_word/data/datasoruce/loacl_word_datasource.dart';
import 'package:jumbled_word/features/jumbled_word/data/repo_impl/word_repo_impl.dart';
import 'package:jumbled_word/features/jumbled_word/domain/usecase/solve_jumble_word.dart';
import 'package:jumbled_word/features/jumbled_word/presentation/blocs/jumble_bloc.dart';
import 'package:jumbled_word/features/jumbled_word/presentation/pages/jumble_word_page.dart';


void main() async{
  final repository = WordRepositoryImpl(LocalWordDataSource());
  final solveJumbleWord = SolveJumbleWord(repository);

  runApp(  BlocProvider(
    create: (_) => JumbleBloc(solveJumbleWord,repository),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jumbled Word Solver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: JumbleWordPage(),
      debugShowCheckedModeBanner: false,
    );
  }

}
