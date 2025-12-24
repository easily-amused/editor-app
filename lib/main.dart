import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// arcctrl_admin
// JrQt XsiF tKxA M6cg DysF Al6u

import 'app/app_gate.dart'; // <-- new
// (or wherever you put AppGate)

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WP Mobile Editor',
      theme: ThemeData.dark(useMaterial3: true),

      // ✅ AppGate handles the UX flow (connect vs editor)
      home: const AppGate(),
    );
  }
}
