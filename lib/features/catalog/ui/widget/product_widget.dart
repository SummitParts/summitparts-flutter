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
              children: [
                Center(
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
                if (true)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '\$${product.price}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(product.id, style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          Text(
            product.name,
            style: TextStyle(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
