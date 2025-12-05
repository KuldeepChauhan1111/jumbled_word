import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumbled_word/core/widgets/custom_text_form_field.dart';
import 'package:jumbled_word/features/jumbled_word/presentation/blocs/jumble_bloc.dart';
import 'package:jumbled_word/features/jumbled_word/presentation/blocs/jumble_event.dart';
import 'package:jumbled_word/features/jumbled_word/presentation/blocs/jumble_state.dart';
import 'package:jumbled_word/features/jumbled_word/presentation/pages/history_page.dart';

class JumbleWordPage extends StatefulWidget {
  const JumbleWordPage({super.key});

  @override
  State<JumbleWordPage> createState() => _JumbleWordPageState();
}

class _JumbleWordPageState extends State<JumbleWordPage> {


  final TextEditingController jumbledController = TextEditingController();


  void _onSearch() {
    final input = jumbledController.text.trim();

    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a word")),
      );
      return;
    }

    context.read<JumbleBloc>().add(SearchJumbledEvent(input));
  }

  @override
  void dispose() {
    jumbledController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Enter Jumbled Word",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  IconButton(onPressed: () {  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HistoryPage()),
                  );

                  }, icon: Icon(Icons.history))
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: jumbledController,
                inputFormatterRegex: r'[a-zA-Z]',
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    elevation: 0,
                    fixedSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Solve",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<JumbleBloc, JumbleState>(
                builder: (context, state) {
                  if (state is JumbleInitial) {
                    return const Center(child: Text("Enter a jumbled word"));
                  }
                  if (state is JumbleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is JumbleError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  if (state is JumbleEmpty) {
                    return const Center(child: Text("No matching words found"));
                  }
                  if (state is JumbleLoaded) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Result (${state.words.length} Matches)",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.words.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(state.words[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
