import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/note_repo.dart';
import 'state/note_provider.dart';
import 'ui/home_screen.dart';
import 'services/notification_service.dart';

final notificationServiceProvider =
    Provider<NotificationService>((ref) => throw UnimplementedError());


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repo = NoteRepo();
  await repo.init();

  final notifications = NotificationService();
  await notifications.init();


  runApp(
    ProviderScope(
      overrides: [
        noteRepoProvider.overrideWithValue(repo),
        notificationServiceProvider.overrideWithValue(notifications),
      ],
      child: const SnapNoteApp(),
    ),
  );
}

class SnapNoteApp extends StatelessWidget {
  const SnapNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapNote',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
