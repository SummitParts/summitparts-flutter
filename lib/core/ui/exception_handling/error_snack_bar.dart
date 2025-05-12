import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:summit_parts/core/exception_handling/error_formatter.dart';

void showErrorSnackBar(BuildContext context, Object? exception, {SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(FontAwesomeIcons.triangleExclamation, color: Theme.of(context).colorScheme.onError),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              ErrorFormatter.format(exception is Exception ? exception : Exception(exception)),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onError),
            ),
          ),
        ],
      ),
      action: action,
      duration: const Duration(seconds: 5),
      backgroundColor: Theme.of(context).colorScheme.error,
    ),
  );
}
