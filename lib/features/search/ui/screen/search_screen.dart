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
  late final TextEditingController _searchQueryController;

  @override
  void initState() {
    super.initState();
    _searchQueryController = TextEditingController();
  }

  @override
  void dispose() {
    _searchQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProductsAsync = ref.watch(searchProductsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Catalog'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _searchQueryController,
              decoration: InputDecoration(
                hintText: 'Search for parts...',
                prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  ref.read(searchProductsNotifierProvider.notifier).search(value);
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
          if (_searchQueryController.text.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.magnifyingGlass, size: 64, color: Theme.of(context).colorScheme.outline),
                  SizedBox(height: 16),
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
          if (value.items.isEmpty && _searchQueryController.text.isNotEmpty) {
            return Center(
              child: Text(
                'No results found for "${_searchQueryController.text}"',
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
        error: (error, st) => GenericError(exception: error),
        loading: () => Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: GridLoadingWidget()),
      ),
    );
  }
}
