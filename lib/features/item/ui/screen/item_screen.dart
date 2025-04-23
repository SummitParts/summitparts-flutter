import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:summit_parts/features/item/model/item.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key, required this.item});

  final Item item;
  static const String path = '/item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height / 4,
            pinned: true,
            stretch: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      child: Icon(Icons.image_not_supported, size: 80, color: Theme.of(context).colorScheme.outline),
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
                  item.name,
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
                    'Item Number: ${item.id}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  if (item.forBrand != null) ...[
                    Text(
                      'For ${item.forBrand}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.outline),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (item.description != null) ...[
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    HtmlWidget(item.description!),
                  ],
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
