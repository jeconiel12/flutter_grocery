import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import 'package:flutter_grocery/data/data.dart';

@lazySingleton
class ProductClient {
  const ProductClient({
    required http.Client client,
  }) : _client = client;

  final http.Client _client;

  @visibleForTesting
  static const baseUrl = 'https://61ea514a7bc0550017bc66b4.mockapi.io/api/v1/';

  Future<GetProductsResponse> getProducts() async {
    final response = await _client.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('An error occurred. Please try again later.');
    }

    return GetProductsResponse.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<GetProductDetailResponse> getProductDetail(String endpoint) async {
    final response = await _client.get(Uri.parse(endpoint));

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('An error occurred. Please try again later.');
    }

    return GetProductDetailResponse.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
