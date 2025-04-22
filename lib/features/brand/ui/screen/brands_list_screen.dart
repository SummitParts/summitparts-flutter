import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:summit_parts/features/brand/logic/brands_provider.dart';
import 'package:summit_parts/features/brand/model/brand.dart';
import 'package:summit_parts/features/brand/ui/widget/brand_widget.dart';
import 'package:summit_parts/gen/assets.gen.dart';

class BrandsListScreen extends ConsumerWidget {
  const BrandsListScreen({super.key});

  static const String path = '/brands';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsync = ref.watch(brandsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Brands')),
      body: brandsAsync.when(
        loading: () => _BrandsGridLoadingWidget(),
        error: (error, stackTrace) => Center(child: Text('Error loading brands: ${error.toString()}')),
        data: (brands) => _buildBrandsGrid(context, brands),
      ),
    );
  }

  Widget _buildBrandsGrid(BuildContext context, List<Brand> brands) {
    return Column(
      children: [
        Stack(
          children: [
            Assets.images.brandsBanner.image(height: MediaQuery.sizeOf(context).height / 5, fit: BoxFit.cover),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
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
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ],
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return BrandWidget(
                brand: brand,
                onTap: () {
                  // TODO: Navigate to brand details or products
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected ${brand.name}')));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BrandsGridLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.outlineVariant,
      highlightColor: Theme.of(context).colorScheme.outlineVariant.withAlpha(128),
      enabled: true,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 6, // Show 6 loading items
        itemBuilder: (context, index) {
          return Column(
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
          );
        },
      ),
    );
  }
}
