import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'document_source.dart';
import '../models/wp_document.dart';

final documentSourceProvider = Provider<DocumentSource>((ref) {
  return DocumentSource();
});

final initialDocumentProvider = FutureProvider<WpDocument>((ref) async {
  final source = ref.read(documentSourceProvider);
  return source.fetchInitialDocument();
});
