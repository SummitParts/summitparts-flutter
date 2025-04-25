import 'package:flutter/material.dart';
import 'package:summit_parts/features/catalog/model/category.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.category, required this.onTap});

  final Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        spacing: 8,
        children: [
          Image.network(
            category.imageUrl,
            width: MediaQuery.sizeOf(context).width / 2.6,
            height: MediaQuery.sizeOf(context).width / 2.6,
            errorBuilder:
                (context, error, _) => SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2.6,
                  height: MediaQuery.sizeOf(context).width / 2.6,
                  child: Icon(Icons.image_not_supported, size: 80, color: Theme.of(context).colorScheme.outline),
                ),
          ),
          Text(category.name, style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
