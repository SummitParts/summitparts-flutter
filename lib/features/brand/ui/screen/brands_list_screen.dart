import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/features/brand/logic/brands_provider.dart';
import 'package:summit_parts/features/brand/ui/widget/brand_widget.dart';
import 'package:summit_parts/gen/assets.gen.dart';

class BrandsListScreen extends ConsumerWidget {
  const BrandsListScreen({super.key});

  static const String path = '/brands';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsync = ref.watch(brandsProvider);
    final bannerHeight = MediaQuery.sizeOf(context).height / 3;
    final bannerText =
        'Shop all the top-selling Laundry Machine Brands in the industry. Browse all the parts for your machine by brand. We offer the largest inventory from all of the popular laundry brands, from Alliance to Whirlpool, we have you covered!';

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: bannerHeight,
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
                      bannerText,
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
                  return BrandWidget(
                    brand: brand,
                    onTap: () {
                      // TODO: Navigate to brand details or products
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected ${brand.name}')));
                    },
                  );
                }, childCount: brands.length),
              ),
              AsyncError(:final error, :final isLoading) when !isLoading => SliverToBoxAdapter(
                child: GenericError(
                  exception: error,
                  onRetry: () {
                    ref.invalidate(brandsProvider);
                  },
                ),
              ),
              _ => SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Theme.of(context).colorScheme.outlineVariant,
                      highlightColor: Theme.of(context).colorScheme.outlineVariant.withAlpha(128),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width / 2.6,
                            height: MediaQuery.sizeOf(context).width / 2.6,
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                          ),
                          const SizedBox(height: 8),
                          Container(width: 80, height: 16, color: Colors.grey),
                          const SizedBox(height: 4),
                        ],
                      ),
                    );
                  },
                  childCount: 6, // Show 6 loading items
                ),
              ),
            },
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
