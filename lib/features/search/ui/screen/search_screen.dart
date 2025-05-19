import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_parts/core/constants/api_constants.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/loading/grid_loading_widget.dart';
import 'package:summit_parts/core/ui/widget/loading/product_loading_widget.dart';
import 'package:summit_parts/features/catalog/ui/widget/product_widget.dart';
import 'package:summit_parts/features/search/logic/search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  static const String path = '/search';

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  void deactivate() {
    if (mounted) {
      ref.invalidate(searchProductsCountProvider);
      ref.invalidate(paginatedSearchProductsProvider);
      ref.invalidate(searchQueryProvider);
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchProductsCountAsync = ref.watch(searchProductsCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Catalog'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for parts...',
                prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                contentPadding: EdgeInsets.zero,
              ),
              autocorrect: false,
              keyboardType: TextInputType.name,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => ref.read(searchQueryProvider.notifier).state = value.trim(),
            ),
          ),
        ),
      ),
      body: searchProductsCountAsync.when(
        loading: () => const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: GridLoadingWidget()),
        error: (error, _) {
          return GenericError(exception: error, onRetry: () => ref.invalidate(paginatedSearchProductsProvider));
        },
        data: (int count) {
          if (searchQuery.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FontAwesomeIcons.magnifyingGlass, size: 64, color: Theme.of(context).colorScheme.outline),
                  const SizedBox(height: 16),
                  Text(
                    'Search for parts',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.outline),
                  ),
                ],
              ),
            );
          }
          if (count == 0 && searchQuery.isNotEmpty) {
            return Center(
              child: Text(
                'No results found for "$searchQuery"',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.outline),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: count,
            itemBuilder: (BuildContext context, int index) {
              final currentProductAsync = ref
                  .watch(paginatedSearchProductsProvider(index ~/ ApiConstants.pageSize))
                  .whenData((pageData) => pageData.items[index % ApiConstants.pageSize]);
              return currentProductAsync.when(
                data: (product) => ProductWidget(product: product, onTap: () => context.push('/item', extra: product)),
                loading: () => const ProductLoadingWidget(),
                error: (_, _) => const GenericError(),
              );
            },
          );
        },
      ),
    );
  }
}
