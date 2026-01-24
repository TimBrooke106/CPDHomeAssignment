import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: SnapNoteApp()));
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
