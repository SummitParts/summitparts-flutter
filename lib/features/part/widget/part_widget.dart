import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:summit_parts/features/part/model/part.dart';

class PartWidget extends StatelessWidget {
  const PartWidget({super.key, required this.part});

  final Part part;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Image.network(
          part.imageUrl,
          width: MediaQuery.sizeOf(context).width / 2.5,
          height: MediaQuery.sizeOf(context).width / 2.5,
          errorBuilder:
              (context, error, _) => SizedBox(
                width: MediaQuery.sizeOf(context).width / 2.5,
                height: MediaQuery.sizeOf(context).width / 2.5,
                child: Icon(FontAwesomeIcons.image),
              ),
        ),
        Text(part.name, style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
