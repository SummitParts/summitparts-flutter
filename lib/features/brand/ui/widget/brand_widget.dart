import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:summit_parts/features/brand/model/brand.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({super.key, required this.brand});

  final Brand brand;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Image.network(
          brand.imageUrl,
          width: MediaQuery.sizeOf(context).width / 2.5,
          height: MediaQuery.sizeOf(context).width / 2.5,
          errorBuilder:
              (context, error, _) => SizedBox(
                width: MediaQuery.sizeOf(context).width / 2.5,
                height: MediaQuery.sizeOf(context).width / 2.5,
                child: Icon(FontAwesomeIcons.image),
              ),
        ),
        Text(brand.name, style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
