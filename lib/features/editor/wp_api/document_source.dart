import 'dart:async';
import 'package:uuid/uuid.dart';

import '../models/wp_block.dart';
import '../models/wp_document.dart';
import '../registry/block_registry.dart';

/// Simulates fetching a post from WP REST API.
/// Later: replace with real WP API calls (wp/v2/posts + raw content parsing).
class DocumentSource {
  final _uuid = const Uuid();

  Future<WpDocument> fetchInitialDocument() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 350));

    final heading = WpBlock(
      clientId: _uuid.v4(),
      name: CoreBlockNames.heading,
      attributes: {'content': 'API-loaded Post', 'level': 2},
    );

    final intro = WpBlock(
      clientId: _uuid.v4(),
      name: CoreBlockNames.paragraph,
      attributes: {
        'content':
            'This document was "loaded" from an API. Edit me. Tap blocks to select. Switch Layout Mode to see container chrome.',
      },
    );

    final col1 = WpBlock(
      clientId: _uuid.v4(),
      name: CoreBlockNames.column,
      innerBlocks: [
        WpBlock(
          clientId: _uuid.v4(),
          name: CoreBlockNames.paragraph,
          attributes: {'content': 'Left column paragraph (short).'},
        ),
        WpBlock(
          clientId: _uuid.v4(),
          name: CoreBlockNames.paragraph,
          attributes: {'content': 'Second paragraph in left column.'},
        ),
      ],
    );

    final col2 = WpBlock(
      clientId: _uuid.v4(),
      name: CoreBlockNames.column,
      innerBlocks: [
        WpBlock(
          clientId: _uuid.v4(),
          name: CoreBlockNames.paragraph,
          attributes: {
            'content':
                'Right column paragraph (longer) to verify uneven column content rendering and editing.',
          },
        ),
      ],
    );

    final columns = WpBlock(
      clientId: _uuid.v4(),
      name: CoreBlockNames.columns,
      attributes: {
        'columnWidths': [0.4, 0.6],
        'isStackedOnMobile': true,
      },
      innerBlocks: [col1, col2],
    );

    final outro = WpBlock(
      clientId: _uuid.v4(),
      name: CoreBlockNames.paragraph,
      attributes: {'content': 'Outro paragraph below the columns.'},
    );

    return WpDocument(blocks: [heading, intro, columns, outro]);
  }
}
