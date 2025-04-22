import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/loading/grid_loading_widget.dart';
import 'package:summit_parts/features/part/logic/parts_provider.dart';
import 'package:summit_parts/features/part/ui/widget/part_widget.dart';
import 'package:summit_parts/gen/assets.gen.dart';

class PartsListScreen extends ConsumerWidget {
  const PartsListScreen({super.key});

  static const String path = '/parts';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partsAsync = ref.watch(partsProvider);
    return Scaffold(
      body: RefreshIndicator(
        displacement: 80,
        onRefresh: () async {
          if (partsAsync.isLoading) return;
          return ref.refresh(partsProvider.future);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.sizeOf(context).height / 3,
              pinned: true,
              stretch: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 4,
              shadowColor: Colors.black26,
              title: const Text('LAUNDRY PARTS'),
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
                titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Assets.images.laundryPartsBanner.image(fit: BoxFit.cover),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black54, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0.1, 0.9],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Text(
                        'Shop all Commercial and Domestic Laundry Parts for all major brands, at the lowest prices',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: switch (partsAsync) {
                AsyncData(value: final parts) => SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final part = parts[index];
                    return PartWidget(part: part, onTap: () {});
                  }, childCount: parts.length),
                ),
                AsyncError(:final error, :final isLoading) when !isLoading => SliverToBoxAdapter(
                  child: GenericError(exception: error, onRetry: () => ref.invalidate(partsProvider)),
                ),
                _ => SliverToBoxAdapter(child: GridLoadingWidget()),
              },
            ),
            SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
