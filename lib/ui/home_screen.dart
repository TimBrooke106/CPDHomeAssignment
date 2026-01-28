import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/note_provider.dart';
import 'add_note_screen.dart';
import 'dart:io';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("SnapNote")),
      body: notes.isEmpty
          ? const Center(child: Text("No notes yet. Tap + to add one."))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, i) {
                final n = notes[i];
                return ListTile(
                  leading: (n.imagePath == null)
                  ? const Icon(Icons.note)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(
                        File(n.imagePath!),
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                  title: Text(n.title),
                  subtitle: Text(
                    n.body,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    tooltip: "Delete note",
                    icon: const Icon(Icons.delete),
                    onPressed: () => ref.read(notesProvider.notifier).remove(n.id),
                  ),
                );
              },
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
