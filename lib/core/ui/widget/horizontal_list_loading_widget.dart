import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalListLoadingWidget extends StatelessWidget {
  const HorizontalListLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.outlineVariant,
      highlightColor: Theme.of(context).colorScheme.outlineVariant.withAlpha(128),
      enabled: true,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          spacing: 8,
          children: [
            for (int i = 0; i < 3; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    spacing: 8,
                    children: [
                      //
                      Container(
                        width: MediaQuery.sizeOf(context).width / 2.5,
                        height: MediaQuery.sizeOf(context).width / 2.5,
                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                      ),
                      Stack(children: [Container(color: Colors.grey, child: Text('Title is here'))]),
                      // Container(width: 80, height: 16, color: Colors.grey),
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
