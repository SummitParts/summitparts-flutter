import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:summit_parts/features/catalog/model/product.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: product.id,
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    errorWidget:
                        (context, url, error) => SizedBox(
                          width: MediaQuery.sizeOf(context).width / 2.6,
                          height: MediaQuery.sizeOf(context).width / 2.6,
                          child: Icon(
                            Icons.image_not_supported,
                            size: 80,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                  ),
                ),
                Positioned(top: 8, left: 8, child: PriceTag(price: product.price)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(product.id, style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
          Text(product.name, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  const PriceTag({super.key, required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(4)),
      child: Text(
        '\$$price',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
