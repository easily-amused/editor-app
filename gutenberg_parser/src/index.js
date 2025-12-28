import { parse } from '@wordpress/block-serialization-default-parser';

// Expose a stable global API Flutter can call.
function parseBlocks(raw) {
  // returns an array of WP block objects
  const blocks = parse(raw ?? '');
  return blocks;
}

globalThis.GutenbergParser = { parseBlocks };
