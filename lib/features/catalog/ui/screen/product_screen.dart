import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:summit_parts/core/ui/widget/html_widget_with_url_launcher.dart';
import 'package:summit_parts/features/catalog/model/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});

  final Product product;

  static const String path = '/item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: max(MediaQuery.sizeOf(context).height / 4, 232),
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () {
                  showImageViewer(
                    context,
                    CachedNetworkImageProvider(product.imageUrl),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    closeButtonColor: Theme.of(context).colorScheme.onSurface,
                    useSafeArea: true,
                    doubleTapZoomable: true,
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) => Container(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        child: Icon(Icons.image_not_supported, size: 80, color: Theme.of(context).colorScheme.outline),
                      ),
                ),
              ),
            ),
          ),
          PinnedHeaderSliver(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item Number: ${product.id}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  if (product.productLine != null && product.productLine!.isNotEmpty) ...[
                    Text(
                      'For ${product.productLine}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (product.longDescription.isNotEmpty) ...[
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    HtmlWidgetWithUrlLauncher(product.longDescription),
                    Divider(height: 32),
                  ],
                  HtmlWidgetWithUrlLauncher(
                    '<p class="card-text text-muted">Buy commercial and domestic replacement laundry parts, and washer/dryer original OEM parts, here at Summit Parts. We carry the largest selection and lowest priced laundry parts for all major brands including: <a href="https://summitparts.com/catalog/alliance/">Alliance laundry parts</a>, <a href="https://summitparts.com/catalog/american_dryer">ADC parts</a>, <a href="https://summitparts.com/catalog/huebsch/">Huebsch</a>, <a href="https://summitparts.com/catalog/dexter/">Dexter</a>, <a href="https://summitparts.com/catalog/maytag/">Maytag</a>, <a href="https://summitparts.com/catalog/speed_queen/">Speed Queen parts</a>, <a href="https://summitparts.com/catalog/wascomat/">Wascomat</a>, and <a href="https://summitparts.com/catalog/whirlpool/">Whirlpool</a> laundry parts. Our popular products include; <a href="https://summitparts.com/catalog/belts/">Belts</a>, <a href="https://summitparts.com/catalog/drain_valves/">Drain Valves</a>, <a href="https://summitparts.com/catalog/all_hoses/">Hoses</a>, <a href="https://summitparts.com/catalog/all_ignitors/">Ignitor Boxes</a>, <a href="https://summitparts.com/catalog/laundry_carts_&amp;_wheels/">Laundry Carts</a>, <a href="https://summitparts.com/catalog/all_lint_screens/">Lint Screens</a>, <a href="https://summitparts.com/catalog/all_rollers/">Rollers</a>, and <a href="https://summitparts.com/catalog/all_water_valves/">Water Valves</a>. Learn more about our Free Shipping, and when you join Summit Bucks earn 3% back on every purchase.<br><br><a href="https://summitparts.com/catalog/specials/">Shop and save on all Laundry Parts Specials now</a>.</p>',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Add to Cart'),
          ),
        ),
      ),
    );
  }
}
