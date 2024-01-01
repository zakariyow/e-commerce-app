import 'package:flutter/material.dart';
import 'package:flutter_ecomerce/controllers/itempags_controller.dart';
import 'package:flutter_ecomerce/controllers/product_controller.dart';
import 'package:flutter_ecomerce/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../constants/themes.dart';

class ProductCardWidget extends ConsumerWidget {
  const ProductCardWidget({
    super.key,
    required this.productIndex,
  });
  final int productIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    final product = ref.watch(productNotifierProvider);
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2)
        ],
      ),
      margin: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              color: kLightBackground,
              child: Image.asset(product[productIndex].imgUrl),
            ),
          ),
          const Gap(4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product[productIndex].title,
                  style: AppTheme.kCardTitle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product[productIndex].shortDescription,
                  style: AppTheme.kBodyText,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product[productIndex].price}',
                      style: AppTheme.kCardTitle,
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(productNotifierProvider.notifier)
                            .isSelectedItem(
                                product[productIndex].pid, productIndex);

                        // item ayuu ku darayaa markan
                        if (product[productIndex].isSelected == false) {
                          ref.read(itemBagProvider.notifier).AddNewItemBag(
                                ProductModel(
                                  pid: product[productIndex].pid,
                                  imgUrl: product[productIndex].imgUrl,
                                  title: product[productIndex].title,
                                  price: product[productIndex].price,
                                  shortDescription:
                                      product[productIndex].shortDescription,
                                  longDescription:
                                      product[productIndex].longDescription,
                                  review: product[productIndex].review,
                                  rating: product[productIndex].rating,
                                ),
                              );
                        } else {
                          ref
                              .read(itemBagProvider.notifier)
                              .removeItem(product[productIndex].pid);
                        }
                      },
                      icon: Icon(
                        product[productIndex].isSelected
                            ? Icons.check_circle
                            : Icons.add_circle,
                        size: 30,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
