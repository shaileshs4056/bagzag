import 'package:flutter/cupertino.dart';

class Product {
  final double? discount; // Discount in percentage (nullable)
  final ValueNotifier<bool> favorite;
  final String? productTitle;
  final double? totalDiscount;
  final String? imagePath;
  final double? afterDiscountPrice;
  final double? realPrice;

  Product({
    this.discount,
    required this.favorite,
    this.productTitle,
    this.totalDiscount,
    this.imagePath,
    this.afterDiscountPrice,
    this.realPrice,
  });
}

