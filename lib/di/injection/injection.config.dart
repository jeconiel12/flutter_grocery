// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_grocery/data/data.dart' as _i6;
import 'package:flutter_grocery/data/product_client/src/product_client.dart'
    as _i4;
import 'package:flutter_grocery/di/modules/http.module.dart' as _i11;
import 'package:flutter_grocery/domain/domain.dart' as _i8;
import 'package:flutter_grocery/domain/product/product_repository.dart' as _i5;
import 'package:flutter_grocery/features/home/cubit/home_products_cubit.dart'
    as _i7;
import 'package:flutter_grocery/features/product_detail/cubit/product_detail_cubit.dart'
    as _i9;
import 'package:flutter_grocery/features/product_list/cubit/product_list_cubit.dart'
    as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final httpInjection = _$HttpInjection();
    gh.factory<_i3.Client>(() => httpInjection.client);
    gh.lazySingleton<_i4.ProductClient>(
        () => _i4.ProductClient(client: gh<_i3.Client>()));
    gh.lazySingleton<_i5.ProductRepository>(
        () => _i5.ProductRepository(productClient: gh<_i6.ProductClient>()));
    gh.factory<_i7.HomeProductsCubit>(() =>
        _i7.HomeProductsCubit(productRepository: gh<_i8.ProductRepository>()));
    gh.factoryParam<_i9.ProductDetailCubit, String, dynamic>((
      endpoint,
      _,
    ) =>
        _i9.ProductDetailCubit(
          endpoint: endpoint,
          productRepository: gh<_i8.ProductRepository>(),
        ));
    gh.factoryParam<_i10.ProductListCubit, int?, dynamic>((
      lastPage,
      _,
    ) =>
        _i10.ProductListCubit(
          lastPage: lastPage,
          productRepository: gh<_i8.ProductRepository>(),
        ));
    return this;
  }
}

class _$HttpInjection extends _i11.HttpInjection {}
