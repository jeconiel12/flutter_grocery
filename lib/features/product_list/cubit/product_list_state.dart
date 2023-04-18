part of 'product_list_cubit.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
}

class ProductListLoading extends ProductListState {
  const ProductListLoading();

  @override
  List<Object?> get props => [];
}

class ProductListFailed extends ProductListState {
  const ProductListFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

class ProductListLoaded extends ProductListState {
  const ProductListLoaded({
    this.products = const [],
    this.isLoading = false,
    this.failure,
    this.isEnd = false,
  });

  final List<ProductModel> products;
  final bool isLoading;
  final Failure? failure;
  final bool isEnd;

  ProductListLoaded copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    Failure? failure,
    bool? isEnd,
  }) {
    return ProductListLoaded(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      isEnd: isEnd ?? this.isEnd,
    );
  }

  @override
  List<Object?> get props => [
        products,
        isLoading,
        failure,
        isEnd,
      ];
}
