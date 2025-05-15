import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/loading/grid_loading_widget.dart';
import 'package:summit_parts/features/catalog/ui/widget/product_widget.dart';
import 'package:summit_parts/features/search/logic/search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  static const String path = '/search';

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController searchQueryController;

  @override
  void initState() {
    super.initState();
    searchQueryController = TextEditingController();
  }

  @override
  void dispose() {
    searchQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProductsAsync = ref.watch(searchProductsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Catalog'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: searchQueryController,
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
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  ref.read(searchProductsNotifierProvider.notifier).search(value.trim());
                } else {
                  ref.read(searchProductsNotifierProvider.notifier).clear();
                }
              },
            ),
          ),
        ),
      ),
      body: searchProductsAsync.when(
        data: (value) {
          if (searchQueryController.text.isEmpty) {
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
          if (value.items.isEmpty && searchQueryController.text.isNotEmpty) {
            return Center(
              child: Text(
                'No results found for "${searchQueryController.text}"',
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
            itemCount: value.items.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(
                product: value.items[index],
                onTap: () => context.push('/item', extra: value.items[index]),
              );
            },
          );
        },
        error: (error, _) {
          return GenericError(
            exception: error,
            onRetry: () {
              if (searchQueryController.text.trim().isNotEmpty) {
                ref.read(searchProductsNotifierProvider.notifier).search(searchQueryController.text.trim());
              }
            },
          );
        },
        loading: () => const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: GridLoadingWidget()),
      ),
    );
  }
}
