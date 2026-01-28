import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class NoteRepo {
  static const boxName = "notesBox";

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  Box get _box => Hive.box(boxName);

  List<Note> getAll() {
    final values = _box.values.toList();
    final notes = values
        .map((e) => Note.fromMap(Map<dynamic, dynamic>.from(e)))
        .toList();
    notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return notes;
  }

  Future<void> upsert(Note note) async {
    await _box.put(note.id, note.toMap());
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }
}
