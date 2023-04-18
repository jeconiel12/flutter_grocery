import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_grocery/data/data.dart';

part 'get_products_response.g.dart';

@JsonSerializable()
class GetProductsResponse extends Equatable {
  const GetProductsResponse({required this.products});

  factory GetProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductsResponseToJson(this);

  final List<ProductModel> products;

  @override
  List<Object?> get props => [products];
}
