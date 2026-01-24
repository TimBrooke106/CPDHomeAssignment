import 'package:flutter/material.dart';
import 'add_note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SnapNote")),
      body: const Center(
        child: Text("Home Screen (Notes list goes here)"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add note",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNoteScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
