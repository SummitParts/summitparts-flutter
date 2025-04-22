import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:summit_parts/features/brand/model/brand.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({super.key, required this.brand, required this.onTap});

  final Brand brand;
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
            brand.imageUrl,
            width: MediaQuery.sizeOf(context).width / 2.6,
            height: MediaQuery.sizeOf(context).width / 2.6,
            errorBuilder:
                (context, error, _) => SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2.6,
                  height: MediaQuery.sizeOf(context).width / 2.6,
                  child: Icon(FontAwesomeIcons.image, size: 80),
                ),
          ),
          Text(brand.name, style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
