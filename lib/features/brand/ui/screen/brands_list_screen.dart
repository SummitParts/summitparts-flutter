import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/loading/grid_loading_widget.dart';
import 'package:summit_parts/features/brand/logic/brands_provider.dart';
import 'package:summit_parts/features/brand/ui/widget/brand_widget.dart';
import 'package:summit_parts/gen/assets.gen.dart';

class BrandsListScreen extends ConsumerWidget {
  const BrandsListScreen({super.key});

  static const String path = '/brands';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsync = ref.watch(brandsProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height / 3,
            pinned: true,
            stretch: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            elevation: 4,
            shadowColor: Colors.black26,
            title: const Text('Brands'),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
              titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Assets.images.brandsBanner.image(fit: BoxFit.cover),
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
                      'Shop all the top-selling Laundry Machine Brands in the industry. Browse all the parts for your machine by brand. We offer the largest inventory from all of the popular laundry brands, from Alliance to Whirlpool, we have you covered!',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: switch (brandsAsync) {
              AsyncData(value: final brands) => SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final brand = brands[index];
                  return BrandWidget(brand: brand, onTap: () {});
                }, childCount: brands.length),
              ),
              AsyncError(:final error, :final isLoading) when !isLoading => SliverToBoxAdapter(
                child: GenericError(exception: error, onRetry: () => ref.invalidate(brandsProvider)),
              ),
              _ => SliverToBoxAdapter(child: GridLoadingWidget()),
            },
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
