import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';

class GutenbergJsParser {
  GutenbergJsParser(this._runtime);

  final JavascriptRuntime _runtime;
  bool _loaded = false;

  Future<void> ensureLoaded() async {
    if (_loaded) return;
    final js = await rootBundle.loadString('assets/editor/bundle.js');
    _runtime.evaluate(js);
    _loaded = true;
  }

  /// Returns a JSON-serializable list of WP block maps (as Gutenberg outputs).
  Future<List<dynamic>> parseBlocks(String raw) async {
    await ensureLoaded();

    // Safest is to pass a JSON-encoded string into JS to avoid escaping hell.
    final rawJson = jsonEncode(raw);

    final result = _runtime.evaluate("""
      (function() {
        const raw = $rawJson;
        const blocks = globalThis.GutenbergParser.parseBlocks(raw);
        return JSON.stringify(blocks);
      })();
    """);

    final jsonString = result.stringResult;
    final decoded = jsonDecode(jsonString);

    if (decoded is List) return decoded;
    return const [];
  }
}
