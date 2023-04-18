import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_grocery/data/data.dart';

part 'get_product_detail_response.g.dart';

@JsonSerializable()
class GetProductDetailResponse extends Equatable {
  const GetProductDetailResponse({required this.data});

  factory GetProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProductDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductDetailResponseToJson(this);

  final ProductModel data;

  @override
  List<Object?> get props => [data];
}
