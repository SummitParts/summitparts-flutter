import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FontAwesomeIcons;
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:summit_parts/core/constants/api_constants.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/loading/grid_loading_widget.dart';
import 'package:summit_parts/core/ui/widget/loading/product_loading_widget.dart';
import 'package:summit_parts/features/cart/ui/screen/cart_screen.dart';
import 'package:summit_parts/features/catalog/logic/catalog_provider.dart';
import 'package:summit_parts/features/catalog/ui/widget/category_widget.dart';
import 'package:summit_parts/features/catalog/ui/widget/product_widget.dart';
import 'package:summit_parts/features/catalog/ui/widget/read_more_text.dart';
import 'package:summit_parts/features/search/ui/screen/search_screen.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key, required this.id});

  final String id;

  static const String path = '/catalog/:id';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstPageCatalogProviderAsync = ref.watch(paginatedCatalogProvider((id: id, pageIndex: 0)));
    return Scaffold(
      body: RefreshIndicator(
        displacement: 80,
        onRefresh: () async {
          if (firstPageCatalogProviderAsync.isLoading) return;
          ref.invalidate(paginatedCatalogProvider);
          return ref.refresh(paginatedCatalogProvider((id: id, pageIndex: 0)).future);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: switch (firstPageCatalogProviderAsync) {
                AsyncData(value: final catalog) =>
                  catalog.bannerImageUrl == null ? 0 : MediaQuery.sizeOf(context).height / 3,
                _ => MediaQuery.sizeOf(context).height / 3,
              },
              pinned: true,
              stretch: true,
              shadowColor: Colors.black26,
              title: switch (firstPageCatalogProviderAsync) {
                AsyncData(value: final catalog) => Text(catalog.description),
                _ => null,
              },
              actions: [
                IconButton(
                  onPressed: () => context.push(SearchScreen.path),
                  icon: const Icon(FontAwesomeIcons.magnifyingGlass),
                  style: IconButton.styleFrom(iconSize: 20),
                  tooltip: 'Search',
                ),
                IconButton(
                  onPressed: () => context.push(CartScreen.path),
                  icon: const Icon(FontAwesomeIcons.cartShopping),
                  style: IconButton.styleFrom(iconSize: 20),
                  tooltip: 'Cart',
                ),
                const SizedBox(width: 4),
              ],
              flexibleSpace: switch (firstPageCatalogProviderAsync) {
                AsyncData(value: final catalog) =>
                  catalog.bannerImageUrl == null || catalog.bannerImageUrl!.isEmpty
                      ? null
                      : FlexibleSpaceBar(
                          stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: catalog.bannerImageUrl!,
                                fit: BoxFit.cover,
                                placeholder: (context, _) {
                                  return Shimmer.fromColors(
                                    baseColor: Theme.of(context).colorScheme.outlineVariant,
                                    highlightColor: Theme.of(context).colorScheme.surfaceBright,
                                    child: Container(color: Theme.of(context).colorScheme.outlineVariant),
                                  );
                                },
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
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.surface,
                                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                            ),
                                            child: SingleChildScrollView(
                                              child: SafeArea(
                                                child: Text(
                                                  _removeHrefTags(catalog.longDescription),
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    letterSpacing: 0.25,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.onSurface.withAlpha(178),
                                      ),
                                      child: ReadMoreText(
                                        _removeHrefTags(catalog.longDescription),
                                        maxLines: 6,
                                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: Theme.of(context).colorScheme.surface,
                                          letterSpacing: 0.25,
                                        ),
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
                    highlightColor: Theme.of(context).colorScheme.surfaceBright,
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
              sliver: switch (firstPageCatalogProviderAsync) {
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
                      final currentProductAsync = ref
                          .watch(
                            paginatedCatalogProvider((
                              id: id,
                              pageIndex: (index - catalog.categories.length) ~/ ApiConstants.pageSize,
                            )),
                          )
                          .whenData((catalogPage) {
                            return catalogPage.products.items[(index - catalog.categories.length) %
                                ApiConstants.pageSize];
                          });
                      return currentProductAsync.when(
                        data: (product) => ProductWidget(
                          product: product,
                          onTap: () => context.push('/item', extra: product),
                        ),
                        loading: () => const ProductLoadingWidget(),
                        error: (_, _) => const GenericError(),
                      );
                    }
                  }, childCount: catalog.categories.length + catalog.products.meta.totalItems),
                ),
                AsyncError(:final error, :final isLoading) when !isLoading => SliverToBoxAdapter(
                  child: GenericError(
                    exception: error,
                    onRetry: () => ref.invalidate(paginatedCatalogProvider((id: id, pageIndex: 0))),
                  ),
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
