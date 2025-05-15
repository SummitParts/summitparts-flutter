import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/loading/grid_loading_widget.dart';
import 'package:summit_parts/features/catalog/logic/catalog_provider.dart';
import 'package:summit_parts/features/catalog/ui/widget/category_widget.dart';
import 'package:summit_parts/features/catalog/ui/widget/product_widget.dart';

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
              expandedHeight: switch (catalogAsync) {
                AsyncData(value: final catalog) =>
                  catalog.bannerImageUrl == null ? 0 : MediaQuery.sizeOf(context).height / 3,
                _ => MediaQuery.sizeOf(context).height / 3,
              },
              pinned: true,
              stretch: true,
              shadowColor: Colors.black26,
              title: switch (catalogAsync) {
                AsyncData(value: final catalog) => Text(catalog.description),
                _ => null,
              },
              flexibleSpace: switch (catalogAsync) {
                AsyncData(value: final catalog) =>
                  catalog.bannerImageUrl == null && catalog.bannerImageUrl!.isNotEmpty
                      ? null
                      : FlexibleSpaceBar(
                        stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: catalog.bannerImageUrl!,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return Container(
                                  color: Theme.of(context).colorScheme.outlineVariant,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                );
                              },
                            ),
                            if (catalog.longDescription.isNotEmpty)
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
                                  ),
                                  child: Text(
                                    _removeHrefTags(catalog.longDescription),
                                    maxLines: 10,
                                    overflow: TextOverflow.fade,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.surface,
                                      letterSpacing: 0.25,
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              height: 80 + MediaQuery.paddingOf(context).top,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Theme.of(context).colorScheme.onSurface.withAlpha(200),
                                      Theme.of(context).colorScheme.onSurface.withAlpha(120),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                _ => Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.outlineVariant,
                    highlightColor: Theme.of(context).colorScheme.outlineVariant.withAlpha(128),
                    child: FlexibleSpaceBar(
                      stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
                      titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      collapseMode: CollapseMode.parallax,
                      background: Container(color: Colors.grey),
                    ),
                  ),
                ),
              },
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
                      return CategoryWidget(category: category, onTap: () => context.push('/catalog/${category.id}'));
                    } else {
                      final product = catalog.products.items[index - catalog.categories.length];
                      return ProductWidget(product: product, onTap: () => context.push('/item', extra: product));
                    }
                  }, childCount: catalog.categories.length + catalog.products.items.length),
                ),
                AsyncError(:final error, :final isLoading) when !isLoading => SliverToBoxAdapter(
                  child: GenericError(exception: error, onRetry: () => ref.invalidate(catalogProvider(id))),
                ),
                _ => const SliverToBoxAdapter(child: GridLoadingWidget()),
              },
            ),
            SliverToBoxAdapter(child: SizedBox(height: MediaQuery.paddingOf(context).bottom)),
          ],
        ),
      ),
    );
  }

  String _removeHrefTags(String html) {
    final hrefTagRegex = RegExp(r'<a[^>]*>(.*?)</a>', caseSensitive: false, dotAll: true);
    return html.replaceAllMapped(hrefTagRegex, (match) => match.group(1) ?? '');
  }
}
