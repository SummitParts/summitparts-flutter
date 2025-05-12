import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalListLoadingWidget extends StatelessWidget {
  const HorizontalListLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.outlineVariant,
      highlightColor: Theme.of(context).colorScheme.surfaceBright,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          spacing: 16,
          children: [
            for (int i = 0; i < 3; i++)
              Column(
                children: [
                  Column(
                    spacing: 8,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width / 2.6,
                        height: MediaQuery.sizeOf(context).width / 2.6,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        child: const Text('Title is here'),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
