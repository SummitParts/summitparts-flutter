import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/horizontal_list_loading_widget.dart';
import 'package:summit_parts/features/brand/logic/brands_provider.dart';
import 'package:summit_parts/features/brand/ui/widget/brand_widget.dart';
import 'package:summit_parts/features/part/logic/parts_provider.dart';
import 'package:summit_parts/features/part/widget/part_widget.dart';
import 'package:summit_parts/gen/assets.gen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Assets.images.summitLogo.image(height: 40)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Assets.images.banner.image(),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0.1, 0.9],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Summit Laundry Parts',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      Text(
                        'Shop all Commercial and Domestic Laundry Parts for all major brands, at the lowest prices',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOP LAUNDRY PARTS CATEGORIES', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 20,
                      child: TextButton.icon(
                        onPressed: () {},
                        label: Text('See all'),
                        icon: Icon(FontAwesomeIcons.chevronRight),
                        style: TextButton.styleFrom(
                          iconAlignment: IconAlignment.end,
                          iconSize: 10,
                          textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          visualDensity: VisualDensity.compact,
                          fixedSize: Size.fromHeight(16),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ref
                .watch(featuredPartsProvider)
                .when(
                  data: (parts) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        spacing: 16,
                        children: parts.map((part) => PartWidget(part: part, onTap: () {})).toList(),
                      ),
                    );
                  },
                  error: (error, _) => GenericError(exception: error),
                  loading: () => HorizontalListLoadingWidget(),
                ),
            SizedBox(height: 8),
            Divider(height: 1),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('POPULAR LAUNDRY PART BRANDS', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 20,
                      child: TextButton.icon(
                        onPressed: () {},
                        label: Text('See all'),
                        icon: Icon(FontAwesomeIcons.chevronRight),
                        style: TextButton.styleFrom(
                          iconAlignment: IconAlignment.end,
                          iconSize: 10,
                          textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          visualDensity: VisualDensity.compact,
                          fixedSize: Size.fromHeight(16),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ref
                .watch(featuredBrandsProvider)
                .when(
                  data: (brands) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        spacing: 16,
                        children: brands.map((brand) => BrandWidget(brand: brand, onTap: () {})).toList(),
                      ),
                    );
                  },
                  error: (error, _) => GenericError(exception: error),
                  loading: () => HorizontalListLoadingWidget(),
                ),
          ],
        ),
      ),
    );
  }
}
