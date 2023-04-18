part of 'product_detail_cubit.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();
}

class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();

  @override
  List<Object?> get props => [];
}

class ProductDetailLoaded extends ProductDetailState {
  const ProductDetailLoaded(this.product);

  final ProductModel product;

  @override
  List<Object?> get props => [product];
}

class ProductDetailFailed extends ProductDetailState {
  const ProductDetailFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
