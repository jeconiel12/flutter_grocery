// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['default_image_url'] as String,
      price: json['product_selling_price'] as String,
      unit: json['unit'] as String,
      discountPrice: json['product_discount_price'] as String,
      detailEndpoint: json['detail-endpoint'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'default_image_url': instance.imageUrl,
      'product_selling_price': instance.price,
      'product_discount_price': instance.discountPrice,
      'unit': instance.unit,
      'detail-endpoint': instance.detailEndpoint,
      'description': instance.description,
    };
