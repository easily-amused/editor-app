import 'wp_block.dart';

extension ColumnsAttributes on WpBlock {
  List<double>? get columnWidths {
    final v = attributes['columnWidths'];
    if (v is List) {
      return v.whereType<num>().map((e) => e.toDouble()).toList();
    }
    return null;
  }

  WpBlock withColumnWidths(List<double> widths) {
    return copyWith(
      attributes: {
        ...attributes,
        'columnWidths': widths,
      },
    );
  }
}
