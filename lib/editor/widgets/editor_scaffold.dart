import 'package:flutter/material.dart';

class EditorScaffold extends StatelessWidget {
  const EditorScaffold({
    super.key,
    required this.appBar,
    required this.body,
  });

  final PreferredSizeWidget appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
