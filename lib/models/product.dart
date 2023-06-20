import 'package:freezed_annotation/freezed_annotation.dart';

import '../config.dart';
import 'category.dart';
part 'product.freezed.dart';
part 'product.g.dart';

List<Product> productFromJson(dynamic str) =>
    List<Product>.from((str).map((e) => Product.fromJson(e)));

@freezed
abstract class Product with _$Product {
  factory Product({
    required String productName,
    required Category category,
    required String? productShortDescription,
    required String? productDescription,
    required double productPrice,
    required double productSalePrice,
    required String productImage,
    required String? productSKU,
    required String? productType,
    required String? stackStatus,
    required String productId,
    List<String>? relatedProducts,
  }) = _Product;
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

extension ProductExt on Product {
  String get fullImagePath => Config.imageURL + productImage;

  int get calculateDiscount {
    double disPercent = 0;

    if (!productPrice.isNaN) {
      double regular_price = productPrice;
      double sale_price =
          productSalePrice > 0 ? productSalePrice : regular_price;
      double discount = regular_price - sale_price;
      disPercent = (discount / regular_price) * 100;
    }
    return disPercent.round();
  }
}