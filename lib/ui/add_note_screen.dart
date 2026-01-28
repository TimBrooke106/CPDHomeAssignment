import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/note.dart';
import '../state/note_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class AddNoteScreen extends ConsumerStatefulWidget {
  const AddNoteScreen({super.key});

  @override
  ConsumerState<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends ConsumerState<AddNoteScreen> {
  final _title = TextEditingController();
  final _body = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }


  final _picker = ImagePicker();
  String? _imagePath;

  Future<void> _takePhoto() async {
    final img = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    if (img == null) return;
    setState(() => _imagePath = img.path);
  }

  Future<void> _save() async {
    final title = _title.text.trim();
    final body = _body.text.trim();

    if (title.isEmpty) return;

    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      imagePath: _imagePath,
      createdAt: DateTime.now(),
    );

    await ref.read(notesProvider.notifier).add(note);

    if (mounted) Navigator.pop(context);



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(labelText: "Title"),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _body,
              decoration: const InputDecoration(labelText: "Body"),
              maxLines: 4,
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Take photo"),
                ),
                const SizedBox(width: 12),
                if (_imagePath != null) const Text("Photo attached"),
              ],
            ),
            const SizedBox(height: 12),
            if (_imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(_imagePath!),
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
