import 'package:flutter/material.dart';
import 'package:summit_parts/gen/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summit Parts')),
      body: Center(
        child: Column(
          children: [
            //
            Text('Summit Parts'),
            Assets.images.banner.image(),
          ],
        ),
      ),
    );
  }
}
