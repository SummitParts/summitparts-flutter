import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/loading/grid_loading_widget.dart';
import 'package:summit_parts/features/catalog/logic/catalog_provider.dart';
import 'package:summit_parts/features/catalog/ui/widget/category_widget.dart';
import 'package:summit_parts/features/catalog/ui/widget/product_widget.dart';
import 'package:summit_parts/gen/assets.gen.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key, required this.id});

  final String id;

  static const String path = '/catalog/:id';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(catalogProvider(id));
    return Scaffold(
      body: RefreshIndicator(
        displacement: 80,
        onRefresh: () async {
          if (catalogAsync.isLoading) return;
          return ref.refresh(catalogProvider(id).future);
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
              title: const Text('BRANDS'),
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
              sliver: switch (catalogAsync) {
                AsyncData(value: final catalog) => SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index < catalog.categories.length) {
                      final category = catalog.categories[index];
                      return CategoryWidget(
                        category: category,
                        onTap: () {
                          context.push('/catalog/${category.id}');
                        },
                      );
                    } else {
                      final product = catalog.products.items[index - catalog.categories.length];
                      return ProductWidget(
                        product: product,
                        onTap: () {
                          context.push('/item/${product.id}');
                        },
                      );
                    }
                  }, childCount: catalog.categories.length + catalog.products.items.length),
                ),
                AsyncError(:final error, :final stackTrace, :final isLoading) when !isLoading => SliverToBoxAdapter(
                  child: GenericError(
                    exception: error,
                    onRetry: () {
                      print(error);
                      print(stackTrace);
                      ref.invalidate(catalogProvider(id));
                    },
                  ),
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
