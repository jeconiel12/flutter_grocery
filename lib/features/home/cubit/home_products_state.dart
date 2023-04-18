part of 'home_products_cubit.dart';

abstract class HomeProductsState extends Equatable {
  const HomeProductsState();
}

class HomeProductsLoading extends HomeProductsState {
  const HomeProductsLoading();

  @override
  List<Object> get props => [];
}

class HomeProductsLoaded extends HomeProductsState {
  const HomeProductsLoaded(this.products);

  final List<ProductModel> products;

  @override
  List<Object> get props => [products];
}

class HomeProductsFailed extends HomeProductsState {
  const HomeProductsFailed(this.failure);

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
