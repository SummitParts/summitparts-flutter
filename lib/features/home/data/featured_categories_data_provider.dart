import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/catalog/model/category.dart';

final featuredCategoriesDataProvider = Provider.autoDispose<FeaturedCategoriesDataProvider>((ref) {
  return FeaturedCategoriesDataProvider();
});

class FeaturedCategoriesDataProvider {
  const FeaturedCategoriesDataProvider();

  Future<List<Category>> getFeaturedLaundryParts() async {
    return [
      Category(
        id: 'ALL_IGNITORS',
        name: 'IGNITORS',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/70367301.jpg',
      ),
      Category(
        id: 'DRAIN_VALVES',
        name: 'DRAIN VALVES',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/F200166302B.jpg',
      ),
      Category(
        id: 'LAUNDRY_CARTS_&_WHEELS',
        name: 'LAUNDRY CARTS',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/100E.jpg',
      ),
      Category(
        id: 'BELTS',
        name: 'BELTS',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/3V_Belt_Opti.jpg',
      ),
      Category(
        id: 'ALL_WATER_VALVES',
        name: 'INLET VALVES',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/9379-183-001-O.jpg',
      ),
      Category(
        id: 'ALL_RELAYS',
        name: 'RELAYS',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/510109-O.jpg',
      ),
    ];
  }

  Future<List<Category>> getFeaturedBrands() async {
    return [
      Category(
        id: 'WHIRLPOOL',
        name: 'WHIRLPOOL',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/Shop-Whirlpool-parts-1.jpg',
      ),
      Category(
        id: 'LG',
        name: 'LG',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/Shop-LG-parts.png',
      ),
      Category(
        id: 'MAYTAG',
        name: 'MAYTAG',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/Shop-Maytag-parts.jpg',
      ),
      Category(
        id: 'DEXTER',
        name: 'DEXTER',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/Shop-Dexter-parts.jpg',
      ),
      Category(
        id: 'WASCOMAT',
        name: 'WASCOMAT',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/wascomat-logo.jpeg',
      ),
      Category(
        id: 'GIRBAU',
        name: 'GIRBAU',
        imageUrl: 'https://www.summitparts.com/wp-content/uploads/2021/05/Shop-Girbau-parts.jpg',
      ),
    ];
  }
}
