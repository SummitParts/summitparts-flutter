import 'package:flutter/material.dart';
import 'package:summit_parts/features/part/model/part.dart';

class PartWidget extends StatelessWidget {
  const PartWidget({super.key, required this.part, required this.onTap});

  final Part part;
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
            part.imageUrl,
            width: MediaQuery.sizeOf(context).width / 2.6,
            height: MediaQuery.sizeOf(context).width / 2.6,
            errorBuilder:
                (context, error, _) => SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2.6,
                  height: MediaQuery.sizeOf(context).width / 2.6,
                  child: Icon(Icons.image_not_supported, size: 80, color: Theme.of(context).colorScheme.outline),
                ),
          ),
          Text(part.name, style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
