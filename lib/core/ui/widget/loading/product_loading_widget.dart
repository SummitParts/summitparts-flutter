import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductLoadingWidget extends StatelessWidget {
  const ProductLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.outlineVariant,
      highlightColor: Theme.of(context).colorScheme.surfaceBright,
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width / 2.6,
            height: MediaQuery.sizeOf(context).width / 2.6,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 8),
          Container(color: Theme.of(context).colorScheme.outlineVariant, child: const Text('Title is here')),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
