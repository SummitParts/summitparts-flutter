import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/core/ui/widget/loading/horizontal_list_loading_widget.dart';
import 'package:summit_parts/features/brand/logic/brands_provider.dart';
import 'package:summit_parts/features/brand/ui/screen/brands_list_screen.dart';
import 'package:summit_parts/features/brand/ui/widget/brand_widget.dart';
import 'package:summit_parts/features/item/model/item.dart';
import 'package:summit_parts/features/item/ui/screen/item_screen.dart';
import 'package:summit_parts/features/part/logic/parts_provider.dart';
import 'package:summit_parts/features/part/ui/screen/parts_list_screen.dart';
import 'package:summit_parts/features/part/ui/widget/part_widget.dart';
import 'package:summit_parts/gen/assets.gen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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
                Assets.images.banner.image(height: MediaQuery.sizeOf(context).height / 5, fit: BoxFit.cover),
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
            InkWell(
              onTap: () => context.go(PartsListScreen.path),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOP LAUNDRY PARTS CATEGORIES', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 20,
                      child: TextButton.icon(
                        onPressed: () => context.go(PartsListScreen.path),
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
            InkWell(
              onTap: () => context.go(BrandsListScreen.path),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('POPULAR LAUNDRY PART BRANDS', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 20,
                      child: TextButton.icon(
                        onPressed: () => context.go(BrandsListScreen.path),
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
                        children:
                            brands
                                .map(
                                  (brand) => BrandWidget(
                                    brand: brand,
                                    onTap: () {
                                      final mockItem = Item(
                                        id: 'NBAGLG-210',
                                        name: 'PREMIUM LARGE NYLON LAUNDRY BAGS, 30" X 40", ASSORTED, DOZEN',
                                        imageUrl: 'https://www.summitparts.com/shop/catalog/items/NBAGLGB.jpg',
                                        forBrand: 'BAGS',
                                        price: 37.99,
                                        description:
                                            '''Premium Highest Strength Grade Large Nylon Laundry Bags with Drawstring Cord Lock Closure. Sold by the dozen, Assorted Colors.
Colors: red, blue, navy, green, yellow, black.
Size: 30"x40" Fabric: nylon high density and extra thickness.
Function: Can hold more than 50kgs. Extra special purpose: industrial, laundromat, pick up and delivery service.
HIGH DENSITY AND EXTRA STRONG - Extra-tough double-seam construction and nylon material that prevents the bag tears from spreading; Plastic head at the end of the rope to make the drawstring not easy to unravel.
ULTRA LARGE CAPACITY - Measure 30" x40" per piece; This size is big enoughfor holding 5~6 loads of laundry for each, storage in the college dorm or family use.
EASY CLOSURE - A locking drawstring closure can prevent the spill of items and tie the knot after close can keep the clothes more safe and secure in the bag while carrying laundry.
USES - Great choice for sleep away summer camp, kids can hold week period dirty clothes and take them back home, easily folded flat for future use. Multipurpose bags also can storage your bedding, towels, off season clothes, toys, blankets, pillows.
QUALITY- strong double stitching, holds up well in the washer and dryer. Secure drawstring slider to close neatly without tying.
CONVENIENT- Large enough to fit laundry hampers or baskets. Just pull out the laundrybag instead of carrying the whole hamper.
PORTABLE- Take it to the laundromat, throw it down the stairs to the laundry room or use it to easily separate your dirty clothes while traveling.
VERSATILE- These laundry bags can also be used as storage bags for comforters, blankets and stuffed animals, or keep some in the car to transport your kids sports gear.
ATTRACTIVE- Nice and pretty with a large selection of rich beautiful colors. Different colors for each of your kid’s rooms will make identification easy.''',
                                      );
                                      context.push(ItemScreen.path, extra: mockItem);
                                    },
                                  ),
                                )
                                .toList(),
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
