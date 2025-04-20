import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/part/data/parts_data_provider.dart';
import 'package:summit_parts/features/part/model/part.dart';

final featuredPartsProvider = FutureProvider<List<Part>>((ref) async {
  return ref.read(partsDataProvider).getFeaturedParts();
});
