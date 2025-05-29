import 'package:flutter/material.dart';

class ReadMoreText extends StatelessWidget {
  /// The text to display.
  final String text;

  /// Style for the main text.
  final TextStyle? style;

  /// How many lines to show before truncating.
  final int maxLines;

  /// What to show as the tappable link.
  final String readMoreText;

  /// Ellipsis to indicate truncation.
  final String ellipsis;

  const ReadMoreText(
    this.text, {
    super.key,
    this.style,
    this.maxLines = 6,
    this.readMoreText = 'Read more',
    this.ellipsis = '\u2026',
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = style ?? DefaultTextStyle.of(context).style;
    final linkStyle = defaultTextStyle.copyWith(color: Theme.of(context).colorScheme.primaryFixedDim);

    return LayoutBuilder(
      builder: (context, constraints) {
        // 1. Measure full text
        final textSpan = TextSpan(text: text, style: defaultTextStyle);
        final tp = TextPainter(
          text: textSpan,
          maxLines: maxLines,
          textAlign: TextAlign.start,
          textDirection: Directionality.of(context),
          ellipsis: ellipsis,
        )..layout(maxWidth: constraints.maxWidth);

        // If it fits, just show it.
        if (!tp.didExceedMaxLines) {
          return Text(text, style: defaultTextStyle);
        }

        // 2. Measure the "… Read more" link & ellipsis
        final linkSpan = TextSpan(text: readMoreText, style: linkStyle);
        tp.text = linkSpan;
        tp.layout(maxWidth: constraints.maxWidth);
        final linkSize = tp.size;

        final ellipsisSpan = TextSpan(text: ellipsis, style: defaultTextStyle);
        tp.text = ellipsisSpan;
        tp.layout(maxWidth: constraints.maxWidth);
        final ellipsisSize = tp.size;

        // 3. Restore full text to compute cutoff
        tp.text = textSpan;
        tp.layout(maxWidth: constraints.maxWidth);
        final fullSize = tp.size;

        // 4. Figure out where to cut off so we can append our link+ellipsis
        final readMoreWidth = linkSize.width + ellipsisSize.width;
        // Offset from the right edge that we must leave free
        final cutOffsetX = fullSize.width - readMoreWidth;
        final cutOffsetY = fullSize.height;

        final pos = tp.getPositionForOffset(Offset(cutOffsetX, cutOffsetY));
        final endOffset = tp.getOffsetBefore(pos.offset) ?? 0;

        // 5. Build the truncated span
        final truncatedText = text.substring(0, endOffset).trimRight();
        final truncatedSpan = TextSpan(
          style: defaultTextStyle,
          children: [
            TextSpan(text: truncatedText),
            TextSpan(text: ellipsis),
            linkSpan,
          ],
        );

        return RichText(text: truncatedSpan, maxLines: maxLines, textDirection: Directionality.of(context));
      },
    );
  }
}
