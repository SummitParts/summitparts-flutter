import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/loading/horizontal_list_loading_widget.dart';
import 'package:summit_parts/features/catalog/ui/widget/category_widget.dart';
import 'package:summit_parts/features/home/logic/featured_categories_provider.dart';
import 'package:summit_parts/features/search/ui/screen/search_screen.dart';
import 'package:summit_parts/gen/assets.gen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Assets.images.summitLogo.image(height: 40),
        actions: [
          IconButton(
            onPressed: () => context.push(SearchScreen.path),
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.outlineVariant.withAlpha(100),
              iconSize: 20,
            ),
          ),
          const SizedBox(width: 2),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.cartShopping),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.outlineVariant.withAlpha(100),
              iconSize: 20,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Assets.images.banner.image(height: MediaQuery.sizeOf(context).height / 5, fit: BoxFit.cover),
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.1, 0.9],
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Summit Laundry Parts',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      Text(
                        'Shop all Commercial and Domestic Laundry Parts for all major brands, at the lowest prices',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () => context.go('/catalog/laundry_parts'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('TOP LAUNDRY PARTS CATEGORIES', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 20,
                      child: TextButton.icon(
                        onPressed: () => context.go('/catalog/laundry_parts'),
                        label: const Text('See all'),
                        icon: const Icon(FontAwesomeIcons.chevronRight),
                        style: TextButton.styleFrom(
                          iconAlignment: IconAlignment.end,
                          iconSize: 10,
                          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          visualDensity: VisualDensity.compact,
                          fixedSize: const Size.fromHeight(16),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
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
                        children:
                            parts
                                .map(
                                  (part) =>
                                      CategoryWidget(category: part, onTap: () => context.push('/catalog/${part.id}')),
                                )
                                .toList(),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('POPULAR LAUNDRY PART BRANDS', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 20,
                      child: TextButton.icon(
                        onPressed: () => context.go('/catalog/brands'),
                        label: const Text('See all'),
                        icon: const Icon(FontAwesomeIcons.chevronRight),
                        style: TextButton.styleFrom(
                          iconAlignment: IconAlignment.end,
                          iconSize: 10,
                          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          visualDensity: VisualDensity.compact,
                          fixedSize: const Size.fromHeight(16),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
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
                        children:
                            brands
                                .map(
                                  (brand) => CategoryWidget(
                                    category: brand,
                                    onTap: () => context.push('/catalog/${brand.id}'),
                                  ),
                                )
                                .toList(),
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
