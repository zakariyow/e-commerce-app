import 'package:flutter/material.dart';
import 'package:flutter_ecomerce/constants/themes.dart';
import 'package:flutter_ecomerce/controllers/itempags_controller.dart';
import 'package:flutter_ecomerce/controllers/product_controller.dart';
import 'package:flutter_ecomerce/views/cart_page.dart';
import 'package:flutter_ecomerce/views/detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../widgets/ads_banner_widget.dart';
import '../widgets/card_widget.dart';
import '../widgets/chip_widget.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productNotifierProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    final itemBag = ref.watch(itemBagProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: SvgPicture.asset(
            'assets/general/store_brand_white.svg',
            color: kWhiteColor,
            width: 180,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
                top: 10,
              ),
              child: Badge(
                label: Text(itemBag.length.toString()),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.local_mall,
                    size: 30,
                  ),
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                ),
                child: CircleAvatar(
                  backgroundColor: kWhiteColor,
                  // child: SvgPicture.asset(
                  //   'assets/general/personal.svg',
                  //   color: kThirdColor,
                  //   height: 200,
                  // ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                // ads banner section
                const AdsBannerWidget(),
                // Chips section
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: const [
                      Chipwidget(chipLabel: 'All'),
                      Chipwidget(chipLabel: 'Computers'),
                      Chipwidget(chipLabel: 'Headsets'),
                      Chipwidget(chipLabel: 'Accessories'),
                      Chipwidget(chipLabel: 'Printing'),
                      Chipwidget(chipLabel: 'Camers'),
                    ],
                  ),
                ),
                // Hot seles section
                const Gap(12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hot Sales',
                      style: AppTheme.kHeadingOne,
                    ),
                    Text(
                      'See All',
                      style: AppTheme.kSeeAllText,
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.all(4),
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        ProductCardWidget(productIndex: index),
                  ),
                ),
                // Featured section
                const Gap(12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hot Sales',
                      style: AppTheme.kHeadingOne,
                    ),
                    Text(
                      'See All',
                      style: AppTheme.kSeeAllText,
                    ),
                  ],
                ),

                MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(getIndex: index),
                        )),
                    child: SizedBox(
                      height: 250,
                      child: ProductCardWidget(productIndex: index),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) => ref
                .read(currentIndexProvider.notifier)
                .update((state) => value),
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kSecondaryColor,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                activeIcon: Icon(Icons.home_filled),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: 'Favorite',
                activeIcon: Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined),
                label: 'Location',
                activeIcon: Icon(Icons.location_on),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined),
                label: 'Notification',
                activeIcon: Icon(Icons.notifications),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
                activeIcon: Icon(Icons.person),
              ),
            ]),
      ),
    );
  }
}
