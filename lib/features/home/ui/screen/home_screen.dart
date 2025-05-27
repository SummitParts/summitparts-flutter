import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/loading/horizontal_list_loading_widget.dart';
import 'package:summit_parts/features/cart/ui/screen/cart_screen.dart';
import 'package:summit_parts/features/catalog/ui/widget/category_widget.dart';
import 'package:summit_parts/features/home/logic/featured_categories_provider.dart';
import 'package:summit_parts/features/home/ui/widget/see_all_button.dart';
import 'package:summit_parts/features/search/ui/screen/search_screen.dart';
import 'package:summit_parts/gen/assets.gen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Assets.images.summitLogo.image(height: 40),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
            onPressed: () => context.push(SearchScreen.path),
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
            style: IconButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.surfaceBright, iconSize: 20),
          ),
          IconButton(
            onPressed: () => context.push(CartScreen.path),
            icon: const Icon(FontAwesomeIcons.cartShopping),
            style: IconButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.surfaceBright, iconSize: 20),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Assets.images.banner.image(fit: BoxFit.cover),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.1, 0.8],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Summit Laundry Parts',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                        ),
                        Text(
                          'Shop all Commercial and Domestic Laundry Parts for all major brands, at the lowest prices',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => context.go('/catalog/laundry_parts'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  spacing: 4,
                  children: [
                    Expanded(
                      child: Text(
                        'TOP LAUNDRY PARTS CATEGORIES',
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SeeAllButton(onPressed: () => context.go('/catalog/laundry_parts')),
                  ],
                ),
              ),
            ),
            ref
                .watch(featuredPartsProvider)
                .when(
                  data: (parts) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        spacing: 16,
                        children: parts.map((part) {
                          return CategoryWidget(category: part, onTap: () => context.push('/catalog/${part.id}'));
                        }).toList(),
                      ),
                    );
                  },
                  error: (error, _) => GenericError(exception: error),
                  loading: () => const HorizontalListLoadingWidget(),
                ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            InkWell(
              onTap: () => context.go('/catalog/brands'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  spacing: 4,
                  children: [
                    Expanded(
                      child: Text(
                        'POPULAR LAUNDRY PART BRANDS',
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SeeAllButton(onPressed: () => context.go('/catalog/brands')),
                  ],
                ),
              ),
            ),
            ref
                .watch(featuredBrandsProvider)
                .when(
                  data: (brands) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        spacing: 16,
                        children: brands.map((brand) {
                          return CategoryWidget(category: brand, onTap: () => context.push('/catalog/${brand.id}'));
                        }).toList(),
                      ),
                    );
                  },
                  error: (error, _) => GenericError(exception: error),
                  loading: () => const HorizontalListLoadingWidget(),
                ),
          ],
        ),
      ),
    );
  }
}
