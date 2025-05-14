import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SeeAllButton extends StatelessWidget {
  const SeeAllButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: TextButton.icon(
        onPressed: onPressed,
        label: const Text('See all'),
        icon: const Icon(FontAwesomeIcons.chevronRight),
        style: TextButton.styleFrom(
          iconAlignment: IconAlignment.end,
          iconSize: 10,
          textStyle: Theme.of(context).textTheme.labelMedium,
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
      ),
    );
  }
}
