import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/productCart.dart';
import '../models/pagination.dart';
import '../models/product.dart';
import '../models/product_filter.dart';
import '../providers.dart';

class HomeProductsWidget extends ConsumerWidget {
  const HomeProductsWidget({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 15),
                child: Text(
                  "Top 10 Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: _productList(ref),
          ),
        ],
      ),
    );
  }

  Widget _productList(WidgetRef ref) {
    final products = ref.watch(
      homeProductProvider(
        ProductFilterModel(
          paginationModel: PaginationModel(page: 1, pageSize: 10),
        ),
      ),
    );

    return products.when(
        data: (list) {
          return _builProductList(list!, ref);
        },
        error: (_, __) {
          return const Center(child: Text("ERROR"));
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }

  Widget _builProductList(List<Product> product, WidgetRef ref) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: product.length,
        itemBuilder: (context, index) {
          var data = product[index];

          return GestureDetector(
              onTap: () {},
              child: ProductCard(
                model: data,
                addFavorite: (productId) {
                  final favoriteModel = ref.read(favoriteItemProvider.notifier);
                  favoriteModel.addFavoriteItem(productId);
                }, isFavorite: data.isFavorite!,
              ));
        },
      ),
    );
  }
}
