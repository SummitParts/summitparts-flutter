import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:summit_parts/core/constants/html_constants.dart';
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
                child: Hero(
                  tag: product.id,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: product.imageUrl,
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
              ),
            ),
          ),
          PinnedHeaderSliver(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                product.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Item Number: ${product.id}', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  if (product.productLine != null && product.productLine!.isNotEmpty) ...[
                    Text(
                      'For ${product.productLine}',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.outline),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 16),
                  if (product.longDescription.isNotEmpty) ...[
                    Text('Description', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    HtmlWidgetWithUrlLauncher(product.longDescription),
                    const Divider(height: 32),
                  ],
                  const HtmlWidgetWithUrlLauncher(HTMLConstants.productFooter),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton(onPressed: () {}, child: const Text('Add to Cart')),
        ),
      ),
    );
  }
}
