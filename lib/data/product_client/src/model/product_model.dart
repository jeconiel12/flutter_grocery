import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.unit,
    required this.discountPrice,
    this.detailEndpoint,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  final int id;

  final String name;

  @JsonKey(name: 'default_image_url')
  final String imageUrl;

  @JsonKey(name: 'product_selling_price')
  final String price;

  @JsonKey(name: 'product_discount_price')
  final String discountPrice;

  final String unit;

  @JsonKey(name: 'detail-endpoint')
  final String? detailEndpoint;

  final String? description;

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        price,
        discountPrice,
        unit,
        detailEndpoint,
        description,
      ];
}

extension ProductExtension on ProductModel {
  int get discountPercentage {
    final priceValue = int.tryParse(price) ?? 0;
    final discountPriceValue = int.tryParse(discountPrice) ?? 0;

    if (discountPriceValue <= 0 || priceValue <= 0) {
      return 0;
    }

    final discount = priceValue - discountPriceValue;

    return (discount / priceValue * 100).ceil();
  }

  bool get hasDiscount {
    return (double.tryParse(discountPrice) ?? 0) > 0;
  }
}
