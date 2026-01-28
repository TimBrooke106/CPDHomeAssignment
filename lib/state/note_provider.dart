import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/note_repo.dart';
import '../models/note.dart';

final noteRepoProvider = Provider<NoteRepo>((ref) => NoteRepo());

final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>((ref) {
  final repo = ref.read(noteRepoProvider);
  return NotesNotifier(repo);
});

class NotesNotifier extends StateNotifier<List<Note>> {
  final NoteRepo repo;

  NotesNotifier(this.repo) : super([]) {
    // Auto-load on startup (safe, runs after provider is ready)
    Future.microtask(load);
  }

  Future<void> load() async {
    state = repo.getAll();
  }

  Future<void> add(Note note) async {
    await repo.upsert(note);
    state = repo.getAll();
  }

  Future<void> remove(String id) async {
    await repo.delete(id);
    state = repo.getAll();
  }
}

  