import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:summit_parts/core/ui/extension/widget_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resources')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('About Us'),
              onTap: () => launchUrl(Uri.https('www.summitparts.com', 'about-us'), mode: LaunchMode.inAppBrowserView),
              trailing: const Icon(FontAwesomeIcons.arrowUpRightFromSquare, size: 16),
            ),
            ListTile(
              title: const Text('Contact Us'),
              onTap: () => launchUrl(Uri.https('www.summitparts.com', 'contact-us'), mode: LaunchMode.inAppBrowserView),
              trailing: const Icon(FontAwesomeIcons.arrowUpRightFromSquare, size: 16),
            ),
            ListTile(
              title: const Text('FAQs'),
              onTap: () => launchUrl(Uri.https('www.summitparts.com', 'faqs'), mode: LaunchMode.inAppBrowserView),
              trailing: const Icon(FontAwesomeIcons.arrowUpRightFromSquare, size: 16),
            ),
            ListTile(
              title: const Text('Part Manuals'),
              onTap: () =>
                  launchUrl(Uri.https('www.summitparts.com', 'parts-manuals'), mode: LaunchMode.inAppBrowserView),
              trailing: const Icon(FontAwesomeIcons.arrowUpRightFromSquare, size: 16),
            ),
            ListTile(
              title: const Text('Free Shipping'),
              onTap: () =>
                  launchUrl(Uri.https('www.summitparts.com', 'free-shipping'), mode: LaunchMode.inAppBrowserView),
              trailing: const Icon(FontAwesomeIcons.arrowUpRightFromSquare, size: 16),
            ),
            ListTile(
              title: const Text('Return Policy'),
              onTap: () =>
                  launchUrl(Uri.https('www.summitparts.com', 'return-policy'), mode: LaunchMode.inAppBrowserView),
              trailing: const Icon(FontAwesomeIcons.arrowUpRightFromSquare, size: 16),
            ),
            ListTile(
              title: const Text('Track My Order'),
              onTap: () =>
                  launchUrl(Uri.https('www.summitparts.com', 'track-my-order'), mode: LaunchMode.inAppBrowserView),
              trailing: const Icon(FontAwesomeIcons.arrowUpRightFromSquare, size: 16),
            ),
          ].joinWith(const Divider(indent: 16, height: 1)),
        ),
      ),
    );
  }
}
