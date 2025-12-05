import 'package:flutter/material.dart';
import 'package:jumbled_word/core/storage/local_cache.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  String? word;
  List<String>? results;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data = await LocalCache.getLastSearch();

    if (data != null) {
      word = data['input'];
      results = List<String>.from(data['result']);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Last Search")),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : word == null
          ? const Center(child: Text("No history found"))
          : Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Searched Word: $word",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 15),

            Text("Results (${results!.length})",
                style: const TextStyle(fontWeight: FontWeight.w600)),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: results!.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(results![index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
