import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridLoadingWidget extends StatelessWidget {
  const GridLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.outlineVariant,
      highlightColor: Theme.of(context).colorScheme.surfaceBright,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Column(
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
              Stack(
                children: [
                  Container(color: Theme.of(context).colorScheme.outlineVariant, child: const Text('Title is here')),
                ],
              ),
              const SizedBox(height: 4),
            ],
          );
        },
      ),
    );
  }
}
